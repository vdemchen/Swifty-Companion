import Alamofire
import Alamofire_SwiftyJSON

class AlamofireManager{
    
    private var token: String?
    let decoder = JSONDecoder()
    
    private let config: [String:String] = [
        ModelsKeys.keyGrantType: ModelsKeys.clientCradentials,
        ModelsKeys.keyCliendId: ModelsKeys.uidKey,
        ModelsKeys.keyClientSecret: ModelsKeys.secretKey
    ]
    
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
    
    
    class func createHeader(_ token: String) -> HTTPHeaders{
        let header: HTTPHeaders = [
            ModelsKeys.keyAuthoriztion: ("\(ModelsKeys.keyBearer) \(token)"),
            ModelsKeys.keyAccept: ModelsKeys.acceptData
        ]
        return header
    }
    
    
    func getUserRequsest(userName: String, complition: @escaping(_ user: User?,_ error: String?)->()){
        
        self.createToken(complition: { (token) in
            let  header = AlamofireManager.createHeader(token ?? "")
            print(2)
            Alamofire.request(ModelsKeys.userGetLink+userName, method: .get, headers: header)
                .responseSwiftyJSON(completionHandler: { (dataResponse) in
                    
                    guard let json = dataResponse.value else {complition(nil, nil); return}
                    JsonManager.init(json)
                    complition(User.shareUser(), nil)
            })
        })
    }
}
