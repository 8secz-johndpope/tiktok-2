import UIKit

class InfoView: UIView {
    
    @IBOutlet weak var followersTitleLabel: UILabel! {
        didSet {
            followersTitleLabel.text = Localization.followers
        }
    }
    @IBOutlet weak var gainedTitleLabel: UILabel! {
        didSet {
            gainedTitleLabel.text = Localization.gained
        }
    }
    @IBOutlet weak var likesTitleLabel: UILabel! {
        didSet {
            likesTitleLabel.text = Localization.likes
        }
    }
    @IBOutlet weak var lostTitleLabel: UILabel! {
        didSet {
            lostTitleLabel.text = Localization.lost
        }
    }
    @IBOutlet weak var videosTitleLabel: UILabel! {
        didSet {
            videosTitleLabel.text = Localization.videos
        }
    }
    @IBOutlet weak var showLabel: UILabel! {
        didSet {
            showLabel.text = Localization.showAnalytics
        }
    }
    
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var detailFollowersCountLabel: UILabel!
    @IBOutlet weak var detailGainedCountLabel: UILabel!
    @IBOutlet weak var detailLikesCountLabel: UILabel!
    @IBOutlet weak var detailLostCountLabel: UILabel!
    @IBOutlet weak var videosCountLabel: UILabel!
    @IBOutlet weak var headerContentView: UIView!
    
    var maskLayer: CAShapeLayer!
    
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard maskLayer == nil else { return }
        maskLayer = CAShapeLayer()
        maskLayer.frame = frame
        let radius: CGFloat = UIDevice.current.isPad ? 80 : 60.0
        let rect = CGRect(x: 25, y: -radius,
                          width: 2 * radius, height: 2 * radius)
        let circlePath = UIBezierPath(ovalIn: rect)
        let path = UIBezierPath(rect: bounds)
        path.append(circlePath)
        maskLayer.fillRule = CAShapeLayerFillRule.evenOdd
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
    
    func setup(withProfile profile: Profile) {
        headerView.setup(withProfile: profile)
        nameLabel.text = "@\(profile.nickname)"
        bioLabel.text = profile.bio
        detailFollowersCountLabel.text = profile.followers.formatted
        detailGainedCountLabel.text = profile.followers_gained.formatted
        addBlur()
        bringSubviewToFront(separatorView)
        
        guard UIDevice.current.isPad else { return }
        detailLikesCountLabel.text = profile.likes.formatted
        detailLostCountLabel.text = profile.followers_lost.formatted
        videosCountLabel.text = profile.videos.formatted
    }
}
