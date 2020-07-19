import UIKit

class OnboardingACell: UICollectionViewCell { }

class OnboardingBCell: UICollectionViewCell {
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
    
    @IBOutlet weak var loadingLabel: UILabel! {
        didSet {
            loadingLabel.isHidden = true
        }
    }
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.layer.cornerRadius = textField.bounds.height / 2
            textField.layer.masksToBounds = true
            textField.attributedPlaceholder = NSAttributedString(string: "TikTok Username",
                                                                 attributes: [NSAttributedString.Key.foregroundColor: UIColor(hex: 0xA1A1A1)])
        }
    }
}
