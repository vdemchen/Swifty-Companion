import Alamofire
import Alamofire_SwiftyJSON

class AlamofireManager{
    
    
    // MARK: - Public properties
    let decoder = JSONDecoder()
    
    // MARK: - Private properties
    private var token: String?
    
    // MARK: - Public methods
    func createToken(complition: @escaping(String?)->()){
        Alamofire.request(ModelsKeys.tokenLink, method: .post, parameters: self.config).responseJSON { response in
            guard response.result.isSuccess else {print(String(describing: response.result.error)); return}
            guard let json = response.data  else {print(String(describing: response.result.error)); return}
            do
            {
                let tokenData = try self.decoder.decode(ModelsKeys.token_info.self, from: json)
                self.token = tokenData.access_token
                complition(tokenData.access_token)
            }
            catch let error{
                print(String(describing: error))
            }
        }
        complition(nil)
    }
    
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    class func createHeader(_ token: String) -> HTTPHeaders{
        let header: HTTPHeaders = [
            ModelsKeys.keyAuthoriztion: ("\(ModelsKeys.keyBearer) \(token)"),
            ModelsKeys.keyAccept: ModelsKeys.acceptData
        ]
        return header
    }
    
    class func downloadImage(_ imageUrl: String) -> UIImage?{
        var image: UIImage?
        
        if let url = URL(string: imageUrl){
            if let data = try? Data(contentsOf: url){
                image = UIImage(data: data)
            }
        }
        return image
    }
    
    func getUserRequsest(userName: String, complition: @escaping(_ error: String?)->()){
        
        self.createToken(complition: { (token) in
            if let token = token {
                let  header = AlamofireManager.createHeader(token)
                Alamofire.request(
                    ModelsKeys.userGetLink+userName,
                    method: .get,
                    headers: header
                    )
                    .responseSwiftyJSON(completionHandler: { (dataResponse) in
                        if dataResponse.error == nil{
                            guard let json = dataResponse.value
                                else {
                                    complition(String(describing:dataResponse.description))
                                    return
                            }
                            if json.count == 0{
                                complition("Haven`t user")
                            } else {
                                let _ :JsonManager = JsonManager.init(json)
                                let user :User = User.shareUser()
                                UserServices.getCoalitionNumber(userLogin: userName, complition: { (number) in
                                    if number != 0{
                                        user.parameters?.coalition = number
                                        complition(nil)
                                    }
                                })
                            }
                        }
                    })
            }
        })
    }
    
    func getUserCoalition(userName: String, complition: @escaping(_ result: Int)->()){
        
        self.createToken(complition: { (token) in
            if let token = token {
                let  header = AlamofireManager.createHeader(token)
                Alamofire.request(
                    ModelsKeys.userGetLink+userName+ModelsKeys.coalitionGet,
                    method: .get,
                    headers: header
                    )
                    .responseSwiftyJSON(completionHandler: { (dataResponse) in
                        if dataResponse.error == nil{
                            guard let json = dataResponse.value
                                else {
                                    complition(0)
                                    return
                            }
                            if json.count == 0{
                                complition(0)
                            } else {
                                complition(json[0][ModelsKeys.keyCoalitionId].int ?? 0)
                            }
                        }
                    })
            }
        })
    }
    
    // MARK: - Private methods
    private let config: [String:String] = [
        ModelsKeys.keyGrantType: ModelsKeys.clientCradentials,
        ModelsKeys.keyCliendId: ModelsKeys.uidKey,
        ModelsKeys.keyClientSecret: ModelsKeys.secretKey
    ]
    
   
   
}
