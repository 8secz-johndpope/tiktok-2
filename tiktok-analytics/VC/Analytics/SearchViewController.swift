import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.cornerRadius = 15.0
            textField.layer.masksToBounds = true
            textField.delegate = self
        }
    }
    @IBOutlet weak var searchButton: HighlightedButton! {
        didSet {
            searchButton.addTarget(self, action: #selector(actionSearch), for: .touchUpInside)
        }
    }
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var centerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.isHidden = true
        }
    }
    
    var coordinator: AppCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        guard let savedProfile = UserDefaults.standard.string(forKey: Constants.savedProfile) else {
            return
        }
        textField.text = savedProfile
        actionSearch()
    }
    
    @objc private func actionSearch() {
        guard let text = textField.text, !text.isEmpty else {
            coordinator?.showEmtyNameAlert()
            return
        }
        
        loadingLabel.isHidden = false
        searchButton.isUserInteractionEnabled = false
        textField.isUserInteractionEnabled = false
        Network.getUser(user: text) { result in
            onMain {
                switch result {
                case .success(let profile):
                    UserDefaults.standard.set(text, forKey: Constants.savedProfile)
                    self.coordinator?.showProfile(profile: profile)
                case .failure(let error):
                    self.coordinator?.showErrorAlert(error: error.localizedDescription)
                }
                self.loadingLabel.isHidden = true
                self.searchButton.isUserInteractionEnabled = true
                self.textField.isUserInteractionEnabled = true
            }
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        centerYConstraint.isActive = false
        bottomConstraint.isActive = true
        bottomConstraint.constant = keyboardSize.height + 20.0
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        bottomConstraint.isActive = false
        centerYConstraint.isActive = true
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionSearch()
        textField.resignFirstResponder()
        return false
    }
}
