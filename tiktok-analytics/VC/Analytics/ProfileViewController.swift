import UIKit
import Kingfisher

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
    
    @IBOutlet weak var headerContentView: UIView!
    
    @IBOutlet weak var currentDetailsLabel: UILabel!
    @IBOutlet weak var detailFollowersCountLabel: UILabel!
    @IBOutlet weak var detailGainedCountLabel: UILabel!
    @IBOutlet weak var detailLikesCountLabel: UILabel!
    @IBOutlet weak var detailLostCountLabel: UILabel!
    @IBOutlet weak var videosCountLabel: UILabel!
    
    private lazy var headerView: HeaderView = {
        guard let view = Bundle.main.loadNibNamed("\(HeaderView.self)", owner: nil, options: nil)?.first as? HeaderView else { return HeaderView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.register(UINib(nibName: "\(VideoCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(VideoCollectionViewCell.self)")
        }
    }
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var coordinator: AppCoordinator?
    
    var profile: Profile!
    private var videos = [Video]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(reload), for: .valueChanged)
        scrollView.refreshControl = control
        
        refreshRightBarButtonItem()
        refreshLeftBarButtonItem()
        setupView()
        
        headerContentView.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: headerContentView.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: headerContentView.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: headerContentView.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: headerContentView.bottomAnchor).isActive = true
        headerView.setup(withProfile: profile)
        loadVideos()
    }
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .exit
    }
    
    var leftBarButtonItemType: LeftBarButtonItem {
        return .none
    }
    
    private func setupView() {
        avatarImageView.kf.setImage(with: profile.avatar)
        nameLabel.text = "@\(profile.nickname)"
        bioLabel.text = profile.bio
        
        detailFollowersCountLabel.text = profile.followers.formatted
        detailGainedCountLabel.text = profile.followers_gained.formatted
        detailLikesCountLabel.text = profile.likes.formatted
        detailLostCountLabel.text = profile.followers_lost.formatted
        videosCountLabel.text = profile.videos.formatted
    }
    
    override func actionExit() {
        UserDefaults.standard.removeObject(forKey: Constants.savedProfile)
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
        coordinator?.showVideos(profile: profile)
    }
    
    private func loadVideos() {
        guard UIDevice.current.isPad else { return }
        spinner.startAnimating()
        Network.getVideos(userId: profile.id, limit: 6, sort: Filter.date.rawValue) { result in
            onMain {
                self.spinner.stopAnimating()
                self.spinner.isHidden = true
                switch result {
                case .success(let videos):
                    self.videos = videos
                    self.collectionView.reloadData()
                case .failure(let error):
                    self.coordinator?.showErrorAlert(error: error.localizedDescription)
                }
            }
        }
    }
}

// iPad only
extension ProfileViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(VideoCollectionViewCell.self)", for: indexPath) as! VideoCollectionViewCell
        cell.setup(withVideo: videos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 135, height: 215)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 20.0
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}
