
import UIKit

class FindUserViewController: BaseViewController {
    @IBOutlet weak var loginInputField: UITextField!
    
    @IBAction func findUserButtom(_ sender: Any){
        ActivityIndicatorView.showActivity()
        guard let login = loginInputField.text else {return}
        if !login.isEmpty{
            makeResponse(login: login)
        }
        else{
            showErrorAlertWith(message: "Not valid login")
            ActivityIndicatorView.hideAllActivity()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        self.view.backgroundColor = UIColor(patternImage:
            UIImage(named: ModelsKeys.keyBackGroudStandart)!)
        self.reloadInputViews()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func makeResponse(login: String){
        User.deleteUser()
        
        AlamofireManager().getUserRequsest(userName: login) { (result) in
            if result != nil{
                guard let error: String = result else {return}
                ActivityIndicatorView.hideAllActivity()
                self.showErrorAlertWith(message: error)
            }else {
                
                self.performSegue(withIdentifier: UserInfoViewController.className(), sender: nil)
            }
        }
    }
}
