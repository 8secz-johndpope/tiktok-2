import UIKit

extension UIBarButtonItem {
    
    class func setCustomAppearance() {
        let customFont = UIFont.systemFont(ofSize: 15.0, weight: .medium)
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: customFont, .foregroundColor: UIColor.white], for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes([.font: customFont, .foregroundColor: UIColor.white.withAlphaComponent(0.6)], for: .highlighted)
    }
    
    class func sortBarButtonItem(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(title: Localization.sortBy, style: .plain, target: target, action: action)
    }
    
    class func exitBarButtonItem(target: Any?, action: Selector?) -> UIBarButtonItem {
        return UIBarButtonItem(image: UIImage(named: "exit"), style: .plain, target: target, action: action)
    }
}
