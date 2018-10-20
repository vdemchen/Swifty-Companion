import UIKit

class UserInfoViewController: BaseViewController {

    let user: User = User.shareUser()
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var correctionPointLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var userPhoneNumberLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var campusLocationLabel: UILabel!
    @IBOutlet weak var poolLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    
    @IBOutlet weak var projectsTableView: UITableView!
    
    @IBOutlet weak var skillsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ActivityIndicatorView.hideAllActivity()
        setUserProfile()
    }
    
    func setUserProfile(){
        
        if let filePath = Bundle.main.path(forResource: "vdemchen", ofType: "jpg"),
            let image = UIImage(contentsOfFile: filePath) {
            profileImage.contentMode = .scaleAspectFit
            profileImage.image = image
        }
        
        self.correctionPointLabel.text = String(self.user.parameters?.correctionPoint ?? 0)
        
        self.loginLabel.text = self.user.parameters?.login
        
        if let phone: String = self.user.parameters?.phoneNumber{
            self.userPhoneNumberLabel.text = phone
        }
        else {
            self.userPhoneNumberLabel.text = "no phone"
        }
        
        
        self.userEmailLabel.text = self.user.parameters?.email
        self.campusLocationLabel.text = self.user.parameters?.campusLocation
        
        guard let firstName = self.user.parameters?.firstName else {return}
        guard let lastName = self.user.parameters?.lastName else {return}
        self.fullNameLabel.text = firstName + " " + lastName
        
        guard let poolMonth = self.user.parameters?.poolMonth else {return}
        guard let poolYear = self.user.parameters?.poolYear else {return}
        self.poolLabel.text = poolYear + " " + poolMonth
        
        self.gradeLabel.text = self.user.parameters?.grade
    }
    

}
