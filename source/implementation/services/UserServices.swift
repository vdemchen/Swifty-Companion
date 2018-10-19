//
//  UserServices.swift
//  Gym
//
//  Created by Vlad Demchenko on 24.09.2018.
//  Copyright © 2018 prospekt. All rights reserved.
//

import Foundation

class UserServices: NSObject {

    class func getUser(userLogin: String, complition: @escaping(String)->()){
        AlamofireManager().getUserRequsest(userName: userLogin) { (user, error) in
            if error != nil{
                complition(error ?? "")
            }else{
                complition("")
            }
        }
    }
}

