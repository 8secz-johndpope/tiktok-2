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
    
    var coordinator: AppCoordinator?
    
    @objc private func actionSearch() {
//        guard textField.text?.isEmpty == false else {
//            coordinator?.showEmtyNameAlert()
//            return
//        }
        
//        request
        
        coordinator?.showProfile(name: Profile())
    }
}

extension SearchViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        actionSearch()
        return false
    }
}
