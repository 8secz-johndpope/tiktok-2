import UIKit

@IBDesignable
class RadialGradientButton: UIButton {
    
    @IBInspectable var firstColor: UIColor = UIColor.clear
    @IBInspectable var secondColor: UIColor = UIColor.clear
    
    private lazy var gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.type = .radial
        gradient.colors = [ firstColor.cgColor,
                            secondColor.cgColor]
//        gradient.locations = [ 0, 0.3, 0.7, 1 ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        layer.addSublayer(gradient)
        return gradient
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
        layer.cornerRadius = 15.0
        layer.masksToBounds = true
    }
    
}
