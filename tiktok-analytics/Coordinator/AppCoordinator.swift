import UIKit

class AppCoordinator: NSObject {

    let window: UIWindow?
    
    var navigationController = UINavigationController()
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
//        showOnboarding()
        showSearch()
    }
    
    func showOnboarding() {
        navigationController.setNavigationBarHidden(true, animated: false)
        let viewController = OnboradingViewController.instantiate(fromAppStoryboard: .onboarding)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
    
    func showSearch() {
        navigationController.setNavigationBarHidden(false, animated: false)
        let viewController = SearchViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
    
    func showProfile(profile: Profile) {
        var viewController = ProfileViewController.instantiate(fromAppStoryboard: .analytics)
        if UIDevice.current.isPad {
            viewController = UIStoryboard(name: "Analytics", bundle: .main).instantiateViewController(withIdentifier: "ProfilePadViewController") as! ProfileViewController
        }
        viewController.profile = profile
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showEmtyNameAlert() {
        let alert = UIAlertController(style: .alert, title: "Alert", message: "Fill username")
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
    
    func showErrorAlert(error: String) {
        let alert = UIAlertController(style: .alert, title: "Alert", message: error)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
    
    func showVideos(profile: Profile) {
        let viewController = VideosViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.coordinator = self
        viewController.profile = profile
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showFilters() {
        
        guard let videosViewController = navigationController.viewControllers.last as? VideosViewController else {
            return
        }
        
        navigationController.viewControllers.last?.addBlurEffect()
        let viewController = FilterViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.filter = videosViewController.selectedFilter
        viewController.coordinator = self
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        navigationController.present(viewController, animated: true)
    }
    
    func filterSelected(_ filter: Filter) {
        guard let viewController = navigationController.viewControllers.last as? VideosViewController else {
            return
        }
        viewController.removeBlurEffect()
        if viewController.selectedFilter != filter {
            viewController.applyFilter(filter: filter)
        }
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
