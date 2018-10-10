//
//  FindUserViewController.swift
//  SwiftyCompanion
//
//  Created by Vlad Demchenko on 10/10/18.
//  Copyright © 2018 Vlad Demchenko. All rights reserved.
//

import UIKit

class FindUserViewController: BaseViewController {
    @IBOutlet weak var loginInputField: UITextField!
    
    @IBAction func findUserButtom(_ sender: Any){
        guard let login = loginInputField.text else {return}
        if !login.isEmpty{
            showAlertWith(title: login)
            UserServices.getUser(nameOfUser: login)
        }
        else{
            showErrorAlertWith(message: "Non valid")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginInputField.placeholder = "Input student login"
        
        
        AlamofireManager().createToken { (result) in
            guard let token = result else {return}
            let header = AlamofireManager.createHeader(token)
            print(String(describing: header))
        }
    }
}
