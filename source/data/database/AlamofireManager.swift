//
//  AlamofireManager.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/10/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import Alamofire

struct token_info: Codable {
    var access_token: String?
}

class AlamofireManager{
    
    private let config: [String:String] = [
        "grand_type":"client_credentials",
        "client_id": ModelsKeys.uidKey,
        "client_secret": ModelsKeys.secretKey
    ]
    let decoder = JSONDecoder()
    private var token = String()
    
    
    init(){
        self.getToken { (token) in
            self.token = token
        }
        print(self.token)
    }
    
    
    func getToken(complition: @escaping(_ token: String)->()){
        Alamofire.request(ModelsKeys.tokenLink, method: .post, parameters: self.config).responseJSON { (response) in
            guard response.result.isSuccess else {print(String(describing: response.result.error)) ;return}
            guard let json = response.data  else {print(String(describing: response.result.error)) ;return}
            do{
                let tokenData = try self.decoder.decode(token_info.self, from: json)
                complition(tokenData.access_token ?? "")
            }
            catch let error{
                print(String(describing: error))
            }
        }
    }
    
    
}
