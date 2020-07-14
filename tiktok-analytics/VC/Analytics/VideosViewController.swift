import UIKit

class VideosViewController: UICollectionViewController, BarButtonItemConfigurable {

    var coordinator: AppCoordinator?
    var profileId = 0
    
    private var videos = [Video]()
    
    private(set) var selectedFilter: Filter = .date
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .sort
    }
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = UIDevice.current.isPad ? 40.0 : 25.0
        let inset: CGFloat = 35.0
        layout.sectionInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        var size = CGSize(width: 135, height: 215)
        if UIDevice.current.isPad {
            size = CGSize(width: 235, height: 375)
        }
        
        layout.itemSize = size
        super.init(collectionViewLayout: layout)
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.backgroundColor
        collectionView.backgroundColor = .clear
        navigationItem.title = "Top Videos"
        refreshRightBarButtonItem()
        
        collectionView.register(UINib(nibName: "\(VideoCollectionViewCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(VideoCollectionViewCell.self)")
        let control = UIRefreshControl()
        control.tintColor = .white
        control.addTarget(self, action: #selector(loadVideos), for: .valueChanged)
        collectionView.refreshControl = control
        
        loadVideos()
    }
    
    override func actionSort() {
        coordinator?.showFilters()
    }
    
    func applyFilter(filter: Filter) {
        collectionView.refreshControl?.beginRefreshing()
        selectedFilter = filter
        loadVideos()
    }
    
    @objc private func loadVideos() {
        Network.getVideos(userId: profileId, sort: selectedFilter.rawValue) { result in
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(VideoCollectionViewCell.self)", for: indexPath) as! VideoCollectionViewCell
        cell.setup(withVideo: videos[indexPath.row])
        return cell
    }
}
