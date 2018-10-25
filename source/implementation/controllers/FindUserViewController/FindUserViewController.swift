
import UIKit

class FindUserViewController: BaseViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var loginInputField: UITextField!

    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage:
            UIImage(named: ModelsKeys.keyBackGroudStandart)!)
        self.reloadInputViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.loginInputField.text = ""
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - IBAction
    @IBAction func findUserButtom(_ sender: Any){
        if AlamofireManager.isConnectedToInternet(){
            ActivityIndicatorView.showActivity()
            guard let login = loginInputField.text else {return}
            if !login.isEmpty{
                makeResponse(login: login)
            }
            else{
                showErrorAlertWith(message: "Not valid login")
                ActivityIndicatorView.hideAllActivity()
            }
        } else {
            showErrorAlertWith(message: "No internet connection")
        }
    }
    
    // MARK: - Private methods
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
