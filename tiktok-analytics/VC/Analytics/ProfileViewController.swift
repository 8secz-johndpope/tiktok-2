import UIKit

class ProfileViewController: UIViewController, BarButtonItemConfigurable {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var avatarImageView: UIImageView! {
        didSet {
            avatarImageView.layer.cornerRadius = 22.0
            avatarImageView.layer.borderWidth = 2.0
            avatarImageView.layer.borderColor = UIColor.white.cgColor
            avatarImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var folowingCountLabel: UILabel!
    @IBOutlet weak var folowingTitleLabel: UILabel!
    
    @IBOutlet weak var followersCountLabel: UILabel!
    @IBOutlet weak var followersTitleLabel: UILabel!
    
    @IBOutlet weak var heartsCountLabel: UILabel!
    @IBOutlet weak var heartsTitleLabel: UILabel!
    
    @IBOutlet weak var currentDetailsLabel: UILabel!
    @IBOutlet weak var detailFollowersCountLabel: UILabel!
    @IBOutlet weak var detailGainedCountLabel: UILabel!
    @IBOutlet weak var detailLikesCountLabel: UILabel!
    @IBOutlet weak var detailLostCountLabel: UILabel!
    @IBOutlet weak var videosCountLabel: UILabel!
    
    var coordinator: AppCoordinator?
    
    var profile: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(reload), for: .valueChanged)
        scrollView.refreshControl = control
        
        refreshRightBarButtonItem()
        refreshLeftBarButtonItem()
        setupView()
    }
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .exit
    }
    
    var leftBarButtonItemType: LeftBarButtonItem {
        return .none
    }
    
    private func setupView() {
        DispatchQueue.global().async {
            if let data = self.profile.avatarData {
                onMain {
                    self.avatarImageView.image = UIImage(data: data)
                }
            }
        }
        nameLabel.text = "@\(profile.nickname)"
        bioLabel.text = profile.bio
        folowingCountLabel.text = profile.following.formatted
        followersCountLabel.text = profile.followers.formatted
        heartsCountLabel.text = profile.likes.formatted
        detailFollowersCountLabel.text = profile.followers.formatted
        detailGainedCountLabel.text = profile.followers_gained.formatted
        detailLikesCountLabel.text = profile.likes.formatted
        detailLostCountLabel.text = profile.followers_lost.formatted
        videosCountLabel.text = profile.videos.formatted
    }
    
    override func actionExit() {
        coordinator?.pop()
    }
    
    @objc private func reload() {
        Network.getUser(user: profile.login) { result in
            onMain {
                self.scrollView.refreshControl?.endRefreshing()
                switch result {
                case .success(let profile):
                    self.profile = profile
                    self.setupView()
                case .failure(let error):
                    self.coordinator?.showErrorAlert(error: error.localizedDescription)
                }
            }
        }
    }
    
    @IBAction func actionShowVideos() {
        coordinator?.showVideos(profileId: profile.id)
    }
    
}
