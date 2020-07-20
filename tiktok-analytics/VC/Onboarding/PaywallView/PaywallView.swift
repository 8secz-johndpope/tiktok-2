import UIKit
import SafariServices

protocol PaywallViewDelegate: class {
    func showTerms()
    func showPrivacy()
    func purchase()
}

class PaywallView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localization.premiumTitle
        }
    }
    private let attributes: [NSAttributedString.Key: Any] = [
    .font: UIFont.systemFont(ofSize: 10, weight: .bold),
    .foregroundColor: UIColor.white,
    .underlineStyle: NSUnderlineStyle.single.rawValue]

    @IBOutlet weak var privacyButton: UIButton! {
        didSet {
            let attributeString = NSMutableAttributedString(string: Localization.privacyPolicy,
                                                            attributes: attributes)
            privacyButton.setAttributedTitle(attributeString, for: .normal)

        }
    }
    @IBOutlet weak var termsButton: UIButton! {
        didSet {
            let attributeString = NSMutableAttributedString(string: Localization.terms,
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
        let buttonText = Localization.premiumButtonTitle(UserDefaults.standard.string(forKey: Constants.productPrice) ?? "$49.99")
        purchaseButton.setTitle(buttonText, for: .normal)
        
    }
    @IBOutlet weak var infoLabel: UILabel! {
        didSet {
            infoLabel.text = Localization.subscriptionInfo
        }
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
