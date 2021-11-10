//
//  File.swift
//  
//
//  Created by Rob Jonson on 10/11/2021.
//

import Foundation
import UserNotifications

#if os(iOS)
    import UIKit
#elseif os(macOS)
    import AppKit
#endif

extension Zaphod {
    public func set(email:String) throws {
        guard let email = EmailTextFieldValidator.validate(input: email) else {
            throw Fail.emailNotValid
        }
        
        print("setting email to: \(email)")
        ZPreference.hasRegisteredEmail = true
    }
    
    public func set(notificationToken:Data?) {
        print("setting device token to: \(notificationToken)")
    }
    
    internal func setupForNotifications() {
        if #available(macOS 10.14,iOS 10.0, *) {
#if os(iOS)
            UIApplication.shared.registerForRemoteNotifications()
#elseif os(macOS)
            NSApplication.shared.registerForRemoteNotifications()
#endif
            
            UNUserNotificationCenter.current().getNotificationSettings { settings in
                if settings.authorizationStatus == .authorized,
                   settings.alertSetting == .enabled {
                    ZPreference.hasNotificationPermission = true
                }
                else {
                    ZPreference.hasNotificationPermission = false
                }
            }
            
        } else {
            //Notifications not supported pre UNUserNotificationCenter
        }
        
    }
}
