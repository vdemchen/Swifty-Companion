//
//  JSONManager.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/10/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import SwiftyJSON
import Foundation

class JsonManager: NSObject {

    private var userJson: JSON?
    
    init(inputJson: JSON){
        self.userJson = inputJson
        let user: Dictionary<String, JSON> = inputJson["phone"].dictionaryValue
        print("create")
    }
    
    
}
