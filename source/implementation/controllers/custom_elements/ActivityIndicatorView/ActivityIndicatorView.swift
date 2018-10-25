//
//  ActivityIndicatorView.swift
//  MeetingCost
//
//  Created by AleksandrVnukov on 9/11/18.
//  Copyright © 2018 MeetingCostCalculator. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView
{
    @IBOutlet weak private var backgroundActivityView: UIView!
    @IBOutlet weak private var activityTitleLabel: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        
        self.backgroundActivityView.layer.cornerRadius = 5.0
    }
    
    private class func activityDuration() -> Double {
        return 0.3
    }

    class func showActivity()
    {
        return ActivityIndicatorView.showActivityWith(title: "")
    }
    
    class func showActivityWith(title: String)
    {
        let view = Bundle.main.loadNibNamed(ActivityIndicatorView.className(), owner: self, options: nil)?.first as! ActivityIndicatorView
        
        if title.count > 0
        {
            view.activityTitleLabel.text = title
        }
        
        view.alpha = 0.0
        view.frame = (UIApplication.shared.keyWindow?.frame)!
        view.layoutIfNeeded()
        UIApplication.shared.keyWindow?.addSubview(view)
        
        UIView.animate(withDuration: ActivityIndicatorView.activityDuration()) {
            view.alpha = 1.0
        }
    }
    
    class func hideActivity(activity: ActivityIndicatorView)
    {
        UIView.animate(withDuration: ActivityIndicatorView.activityDuration(), animations: {
            activity.alpha = 0.0
        }) { (isFinished) in
            
            if isFinished
            {
                activity.removeFromSuperview()
            }
            
        }
    }
    
    class func hideAllActivity()
    {
        for curActivity in (UIApplication.shared.keyWindow?.subviews)!
        {
            if curActivity.isKind(of: ActivityIndicatorView.self)
            {
                ActivityIndicatorView.hideActivity(activity: curActivity as! ActivityIndicatorView)
            }
        }
    }
}
