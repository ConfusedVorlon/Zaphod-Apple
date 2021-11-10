//
//  File.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import Foundation

public struct SignupText {
    static let appPlaceholder="APPNAME"
    
    var emailHeading:String
    var emailBody:String
    var from:String?
    var emailYesButton:String
    var emailNoButton:String
    
   public func from(_ newFrom:String) -> SignupText{
       var text = self
       text.from = newFrom
       return text
    }
    

    public static let newFeaturesOtherApps:SignupText = {
        let body = """
I'd love to let you know when I release new features and other apps.

If you'd like to hear from me, then please enter your email below.

Either way - Enjoy APPNAME 😀
"""
        return SignupText(emailHeading: "Thank you for Installing APPNAME",
                          emailBody:body,
                          emailYesButton:"Keep Me Updated",
                          emailNoButton:"No Thanks, Skip This"
        )
    }()
    
    internal mutating func doReplacements() {
        guard let appName = Bundle.main[.name] as? String else {
            return
        }
        
        self.emailHeading = self.emailHeading.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailBody = emailBody.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailYesButton = emailYesButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailNoButton = emailNoButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        if let from = from {
            self.from = from.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        }
    }
    
}
