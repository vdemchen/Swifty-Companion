import SwiftyJSON
import Foundation

class JsonManager{
    
    private static var userJson = JSON()
    
    init(_ inputJson: JSON) {
        print(1)
        JsonManager.userJson = inputJson
    }
    
//    private static func setUserJson(json: JSON){ self.userJson = json }
    
    static func getUserParameters() -> Parameters?{
        
        var parameters: Parameters()
        
        parameters?.firstName = self.userJson[ModelsKeys.keyFirstName].string ?? ""
        parameters?.lastName = self.userJson[ModelsKeys.keyLastName].string ?? ""
        parameters?.email = self.userJson[ModelsKeys.keyEmail].string ?? ""
        parameters?.correctionPoint = self.userJson[ModelsKeys.keyCorrectionPoint].int ?? 0
        parameters?.phoneNumber = self.userJson[ModelsKeys.keyPhoneNumber].string ?? ""
        parameters?.wallet = self.userJson[ModelsKeys.keyWallet].int ?? 0
        parameters?.userImageUrl = self.userJson[ModelsKeys.keyImageUrl].string ?? ""
        parameters?.poolYear = self.userJson[ModelsKeys.keyPoolYear].string ?? ""
        parameters?.poolMonth = self.userJson[ModelsKeys.keyPoolMonth].string ?? ""
        parameters?.login = self.userJson[ModelsKeys.keyLogin].string ?? ""
        parameters?.campusLocation = "UNIT Factory"
        
        return parameters
    }
    
    static func createCursus(cursusNumber: Int) -> Cursus?{
        
        var result: Cursus?
        guard let userCursus = self.userJson[ModelsKeys.keyUserCursus].array else {return nil}
        guard let skills = userCursus[cursusNumber][ModelsKeys.keyUserCursusSkills].array else {return nil}
        guard let cursus = userCursus[cursusNumber][ModelsKeys.keyUserCursusCursus].dictionary else {return nil}
        
        result?.name = cursus[ModelsKeys.keyUserCursusCursusName]?.string ?? ""
        result?.level = cursus[ModelsKeys.keyUserCursusCursusName]?.double ?? 0.0
        result?.grade = userCursus[cursusNumber][ModelsKeys.keyUserCursusGrade].string ?? ""
        
        if let skills = createSkillsArray(skillsJson: skills){
            result?.skills = skills
        }
        
        return result
    }
    
    class func createSkillsArray(skillsJson: [JSON]) -> [Skill]?{
        var skills: [Skill]?
        
        for item in skillsJson{
            let skill:Skill = Skill(
                level: item[ModelsKeys.keyUserCursusSkillLevel].double ?? 0.0,
                name: item[ModelsKeys.keyUserCursusCursusName].string ?? ""
            )
            skills?.append(skill)
        }
        
        return skills
    }
}
