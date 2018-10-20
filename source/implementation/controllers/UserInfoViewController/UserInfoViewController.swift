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
    @IBOutlet weak var levelProgresBar: UIProgressView!
    
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var skillsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setSkillsTableView()
        self.setProjectsTableView()
        self.setUserProfile()
        
        ActivityIndicatorView.hideAllActivity()
    }
    
    private func setProjectsTableView(){
        self.projectsTableView.dataSource = self as UITableViewDataSource
        self.projectsTableView.register(ProjectsTableViewCell.nib(),
                                   forCellReuseIdentifier: ProjectsTableViewCell.identifier())
        self.projectsTableView.register(PiscinesTableViewCell.nib(),
                                   forCellReuseIdentifier: PiscinesTableViewCell.identifier())
    }
    
    private func setSkillsTableView(){
        self.skillsTableView.dataSource = self as UITableViewDataSource
        self.skillsTableView.register(SkillsTableViewCell.nib(),
                                 forCellReuseIdentifier: SkillsTableViewCell.identifier())
    }
    
    private func setUserProfile(){
        self.profileImage.sizeToFit()
        self.levelProgresBar.transform =  self.levelProgresBar.transform.scaledBy(x: 1, y: 20)
        
        guard let poolMonth = self.user.parameters?.poolMonth else {return}
        guard let poolYear = self.user.parameters?.poolYear else {return}
        guard let firstName = self.user.parameters?.firstName else {return}
        guard let lastName = self.user.parameters?.lastName else {return}
        guard let level = self.user.cursus42?.level else {return}
        
        if let profilePhoto: UIImage = AlamofireManager.downloadImage(self.user.parameters?.userImageUrl ?? ""){
            self.profileImage.image = profilePhoto
        } else {
            self.profileImage.image = UIImage.init()
        }
        if let phone: String = self.user.parameters?.phoneNumber{
            self.userPhoneNumberLabel.text = phone
        } else {
            self.userPhoneNumberLabel.text = "no number"
        }
        self.levelProgresBar.setProgress(Float(level / 20), animated: false)
        self.correctionPointLabel.text = "CP: " +  String(self.user.parameters?.correctionPoint ?? 0)
        self.loginLabel.text = self.user.parameters?.login
        self.userEmailLabel.text = self.user.parameters?.email
        self.campusLocationLabel.text = self.user.parameters?.campusLocation
        self.fullNameLabel.text = firstName + " " + lastName
        self.poolLabel.text = poolYear + " " + poolMonth
        self.gradeLabel.text = self.user.cursus42?.grade
    }
}

extension UserInfoViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int?
        
        if tableView == self.projectsTableView{
            count = user.cursus42?.projects?.count
        }
        
        if tableView == self.skillsTableView{
            count = user.cursus42?.skills?.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.skillsTableView{
            let skillCell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className())
                as! SkillsTableViewCell
            if let skill: Skill  = self.user.cursus42?.skills?[indexPath.row]{
                skillCell.skillName.text = skill.name
                skillCell.skillPoints.text = String(format: "%.1f" , skill.level)
//                skillCell.skillProgresBar.progress = Float(skill.level / 20)
                cell = skillCell as UITableViewCell
            }
        }
        
        if tableView == self.projectsTableView{
            let projectCell = tableView.dequeueReusableCell(withIdentifier: ProjectsTableViewCell.className())
                as! ProjectsTableViewCell
            if let project: Project = self.user.cursus42?.projects?[indexPath.row]{
                projectCell.projectName.text = project.name
                projectCell.projectMark.text = String(project.projectMark)
                projectCell.projectMark.textColor = project.validationStatus ?  UIColor.green : UIColor.red
            }
            cell = projectCell as UITableViewCell
        }
        
        
        return cell!
    }
}
