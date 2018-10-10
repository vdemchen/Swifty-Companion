//
//  UserServices.swift
//  Gym
//
//  Created by Vlad Demchenko on 24.09.2018.
//  Copyright © 2018 prospekt. All rights reserved.
//

import Foundation

class UserServices: NSObject {

    class func getUser(nameOfUser: String) -> User {
        AlamofireManager().getUserRequsest(userName: nameOfUser) { (user, error) in
            
        }
        return User()
    }
}

