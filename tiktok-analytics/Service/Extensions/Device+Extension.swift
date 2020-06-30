import UIKit

extension UIDevice {
    
    var isPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
}
