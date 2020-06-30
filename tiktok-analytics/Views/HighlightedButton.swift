import UIKit

class HighlightedButton: UIButton {
    
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonSetup()
    }
    
    private func commonSetup() {
        titleLabel?.numberOfLines = 1
        titleLabel?.adjustsFontSizeToFitWidth = true
        titleLabel?.lineBreakMode = .byClipping
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.alpha = 0.6
            } else {
                self.alpha = 1
            }
        }
    }

}
