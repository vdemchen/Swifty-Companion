
import UIKit

class FindUserViewController: BaseViewController {
    @IBOutlet weak var loginInputField: UITextField!

    @IBAction func findUserButtom(_ sender: Any){
        guard let login = loginInputField.text else {return}
        if !login.isEmpty{
            UserServices.getUser(userLogin: login)
            ActivityIndicatorView.showActivity()
            self.performSegue(withIdentifier: UserInfoViewController.className(), sender: nil)
        }
        else{
            showErrorAlertWith(message: "Non valid")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
