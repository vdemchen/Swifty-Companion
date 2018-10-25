import Foundation

class UserServices: NSObject {
    
    class func getUser(userLogin: String, complition: @escaping(_ result: String?)->()){
        AlamofireManager().getUserRequsest(userName: userLogin) { (result) in
            if result != nil {
                complition(result)
            }
        }
    }
    
    class func getCoalitionNumber(userLogin: String, complition: @escaping(_ result: Int)->()){
        AlamofireManager().getUserCoalition(userName: userLogin) { (result) in
            if result != 0{
                complition(result)
            }
        }
    }
}
