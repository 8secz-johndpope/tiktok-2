import UIKit

class InfoView: UIView {
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var detailFollowersCountLabel: UILabel!
    @IBOutlet weak var detailGainedCountLabel: UILabel!
    @IBOutlet weak var headerContentView: UIView!
    
    private lazy var headerView: HeaderView = {
        guard let view = Bundle.main.loadNibNamed("\(HeaderView.self)", owner: nil, options: nil)?.first as? HeaderView else { return HeaderView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        headerContentView.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: headerContentView.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: headerContentView.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: headerContentView.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: headerContentView.bottomAnchor).isActive = true
    }
    
    func setup(withProfile profile: Profile) {
        headerView.setup(withProfile: profile)
        nameLabel.text = "@\(profile.nickname)"
        bioLabel.text = profile.bio
        detailFollowersCountLabel.text = profile.followers.formatted
        detailGainedCountLabel.text = profile.followers_gained.formatted
        addBlur()
    }
    
    private func addBlur() {
        
        let fake = UIView()
        addSubview(fake)
        fake.translatesAutoresizingMaskIntoConstraints = false
        fake.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        fake.topAnchor.constraint(equalTo: topAnchor).isActive = true
        fake.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        fake.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        fake.backgroundColor = UIColor.black.withAlphaComponent(0.15)
        
        let blurredBackgroundView = UIVisualEffectView()
        blurredBackgroundView.frame = bounds
        if #available(iOS 13.0, *) {
            blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        } else {
            blurredBackgroundView.effect = UIBlurEffect(style: .dark)
        }
        blurredBackgroundView.alpha = 0.9
        
        fake.addSubview(blurredBackgroundView)
        bringSubviewToFront(separatorView)
    }
}
