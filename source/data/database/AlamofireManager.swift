//
//  AlamofireManager.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/10/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import Alamofire


class AlamofireManager: NSObject{
    
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
            do{
                let tokenData = try self.decoder.decode(ModelsKeys.token_info.self, from: json)
                complition(tokenData.access_token)
            }
            catch let error{
                print(String(describing: error))
            }
        }
    }
    
    
    class func createHeader(token: String) -> HTTPHeaders{
        let header: HTTPHeaders = [
            ModelsKeys.keyAuthoriztion: ("\(ModelsKeys.keyBearer) \(token)"),
            ModelsKeys.keyAccept: ModelsKeys.acceptData
        ]
        return header
    }
    
    
    
    func getUSerName(complition: @escaping(String?)->()){
        
    }
}
