//
//  StringExtension.swift
//  MeetingCost
//
//  Created by AleksandrVnukov on 9/3/18.
//  Copyright © 2018 MeetingCostCalculator. All rights reserved.
//

import Foundation

extension String
{
    var localized: String
    {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func hasChars() -> Bool
    {
        if self.count <= 0
        {
            return false
        }
        else
        {
            let isCorrect = self.isWhiteSpacesOrNewlines()
            
            return isCorrect
        }
    }
    
    func isWhiteSpacesOrNewlines() -> Bool
    {
        let whiteSpaceNewLineCharSet = CharacterSet.whitespacesAndNewlines
        let nonWhiteSpaceNewlineStr = self.components(separatedBy: whiteSpaceNewLineCharSet).joined(separator: "")
        
        return nonWhiteSpaceNewlineStr.count > 0
    }
}

