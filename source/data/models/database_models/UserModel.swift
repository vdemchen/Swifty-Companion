
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
}

struct Cursus {
    var name: String
    var grade: String
    var level: Double
    var projects: [Project]
    var skills: [Skill]
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
}

class User{
    
    init(){
        self.parameters = JsonManager.getUserParameters()
        self.cursus42 = JsonManager.createCursus(cursusNumber: 0)
        self.cursusC = JsonManager.createCursus(cursusNumber: 1)
    }
    
    var parameters: Parameters?
    var cursus42: Cursus?
    var cursusC: Cursus?
}
