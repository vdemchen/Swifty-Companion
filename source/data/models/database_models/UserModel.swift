
import Foundation


struct Parameters{
    var firstName: String
    var lastName: String
    var email: String
    var phoneNumber: String?
    var userImageUrl: String
    var wallet: Int
    var poolYear: String
    var poolMonth: String
    var login: String
    var grade: String
    var campusLocation: String
    var correctionPoint: Int
    var coalition: Int
    
    init() {
        firstName = ""
        lastName = ""
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = nil
        userImageUrl = ""
        wallet = 0
        poolYear = ""
        poolMonth = ""
        login = ""
        grade = ""
        campusLocation = ""
        correctionPoint = 0
        coalition = 0
    }
}

struct Cursus {
    var name: String
    var grade: String
    var level: Double
    var projects: [Project]?
    var skills: [Skill]?
    var piscines: [Piscine]?
}

struct Piscine {
    var piscineName: String
    var piscineDays: [Project]
    
    init() {
        self.piscineName = ""
        self.piscineDays = [Project]()
    }
    
    init(name: String, days: [Project]) {
        self.piscineName = name
        self.piscineDays = days
    }
}

struct Project{
    var parentId: Int?
    var name: String
    var projectStatus: String
    var validationStatus: Bool
    var projectMark: Int
    var projectId: Int
    var slug: String
    
    init(){
        self.parentId = 0
        self.name = ""
        self.projectStatus = ""
        self.validationStatus = false
        self.projectMark = 0
        self.projectId = 0
        self.slug = ""
    }
    init(
        parentId: Int? = 0,
        name: String,
        validationStatus: Bool,
        projectMark: Int,
        projectId: Int,
        slug: String,
        projectStatus: String
        ){
        self.parentId = parentId
        self.name = name
        self.projectStatus = projectStatus
        self.validationStatus = validationStatus
        self.projectMark = projectMark
        self.projectId = projectId
        self.slug = slug
    }
}

struct Skill {
    var level: Double
    var name: String
    
    init() {
        self.level = 0.0
        self.name = ""
    }
    
    init(
        level: Double,
        name: String
        ) {
        self.level = level
        self.name = name
    }
}

class User{
    
    // MARK: - Public properties
    var parameters: Parameters?
    var cursus42: Cursus?
    var cursusC: Cursus?
    
    // MARK: - Private properties
    private static var user: User?
    
    // MARK: - Init
    private init(){
        self.parameters = JsonManager.getUserParameters()
        self.cursus42 = JsonManager.createCursus(cursusNumber: 0)
        //        self.cursusC = JsonManager.createCursus(cursusNumber: 1)
        
    }
    
    // MARK: - Public methods
    static func shareUser() -> User {
        if let user = self.user
        {
            return user
        }
        else
        {
            let newUser = User()
            self.user = newUser
            return newUser
        }
    }
    
    static func deleteUser(){
        self.user = nil
    }
    
    // MARK: - Private methods
    private func setCoalition(number: Int){
        if number != 0{
            self.parameters?.coalition = number
        }
    }
}
