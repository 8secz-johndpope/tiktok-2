import UIKit
import SafariServices

protocol PaywallViewDelegate: class {
    func showTerms()
    func showPrivacy()
    func purchase()
}

class PaywallView: UIView {
    
    private let attributes: [NSAttributedString.Key: Any] = [
    .font: UIFont.systemFont(ofSize: 10, weight: .bold),
    .foregroundColor: UIColor.white,
    .underlineStyle: NSUnderlineStyle.single.rawValue]

    @IBOutlet weak var privacyButton: UIButton! {
        didSet {
            let attributeString = NSMutableAttributedString(string: "Privacy Policy",
                                                            attributes: attributes)
            privacyButton.setAttributedTitle(attributeString, for: .normal)

        }
    }
    @IBOutlet weak var termsButton: UIButton! {
        didSet {
            let attributeString = NSMutableAttributedString(string: "Terms of use",
                                                            attributes: attributes)
            termsButton.setAttributedTitle(attributeString, for: .normal)
        }
    }

    
    @IBOutlet weak var purchaseButton: UIButton! {
        didSet {
            purchaseButton.titleLabel?.numberOfLines = 0
            purchaseButton.titleLabel?.textAlignment = .center
        }
    }
    
    weak var delegate: PaywallViewDelegate?
    
    func setup() {
        let buttonText = String(format: "Start your free 3-day trial\n%@/year", UserDefaults.standard.string(forKey: Constants.productPrice) ?? "$49.99")
        purchaseButton.setTitle(buttonText, for: .normal)
        
    }
    
    @IBAction func actionPurchase() {
        delegate?.purchase()
    }
    
    @IBAction func actionTerms() {
        delegate?.showTerms()
    }
    @IBAction func actionPrivacy() {
        delegate?.showPrivacy()
    }
}
