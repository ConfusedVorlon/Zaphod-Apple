//
//  File.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import Foundation
import SwiftUI

/// Strings to show when using the signup UI
@available(macOS 10.15.0, iOS 13.0, *)
public struct SignupText {

    static let appPlaceholder="APPNAME"

    var emailHeading: String
    var emailBody: String
    var emailFrom: String?
    var emailYesButton: String
    var emailNoButton: String
    var notificationHeading: String
    var notificationBody: String
    var notificationYesButton: String
    var notificationNoButton: String

    var backgroundColors: [Color] = [Color(red: 0.93, green: 0.91, blue: 0.90),
                                  Color(red: 1, green: 1, blue: 1)]

    /// Example text - you can use this directly if you like!
    public static let newFeaturesOtherApps: SignupText = {
        let emailBody = """
I'd love to let you know when I release new features and other apps.

If you'd like to hear from me, then please enter your email below.

Either way - Enjoy APPNAME 😀
"""
        let notificationBody = """
Can I send you notifications about updates and news?
"""

        return SignupText(emailHeading: "Thank you for Installing APPNAME",
                          emailBody: emailBody,
                          emailYesButton: "Keep Me Updated",
                          emailNoButton: "No Thanks, Skip This",
                          notificationHeading: "Update Notifications?",
                          notificationBody: notificationBody,
                          notificationYesButton: "Sounds Great!",
                          notificationNoButton: "No Thanks"
        )
    }()

    public init(emailHeading: String,
                emailBody: String,
                emailFrom: String? = nil,
                emailYesButton: String,
                emailNoButton: String,
                notificationHeading: String,
                notificationBody: String,
                notificationYesButton: String,
                notificationNoButton: String) {
        self.emailHeading = emailHeading
        self.emailBody = emailBody
        self.emailFrom = emailFrom
        self.emailYesButton = emailYesButton
        self.emailNoButton = emailNoButton
        self.notificationHeading = notificationHeading
        self.notificationBody = notificationBody
        self.notificationYesButton = notificationYesButton
        self.notificationNoButton = notificationNoButton
    }

    /// Set the 'from' string easily on the default
    /// - Parameter newFrom: new string
    /// - Returns: updated SignupText
    public func from(_ newFrom: String) -> SignupText {
        var text = self
        text.emailFrom = newFrom
        return text
     }

    internal mutating func doReplacements() {
        guard let appName = Bundle.main[.name] as? String else {
            return
        }

        self.emailHeading = self.emailHeading.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailBody = emailBody.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailYesButton = emailYesButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        emailNoButton = emailNoButton.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        if let from = emailFrom {
            self.emailFrom = from.replacingOccurrences(of: SignupText.appPlaceholder, with: appName)
        }
    }

}
