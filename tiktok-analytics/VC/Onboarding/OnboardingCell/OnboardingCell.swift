import UIKit

class OnboardingACell: UICollectionViewCell {
    
    @IBOutlet weak var label1: UILabel! {
        didSet {
            label1.text = Localization.onboardingA1
        }
    }
    @IBOutlet weak var label2: UILabel! {
        didSet {
            label2.text = Localization.onboardingA2
        }
    }
}

class OnboardingBCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localization.onboardingBTitle
        }
    }
    @IBOutlet weak var label1: UILabel! {
        didSet {
            label1.text = Localization.onboardingB1
        }
    }
    @IBOutlet weak var label2: UILabel! {
        didSet {
            label2.text = Localization.onboardingB2
        }
    }
    @IBOutlet weak var check1ImageView: UIImageView!
    @IBOutlet weak var check2ImageView: UIImageView!
    @IBOutlet weak var check1ContainerView: UIView! {
        didSet {
            check1ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check1Tap)))
        }
    }
    @IBOutlet weak var check2ContainerView: UIView! {
        didSet {
            check2ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check2Tap)))
        }
    }
    
    @objc private func check1Tap() {
        check1ImageView.isHidden = !check1ImageView.isHidden
    }
    
    @objc private func check2Tap() {
        check2ImageView.isHidden = !check2ImageView.isHidden
    }
}

class OnboardingCCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localization.onboardingCTitle
        }
    }
    @IBOutlet weak var label1: UILabel! {
        didSet {
            label1.text = Localization.onboardingC1
        }
    }
    @IBOutlet weak var label2: UILabel! {
        didSet {
            label2.text = Localization.onboardingC2
        }
    }
    @IBOutlet weak var label3: UILabel! {
        didSet {
            label3.text = Localization.onboardingC3
        }
    }
    @IBOutlet weak var label4: UILabel! {
        didSet {
            label4.text = Localization.onboardingC4
        }
    }
    @IBOutlet weak var check1ImageView: UIImageView!
    @IBOutlet weak var check2ImageView: UIImageView!
    @IBOutlet weak var check3ImageView: UIImageView!
    @IBOutlet weak var check4ImageView: UIImageView!
    
    @IBOutlet weak var check1ContainerView: UIView! {
        didSet {
            check1ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check1Tap)))
        }
    }
    @IBOutlet weak var check2ContainerView: UIView! {
        didSet {
            check2ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check2Tap)))
        }
    }
    @IBOutlet weak var check3ContainerView: UIView! {
        didSet {
            check3ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check3Tap)))
        }
    }
    @IBOutlet weak var check4ContainerView: UIView! {
        didSet {
            check4ContainerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(check4Tap)))
        }
    }
    
    @objc private func check1Tap() {
        check1ImageView.isHidden = !check1ImageView.isHidden
    }
    
    @objc private func check2Tap() {
        check2ImageView.isHidden = !check2ImageView.isHidden
    }
    @objc private func check3Tap() {
        check3ImageView.isHidden = !check3ImageView.isHidden
    }
    
    @objc private func check4Tap() {
        check4ImageView.isHidden = !check4ImageView.isHidden
    }
}

class OnboardingDCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.text = Localization.onboardingDTitle
        }
    }
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.isHidden = true
            loadingLabel.text = Localization.loading
        }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.cornerRadius = textField.bounds.height / 2
            textField.layer.masksToBounds = true
            textField.attributedPlaceholder = NSAttributedString(string: Localization.textFieldPlaceholder,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0xA1A1A1)])
        }
    }
}
