import UIKit

extension UIViewController {
    
    func addBlurEffect(style: UIBlurEffect.Style? = nil) {
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = UIScreen.main.bounds
        if #available(iOS 13.0, *) {
            blurredBackgroundView.effect = UIBlurEffect(style: style ?? .systemMaterialDark)
        } else {
            blurredBackgroundView.effect = UIBlurEffect(style: style ?? .dark)
        }
        blurredBackgroundView.alpha = 0.75
        navigationController?.view.addSubview(blurredBackgroundView)
    }
    
    func removeBlurEffect() {
        guard let navigationController = navigationController else {
            return
        }
        for subview in navigationController.view.subviews where subview is UIVisualEffectView {
            subview.removeFromSuperview()
        }
    }
    
    func add(_ child: UIViewController) {
        view.addSubview(child.view)
        addChild(child)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
