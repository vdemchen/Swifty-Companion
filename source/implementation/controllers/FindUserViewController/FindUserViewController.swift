
import UIKit

class FindUserViewController: BaseViewController {
    @IBOutlet weak var loginInputField: UITextField!
    
    @IBAction func findUserButtom(_ sender: Any){
//        ActivityIndicatorView.showActivity()
        guard let login = loginInputField.text else {return}
        if !login.isEmpty{
            makeResponse(login: login)
        }
        else{
            showErrorAlertWith(message: "Not valid")
//            ActivityIndicatorView.hideAllActivity()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    private func makeResponse(login: String){
        AlamofireManager().getUserRequsest(userName: login) { (result) in
            if result != nil{
                guard let error: String = result else {return}
                self.showErrorAlertWith(message: error)
            }else {
                let _ :User = User.shareUser()
                self.performSegue(withIdentifier: UserInfoViewController.className(), sender: nil)
            }
        }
    }
}
