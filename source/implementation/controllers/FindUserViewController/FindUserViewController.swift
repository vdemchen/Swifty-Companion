
import UIKit

class FindUserViewController: BaseViewController {
    @IBOutlet weak var loginInputField: UITextField!
//
//    @IBAction func findUserButtom(_ sender: Any){
//        guard let login = loginInputField.text else {return}
//        if !login.isEmpty{
//            showAlertWith(title: login)
//            UserServices.getUser(nameOfUser: login)
//        }
//        else{
//            showErrorAlertWith(message: "Non valid")
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserServices.getUser(userLogin: "vdemchen") { (result) in
            print(result)
        }
    }
}
