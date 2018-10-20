import Foundation
import UIKit

extension NSObject
{
    class func className() -> String
    {
        return String(describing: self)
    }
    

    @objc func handleKeyboard(keyboardNotification: NSNotification)
    {
        let duration = keyboardNotification.userInfo![UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        let curve = UIView.AnimationCurve.init(rawValue: keyboardNotification.userInfo![UIResponder.keyboardAnimationCurveUserInfoKey] as! Int)
        let keyboardFrame = keyboardNotification.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
        
        
        UIView.beginAnimations("KeyboardAnimationID", context: nil)
        UIView.setAnimationCurve(curve!)
        
        UIView.setAnimationDuration(duration)
        
        UIView.commitAnimations()
    }
    
    @objc func keyboardStateChangeWithFrame(frame: CGRect, willBeShown: Bool)
    {
        
    }
}
