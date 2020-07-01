import UIKit

class VideosViewController: UICollectionViewController, BarButtonItemConfigurable {

    var coordinator: AppCoordinator?
    
    var rightBarButtonItemType: RightBarButtonItem {
        return .sort
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Top Videos"
        refreshRightBarButtonItem()
    }
    
    override func actionSort() {
        coordinator?.showFilters()
    }
    
    func applyFilter(_ filter: Filter) {
        print(filter)
    }

}

extension VideosViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(VideoCollectionViewCell.self)", for: indexPath)
        return cell
    }
}
