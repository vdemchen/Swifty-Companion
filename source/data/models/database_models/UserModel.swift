
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
    
    init() {
        firstName = ""
        lastName = ""
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
        userImageUrl = ""
        wallet = 0
        poolYear = ""
        poolMonth = ""
        login = ""
        grade = ""
        campusLocation = ""
        correctionPoint = 0
    }
}

struct Cursus {
    var name: String
    var grade: String
    var level: Double
    var projects: [Project]?
    var skills: [Skill]?
}

struct Project{
    var parentId: Int
    var name: String
    var validationStatus: Bool
    var projectMark: Int
}

struct Skill {
    var level: Double
    var name: String
    
    init() {
        self.level = 0.0
        self.name = ""
    }
    
    init(level: Double, name: String) {
        self.level = level
        self.name = name
    }
}

class User{
    
    private static var user: User?
    var parameters: Parameters?
    var cursus42: Cursus?
    var cursusC: Cursus?
    
    private init(){
        self.parameters = JsonManager.getUserParameters()
        self.cursus42 = JsonManager.createCursus(cursusNumber: 0)
        self.cursusC = JsonManager.createCursus(cursusNumber: 1)
    }
    
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
    
}
