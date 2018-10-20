import UIKit

class ModelsKeys: NSObject
{
    
    struct token_info: Codable {
        var access_token: String?
    }

    static let uidKey = "40e00e597e7d1bdb2aced79d5e070daec7247aea2b83a7872a2489bbd75388db"
    static let secretKey = "ddee40b66e4b49d231182d466bd6655055c32f22dc88b3ecea2ebcd1400cad20"
    static let clientCradentials = "client_credentials"
    static let acceptData = "application/json"
    static let keyBearer = "Bearer"
    
    static let userGetLink = "https://api.intra.42.fr/v2/users/"
    
    static let tokenLink = "https://api.intra.42.fr/oauth/token"
    static let apiLink = "https://api.intra.42.fr/"
    
    static let keyGrantType = "grant_type"
    static let keyCliendId = "client_id"
    static let keyClientSecret = "client_secret"
    static let keyAuthoriztion = "Authorization"
    static let keyAccept = "Accept"
    
    static let keyPiscine = "piscine"
    
    // Start JSON keys
    
    static let keyLastName = "last_name"
    static let keyFirstName = "first_name"
    static let keyImageUrl = "image_url"
    static let keyPoolYear = "pool_year"
    static let keyPoolMonth = "pool_month"
    static let keyCorrectionPoint = "correction_point"
    static let keyWallet = "wallet"
    static let keyPhoneNumber = "number"
    static let keyLogin = "login"
    static let keyEmail = "email"
    
    static let keyUserCursus = "cursus_users"
    static let keyUserCursusGrade = "grade"
    static let keyUserCursusLevel = "level"
    
    static let keyUserCursusCursus = "cursus"
    
    static let keyUserCursusCursusName = "name"
    static let keyUserCursusCursusSlug = "slug"
    
    static let keyUserCursusSkills = "skills"
    static let keyUserCursusSkillId = "id"
    static let keyUserCursusSkillName = "name"
    static let keyUserCursusSkillLevel = "level"
    
    
    static let keyCampus = "campus"
    static let keyCampusName = "name"
    
    
    static let keyProjects = "projects_users"
    
    static let keyProjectsFinalMark = "final_mark"
    static let keyProjectsValidate = "validate?"
    static let keyProjectsStatus = "status"
    static let keyProjectsDetail = "project"
    static let keyProjectsDetailName = "name"
    static let keyProjectsDetailId = "id"
    static let keyProjectsDetailParentId = "parent_id"
    static let keyProjectsDetailSlug = "slug"
    
    // End JSON keys
    
    
}
