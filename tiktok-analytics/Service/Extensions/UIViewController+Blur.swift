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
}
