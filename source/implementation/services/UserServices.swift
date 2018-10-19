//
//  UserServices.swift
//  Gym
//
//  Created by Vlad Demchenko on 24.09.2018.
//  Copyright © 2018 prospekt. All rights reserved.
//

import Foundation

class UserServices: NSObject {

    class func getUser(userLogin: String) -> (){
        AlamofireManager().getUserRequsest(userName: "vdemchen") { (result) in
            if result != nil{
                print("Error\(#function, result)")
            }else {
             let user = User.shareUser()
            }
        }
    }
}

