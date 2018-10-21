import UIKit

class UserInfoViewController: BaseViewController {
    
    let user: User = User.shareUser()
    var tapOnRow: (Int, Bool) = (0, false)
    
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
    @IBOutlet weak var levelPoints: UILabel!
    
    
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var skillsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUserProfile()
        
        self.setSkillsTableView()
        self.setProjectsTableView()
        
        
        ActivityIndicatorView.hideAllActivity()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.projectsTableView.reloadData()
        self.skillsTableView.reloadData()
    }
    
    private func setProjectsTableView(){
        self.projectsTableView.dataSource = self as UITableViewDataSource
        self.projectsTableView.delegate = self as UITableViewDelegate
        self.projectsTableView.register(ProjectsTableViewCell.nib(),
                                        forCellReuseIdentifier: ProjectsTableViewCell.identifier())
        self.projectsTableView.register(PiscineDayTableViewCell.nib(),
                                        forCellReuseIdentifier: PiscineDayTableViewCell.identifier())
    }
    
    private func setSkillsTableView(){
        self.skillsTableView.dataSource = self as UITableViewDataSource
        self.skillsTableView.delegate = self as UITableViewDelegate
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
        self.levelProgresBar.setProgress(Float(level / 100), animated: false)
        self.levelPoints.text = String(format: "level: %.2f", level)
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        var count: Int?
        
        if tableView == self.projectsTableView{
            count = user.cursus42?.projects?.count
        }
        
        if tableView == self.skillsTableView{
            count = user.cursus42?.skills?.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count: Int = 1
        
        
        if tableView == self.projectsTableView{
            if tapOnRow.1 == true{
                count = 2
            }
        }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell?
        
        if tableView == self.skillsTableView{
            let skillCell = tableView.dequeueReusableCell(withIdentifier: SkillsTableViewCell.className())
                as! SkillsTableViewCell
            if let skill: Skill  = self.user.cursus42?.skills?[indexPath.section]{
                skillCell.skillName.text = skill.name
                skillCell.skillPoints.text = String(format: "%.1f" , skill.level)
                skillCell.skillProgresBar.setProgress(Float(skill.level / 20), animated: false)
                cell = skillCell as UITableViewCell
            }
        }
        
        if tableView == self.projectsTableView{
            let projectCell = tableView.dequeueReusableCell(withIdentifier: ProjectsTableViewCell.className())
                as! ProjectsTableViewCell
            if !tapOnRow.1{
                if let projects: Project = self.user.cursus42?.projects?[indexPath.section]{
                    projectCell.projectName.text = projects.name
                    projectCell.projectMark.text = String(projects.projectMark)
                }
                cell = projectCell as UITableViewCell
            }
            if tapOnRow.1{
                if indexPath.section == tapOnRow.0{
                    let piscineCell = tableView.dequeueReusableCell(withIdentifier: PisicineTableViewCell.className()) as! PisicineTableViewCell
                    if let projects: Project = self.user.cursus42?.projects?[indexPath.section]{
                        piscineCell.piscineLabel.text = projects.name
                        piscineCell.piscineMark.text = String(projects.projectMark)
                        print(tapOnRow)
                        if let piscines: [Piscine] = self.user.cursus42?.piscines{
                            //                            let piscine = piscines.first { (item) -> Bool in item.piscineName == projects.name }
                            //                            if let piscine = piscine {
                            //                                let _ = piscineCell.piscineDaysTableView.numberOfRows(inSection: piscine.piscineDays.count)
                            //                                piscineCell.piscineDaysTableView.dequeueReusableCell(withIdentifier: PiscineDayTableViewCell.className())
                            //                            }
                        }
                        cell = piscineCell as UITableViewCell
                    }
                }
            }
        }
        return cell!
    }
}



extension UserInfoViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == self.projectsTableView{
            self.tapOnRow.0 = indexPath.section
            if user.cursus42?.projects?[indexPath.section].slug.contains(ModelsKeys.keyPiscine) ?? false {
                self.tapOnRow.1 = true
            }
            
        }
        tableView.reloadData()
    }
}
