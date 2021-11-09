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
    var body:String
    var from:String?
    var yesButton:String
    var noButton:String
    
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
                          body:body,
                          yesButton:"Keep Me Updated",
                          noButton:"No Thanks, Skip This"
        )
    }()
    
    internal mutating func doReplacements() {
        guard let appName = Bundle.main[.name] as? String else {
            return
        }
        
        self.emailHeading = self.emailHeading.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        body = body.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        yesButton = yesButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        noButton = noButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        if let from = from {
            self.from = from.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        }
    }
    
}
