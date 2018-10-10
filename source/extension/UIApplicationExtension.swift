//
//  UIApplicationExtension.swift
//  MeetingCost
//
//  Created by AleksandrVnukov on 9/3/18.
//  Copyright © 2018 MeetingCostCalculator. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication
{
    var statusBarView: UIView?
    {
        let statusBar = "statusBar"
        
        if responds(to: Selector((statusBar)))
        {
            return value(forKey: statusBar) as? UIView
        }
        
        return nil
    }
}
