import Foundation

class UserServices: NSObject {
    
    class func getUser(userLogin: String, complition: @escaping(_ result: String?)->()){
        AlamofireManager().getUserRequsest(userName: userLogin) { (result) in
            if result != nil {
                complition(result)
            }
        }
    }
}

