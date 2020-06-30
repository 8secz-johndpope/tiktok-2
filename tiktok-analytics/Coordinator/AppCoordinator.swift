import UIKit

class AppCoordinator: NSObject {

    let window: UIWindow?
    
    var navigationController = UINavigationController()

    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewController = SearchViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
        window?.rootViewController = navigationController
    }
    
    func showProfile(name: Profile) {
        let viewController = ProfileViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.profile = Profile()
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func showEmtyNameAlert() {
        let alert = UIAlertController(style: .alert, title: "Alert", message: "Fill username")
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        navigationController.present(alert, animated: true)
    }
    
    func showVideos() {
        let viewController = VideosViewController.instantiate(fromAppStoryboard: .analytics)
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController.popViewController(animated: true)
    }
}
