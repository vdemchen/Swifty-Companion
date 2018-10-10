//
//  ModelsKeys.swift
//  MeetingCost
//
//  Created by AleksandrVnukov on 9/5/18.
//  Copyright © 2018 MeetingCostCalculator. All rights reserved.
//

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
    
    
    static let tokenLink = "https://api.intra.42.fr/oauth/token"
    static let apiLink = "https://api.intra.42.fr/"
    
    static let keyGrantType = "grant_type"
    static let keyCliendId = "client_id"
    static let keyClientSecret = "client_secret"
    static let keyAuthoriztion = "Authorization"
    static let keyAccept = "Accept"
}
