//
//  Validator.swift
//  FortuneReact
//
//  Created by Alex de France on 12/31/17.
//  Copyright © 2017 Alex de France. All rights reserved.
//

import Foundation


class DataValidator {
    class func validName(name:String) -> Bool {
        if let regex =
            try? NSRegularExpression(pattern: "^\\w+( \\w+\\.?)*$", options: .caseInsensitive) {
            return name.lengthOfBytes(using: String.Encoding.utf8) > 2 &&
                regex.matches(in: name, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, name.lengthOfBytes(using: String.Encoding.utf8))).count > 0
        }
        return false
    }
    
    class func validEmail(email:String)  -> Bool{
        if let regex =
            try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .caseInsensitive){
            return regex.matches(in: email, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, email.lengthOfBytes(using: String.Encoding.utf8))).count > 0
        }
        return false
    }
} // end DataValidator 
