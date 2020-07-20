import UIKit

class VideosViewController: UIViewController, BarButtonItemConfigurable {

    @IBOutlet weak var infoContainerView: UIView!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.backgroundColor = .clear
            collectionView.register(UINib(nibName: "\(VideoCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(VideoCollectionViewCell.self)")
            collectionView.contentInsetAdjustmentBehavior = .never
        }
    }
    var coordinator: AppCoordinator?
    var profile: Profile!
    
    private var videos = [Video]()
    
    private(set) var selectedFilter: Filter = .date
    
    private lazy var headerView: HeaderView = {
        guard let view = Bundle.main.loadNibNamed("\(HeaderView.self)", owner: nil, options: nil)?.first as? HeaderView else { return HeaderView() }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .sort
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        navigationItem.title = Localization.topVideos
        refreshRightBarButtonItem()
        
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(loadVideos), for: .valueChanged)
        collectionView.refreshControl = control
        
        infoContainerView.addSubview(headerView)
        headerView.leftAnchor.constraint(equalTo: infoContainerView.leftAnchor).isActive = true
        headerView.rightAnchor.constraint(equalTo: infoContainerView.rightAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: infoContainerView.topAnchor).isActive = true
        headerView.bottomAnchor.constraint(equalTo: infoContainerView.bottomAnchor).isActive = true
        headerView.setup(withProfile: profile)
        loadVideos()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.contentOffset = CGPoint(x: 0, y: -collectionView.refreshControl!.frame.height)
        collectionView.refreshControl?.beginRefreshing()
    }
    
    override func actionSort() {
        coordinator?.showFilters()
    }
    
    func applyFilter(filter: Filter) {
        collectionView.refreshControl?.beginRefreshing()
        collectionView.contentOffset = CGPoint(x: 0, y: -collectionView.refreshControl!.frame.height)
        selectedFilter = filter
        loadVideos()
    }
    
    @objc private func loadVideos() {
        Network.getVideos(userId: profile.id, sort: selectedFilter.rawValue) { result in
            onMain {
                self.collectionView.refreshControl?.endRefreshing()
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

extension VideosViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(VideoCollectionViewCell.self)", for: indexPath) as! VideoCollectionViewCell
        cell.setup(withVideo: videos[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 135, height: 215)
        if UIDevice.current.isPad {
            size = CGSize(width: 235, height: 375)
        }
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let inset: CGFloat = 20.0
        return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    }
}
