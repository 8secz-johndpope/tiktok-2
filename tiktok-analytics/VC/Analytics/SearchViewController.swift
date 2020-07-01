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
    }
    
    @objc private func actionSearch() {
        guard let profile = textField.text, !profile.isEmpty else {
            coordinator?.showEmtyNameAlert()
            return
        }
        
        loadingLabel.isHidden = false
        searchButton.isUserInteractionEnabled = false
        textField.isUserInteractionEnabled = false
        
        Network.shared.send(Request(path: "users/\(1)")) { (result: Result<Profile, Error>) in
            switch result {
            case .success(let profile):
                self.coordinator?.showProfile(profile: profile)
            case .failure(let error):
                self.coordinator?.showErrorAlert(error: error.localizedDescription)
            }
            self.loadingLabel.isHidden = true
            self.searchButton.isUserInteractionEnabled = true
            self.textField.isUserInteractionEnabled = true
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
