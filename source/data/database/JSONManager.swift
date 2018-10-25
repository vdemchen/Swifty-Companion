import SwiftyJSON
import Foundation

class JsonManager{
    // MARK: - Private properties
    private static var userJson = JSON()
    
    // MARK: - Init
    init(_ inputJson: JSON) {
        JsonManager.userJson = inputJson
    }
    
    // MARK: - Public methods
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
        
        if let campus = self.userJson[ModelsKeys.keyCampus].array{
            parameters.campusLocation = campus[0][ModelsKeys.keyCampusName].string ?? ""
        }
        return parameters
    }
    
    static func createCursus(cursusNumber: Int) -> Cursus?{
        
        guard let userCursus = self.userJson[ModelsKeys.keyUserCursus].array else {return nil}
        guard let skills = userCursus[cursusNumber][ModelsKeys.keyUserCursusSkills].array else {return nil}
        guard let cursus = userCursus[cursusNumber][ModelsKeys.keyUserCursusCursus].dictionary else {return nil}
        
        guard let userProjects = self.userJson[ModelsKeys.keyProjects].array else {return nil}
        
        
        var result: Cursus = Cursus(
            name: cursus[ModelsKeys.keyUserCursusCursusName]?.string ?? "",
            grade: userCursus[cursusNumber][ModelsKeys.keyUserCursusGrade].string ?? "",
            level: userCursus[cursusNumber][ModelsKeys.keyUserCursusLevel].double ?? 0.0,
            projects: nil,
            skills: nil,
            piscines: nil
        )
        
        if let skills: [Skill] = createSkillsArray(skillsJson: skills){
            result.skills = skills
        }
        
        if let projects: [Project] = createProjectsArray(projectsJson: userProjects){
            result.projects = projects
        }
        if let piscines: [Piscine] = createPiscineArray(projectsJson: userProjects){
            result.piscines = piscines
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
    
    class func createProjectsArray(projectsJson: [JSON]) -> [Project]?{
        var projects: [Project] = [Project]()
        
        for item in projectsJson{
            guard let project = item[ModelsKeys.keyProjectsDetail].dictionary else {return nil}
            if project[ModelsKeys.keyProjectsDetailParentId]?.int == nil
                && item[ModelsKeys.keyCursusIds].array?[0] == 1{
                let project: Project = Project(
                    name: project[ModelsKeys.keyProjectsDetailName]?.string ?? "",
                    validationStatus: item[ModelsKeys.keyProjectsValidate].bool ?? false,
                    projectMark: item[ModelsKeys.keyProjectsFinalMark].int ?? 0,
                    projectId: project[ModelsKeys.keyProjectsDetailId]?.int ?? 0,
                    slug: item[ModelsKeys.keyProjectsDetailSlug].string ?? "",
                    projectStatus: item[ModelsKeys.keyProjectsStatus].string ?? ""
                )
                projects.append(project)
            }
        }
        return projects
    }
    
    class func createPiscineArray(projectsJson: [JSON]) -> [Piscine]?{
        var piscines: [Piscine] = [Piscine]()
        
        projectsJson.forEach(){item in
            guard let project = item[ModelsKeys.keyProjectsDetail].dictionary else {return}
            guard let slug: String = project[ModelsKeys.keyProjectsDetailSlug]?.string else {return}
            
            if slug.contains(ModelsKeys.keyPiscine){
                guard let projectId = project[ModelsKeys.keyProjectsDetailParentId]?.int else {return}
                
                if project[ModelsKeys.keyProjectsDetailParentId]?.int != nil
                    && item[ModelsKeys.keyCursusIds].array?[0] == 1{
                    let name: String = findPiscineName(parentId: projectId, projects: projectsJson)
                    let days: [Project] = getPiscineDays(parentId: projectId, projects: projectsJson)
                    let piscine: Piscine = Piscine(name: name, days: days)
                    if !piscines.contains(where: { (Piscine) -> Bool in Piscine.piscineName == name}){
                        piscines.append(piscine)
                    }
                }
            }
        }
        
        return piscines
    }
    
    class func findPiscineName(parentId: Int, projects: [JSON]) -> String{
        var piscineName: String = ""
        
        for item in projects{
            guard let project = item[ModelsKeys.keyProjectsDetail].dictionary else {return ""}
            guard let Id = project[ModelsKeys.keyProjectsDetailId]?.int else {return ""}
            
            if Id == parentId{
                piscineName = project[ModelsKeys.keyProjectsDetailName]?.string ?? ""
                break
            }
        }
        return piscineName
    }
    
    class func getPiscineDays(parentId: Int, projects: [JSON]) -> [Project]{
        var piscine: [Project] = [Project]()
        
        projects.forEach { (item) in
            if let project = item[ModelsKeys.keyProjectsDetail].dictionary{
                if project[ModelsKeys.keyProjectsDetailParentId]?.int == parentId{
                    let day: Project = Project(
                        parentId: parentId,
                        name: project[ModelsKeys.keyProjectsDetailName]?.string ?? "",
                        validationStatus: item[ModelsKeys.keyProjectsValidate].bool ?? false,
                        projectMark: item[ModelsKeys.keyProjectsFinalMark].int ?? 0,
                        projectId: project[ModelsKeys.keyProjectsDetailId]?.int ?? 0,
                        slug: item[ModelsKeys.keyProjectsDetailSlug].string ?? "",
                        projectStatus: item[ModelsKeys.keyProjectsStatus].string ?? ""
                    )
                    piscine.append(day)
                }
            }
        }
        return piscine
    }
}
