import Foundation
import UIKit

extension NSObject
{
    class func className() -> String
    {
        return String(describing: self)
    }
}
