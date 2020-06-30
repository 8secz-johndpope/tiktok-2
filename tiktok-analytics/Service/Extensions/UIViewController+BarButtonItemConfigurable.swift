import UIKit

public enum RightBarButtonItem: Int {
    
    case none
    case sort
    case exit
}

public enum LeftBarButtonItem: Int {
    case none
}

public protocol BarButtonItemConfigurable: class {
    var leftBarButtonItemType: LeftBarButtonItem { get }
    var rightBarButtonItemType: RightBarButtonItem { get }
}

extension BarButtonItemConfigurable {
    var leftBarButtonItemType: LeftBarButtonItem { return .none }
    var rightBarButtonItemType: RightBarButtonItem { return .none }
}

extension BarButtonItemConfigurable where Self: UIViewController {
    
    func refreshRightBarButtonItem() {
        switch rightBarButtonItemType {
        case .sort:
            navigationItem.setRightBarButtonItems([UIBarButtonItem.sortBarButtonItem(target: self, action: #selector(actionSort))], animated: false)
        case .none:
            navigationItem.setRightBarButtonItems(nil, animated: false)
        case .exit:
            navigationItem.setRightBarButtonItems([UIBarButtonItem.exitBarButtonItem(target: self, action: #selector(actionExit))], animated: false)
        }
    }
    
    func refreshLeftBarButtonItem() {
        switch leftBarButtonItemType {
        case .none:
            navigationItem.hidesBackButton = true
        }
    }
}

extension UIViewController {
    @objc func actionSort() {}
    @objc func actionExit() {}
}
