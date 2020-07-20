import UIKit

class OnboradingViewController: UIViewController {
    
    @IBOutlet weak var videoContainerView: VideoContainerView!
    
    @IBOutlet weak var collectionConatinerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(UINib(nibName: "\(OnboardingACell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OnboardingACell.self)")
            collectionView.register(UINib(nibName: "\(OnboardingBCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OnboardingBCell.self)")
            collectionView.register(UINib(nibName: "\(OnboardingCCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OnboardingCCell.self)")
            collectionView.register(UINib(nibName: "\(OnboardingDCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(OnboardingDCell.self)")
            collectionView.isScrollEnabled = false
        }
    }
    @IBOutlet weak var continueButton: UIButton! {
        didSet {
            continueButton.addTarget(self, action: #selector(actionNext), for: .touchUpInside)
            continueButton.setTitle("Continue", for: .normal)
        }
    }
    
    @IBOutlet weak var profileConatainerView: UIView!
    @IBOutlet weak var premiumContainerView: UIView!
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = UIDevice.current.isPad ? 70 : 50
            avatarImageView.layer.borderWidth = 2.0
            avatarImageView.layer.borderColor = UIColor.white.cgColor
            avatarImageView.layer.masksToBounds = true
            avatarImageView.addBlur(style: .light, alpha: 0.5)
        }
    }
    
    private lazy var paywallView: PaywallView = {
        guard let view = Bundle.main.loadNibNamed("\(PaywallView.self)", owner: nil, options: nil)?.first as? PaywallView else { return PaywallView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var infoView: InfoView = {
        var view: InfoView!
        if UIDevice.current.isPad {
            view = Bundle.main.loadNibNamed("\(InfoView.self)", owner: nil, options: nil)?[1] as? InfoView
        } else {
            view = Bundle.main.loadNibNamed("\(InfoView.self)", owner: nil, options: nil)?.first as? InfoView
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var coordinator: AppCoordinator?
    
    private var currentPage = 0 {
        willSet {
            if newValue == 3 { continueButton.setTitle("Analyse", for: .normal) }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        premiumContainerView.addSubview(paywallView)
        paywallView.leftAnchor.constraint(equalTo: premiumContainerView.leftAnchor).isActive = true
        paywallView.topAnchor.constraint(equalTo: premiumContainerView.topAnchor).isActive = true
        paywallView.rightAnchor.constraint(equalTo: premiumContainerView.rightAnchor).isActive = true
        paywallView.bottomAnchor.constraint(equalTo: premiumContainerView.bottomAnchor).isActive = true
        
        profileConatainerView.addSubview(infoView)
        infoView.leftAnchor.constraint(equalTo: profileConatainerView.leftAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: profileConatainerView.topAnchor).isActive = true
        infoView.rightAnchor.constraint(equalTo: profileConatainerView.rightAnchor).isActive = true
        infoView.bottomAnchor.constraint(equalTo: profileConatainerView.bottomAnchor).isActive = true
    }
    
    @objc private func actionNext() {
        if currentPage == 3 {
            let cell = collectionView.cellForItem(at: IndexPath(row: 3, section: 0)) as! OnboardingDCell
            loadProfile(name: cell.textField.text)
            return
        }
        
        collectionView.scrollToItem(at: IndexPath(row: currentPage + 1, section: 0),
                                    at: .centeredHorizontally, animated: true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        bottomConstraint.constant = keyboardSize.height
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc private func keyboardWillHide() {
        bottomConstraint.constant = 0.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func loadProfile(name: String?) {
        
        guard let name = name, !name.isEmpty,
            let cell = collectionView.cellForItem(at: IndexPath(row: 3, section: 0)) as? OnboardingDCell else {
            coordinator?.showEmtyNameAlert()
            return
        }
        
        cell.loadingLabel.isHidden = false
        continueButton.isUserInteractionEnabled = false
        cell.textField.isUserInteractionEnabled = false
        
        Network.getUser(user: name) { result in
            onMain {
                switch result {
                case .success(let profile):
                    UserDefaults.standard.set(name, forKey: Constants.savedProfile)
                    self.showPremium(profile: profile)
                case .failure(let error):
                    self.coordinator?.showErrorAlert(error: error.localizedDescription)
                }
                cell.loadingLabel.isHidden = true
                self.continueButton.isUserInteractionEnabled = true
                cell.textField.isUserInteractionEnabled = true
            }
        }
    }
    
    private func showPremium(profile: Profile) {
        paywallView.setup()
        collectionConatinerView.isHidden = true
        profileConatainerView.isHidden = false
        premiumContainerView.isHidden = false
        avatarImageView.isHidden = false
        infoView.setup(withProfile: profile)
        avatarImageView.kf.setImage(with: profile.avatar)
    }
}

extension OnboradingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.row {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OnboardingACell.self)", for: indexPath)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OnboardingBCell.self)", for: indexPath)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OnboardingCCell.self)", for: indexPath)
            return cell
        case 3:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(OnboardingDCell.self)", for: indexPath) as! OnboardingDCell
            cell.textField.delegate = self
            return cell
        default: return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let center = CGPoint(x: scrollView.contentOffset.x + (scrollView.frame.width / 2), y: (scrollView.frame.height / 2))
        guard let indexPath = collectionView.indexPathForItem(at: center) else { return }
        currentPage = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
}

extension OnboradingViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

extension OnboradingViewController: PaywallViewDelegate {
    
    func showPrivacy() {
        coordinator?.showPrivacy()
    }
    
    func showTerms() {
        coordinator?.showTerms()
    }
    
    func purchase() {
        
    }
}
