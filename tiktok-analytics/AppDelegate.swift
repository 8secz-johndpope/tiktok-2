import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var appCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UIBarButtonItem.setCustomAppearance()
        UINavigationBar.setCustomAppearance()
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        appCoordinator = AppCoordinator(window: window!)
        appCoordinator?.start()
        window?.makeKeyAndVisible()
        
//        FirebaseApp.configure()
        
        return true
    }
    
}

