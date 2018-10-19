import SwiftyJSON
import Foundation

class JsonManager{
    
    private static var userJson = JSON()
    
    init(_ inputJson: JSON) {
        JsonManager.userJson = inputJson
    }
    
    static func getUserParameters() -> Parameters?{
        
        var parameters: Parameters = Parameters()
        
        parameters.firstName = self.userJson[ModelsKeys.keyFirstName].string ?? ""
        parameters.lastName = self.userJson[ModelsKeys.keyLastName].string ?? ""
        parameters.email = self.userJson[ModelsKeys.keyEmail].string ?? ""
        parameters.correctionPoint = self.userJson[ModelsKeys.keyCorrectionPoint].int ?? 0
        parameters.phoneNumber = self.userJson[ModelsKeys.keyPhoneNumber].string ?? ""
        parameters.wallet = self.userJson[ModelsKeys.keyWallet].int ?? 0
        parameters.userImageUrl = self.userJson[ModelsKeys.keyImageUrl].string ?? ""
        parameters.poolYear = self.userJson[ModelsKeys.keyPoolYear].string ?? ""
        parameters.poolMonth = self.userJson[ModelsKeys.keyPoolMonth].string ?? ""
        parameters.login = self.userJson[ModelsKeys.keyLogin].string ?? ""
        parameters.campusLocation = "UNIT Factory"
        
        return parameters
    }
    
    static func createCursus(cursusNumber: Int) -> Cursus?{
        
        guard let userCursus = self.userJson[ModelsKeys.keyUserCursus].array else {return nil}
        guard let skills = userCursus[cursusNumber][ModelsKeys.keyUserCursusSkills].array else {return nil}
        guard let cursus = userCursus[cursusNumber][ModelsKeys.keyUserCursusCursus].dictionary else {return nil}
        
        var result: Cursus = Cursus(
            name: cursus[ModelsKeys.keyUserCursusCursusName]?.string ?? "",
            grade: userCursus[cursusNumber][ModelsKeys.keyUserCursusGrade].string ?? "",
            level: userCursus[cursusNumber][ModelsKeys.keyUserCursusLevel].double ?? 0.0,
            projects: nil,
            skills: nil
        )
        
        if let skills = createSkillsArray(skillsJson: skills){
            result.skills = skills
        }
        
        return result
    }
    
    class func createSkillsArray(skillsJson: [JSON]) -> [Skill]?{
        var skills: [Skill] = [Skill]()
        
        for item in skillsJson{
            let skillsItem:Skill = Skill(
                level: item[ModelsKeys.keyUserCursusSkillLevel].double ?? 0.0,
                name: item[ModelsKeys.keyUserCursusCursusName].string ?? ""
            )
            skills.append(skillsItem)
        }
        
        return skills
    }
}
