import Foundation
import UIKit

extension UIApplication
{
    var statusBarView: UIView?
    {
        let statusBar = "statusBar"
        
        if responds(to: Selector((statusBar)))
        {
            return value(forKey: statusBar) as? UIView
        }
        
        return nil
    }
}
