import UIKit

extension UIView {
    func addBlur(style: UIBlurEffect.Style = .dark, alpha: CGFloat = 0.7) {
        let blurView = UIVisualEffectView()
        addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        blurView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        blurView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        blurView.effect = UIBlurEffect(style: style)
        blurView.backgroundColor = .black
        blurView.alpha = alpha
    }
}
