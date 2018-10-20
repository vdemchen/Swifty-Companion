import UIKit

class BaseViewController: UIViewController
{
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.updateUi()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return .lightContent
    }
    
    func updateUi()
    {
        self.view.backgroundColor = UIColor.white
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor.mainDarkAppColor
    }
}
