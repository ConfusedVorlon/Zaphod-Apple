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
        
        print("Zaphod: setting email to: \(email)")
        ZPreference.hasRegisteredEmail = true
        updateSubscribeInfo(email: email)
    }
    
    public func set(notificationToken:Data?) {
        guard let notificationToken = notificationToken else {
            return
        }
        
        guard let string = String(data: notificationToken, encoding: .utf8) else {
            assert(false,"notification token doesn't want to be a string...")
        }
        print("setting device token to: \(notificationToken)")
        updateSubscribeInfo(applePush: string)
    }
    
    public func requestNotificationPermission(completion:@escaping()->Void) {
        if #available(macOS 10.14,iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: Zaphod.shared.config.notificationPermissions) { granted, error in
                
                if let error = error {
                    print("error requesting notification permission: \(error)")
                }
                
                ZPreference.hasNotificationPermission = granted
                completion()
            }
        } else {
            completion()
            //Notifications not supported pre UNUserNotificationCenter
        }
    }
    
    
    /// Update signup info internally
    /// - Parameters:
    ///   - serverId: server id for signup (synced in iCloud)
    ///   - email: email given on this device
    ///   - applePush: push token for this device
    ///   - doNotSync: allow server id to be updated by the server without a server sync
    internal func updateSubscribeInfo(serverId:UUID? = nil,
                                    email:String? = nil,
                                      applePush:String? = nil,
                                      doNotSync:Bool = false) {
        

        let initialState = ZPreference.signupInfo
        var newState = initialState
        
        if let serverId = serverId {
            newState.serverId = serverId
        }
        
        if let email = email {
            newState.email = email
        }
        
        if let applePush = applePush {
            newState.applePush = applePush
        }
        
        ZPreference.signupInfo = newState
        
        if doNotSync {
            return
        }
        
        if initialState != newState {
            ZPreference.signupInfoNeedsSync = true
            scheduleSignupInfoSync()
        }
    }
    
    internal func scheduleSignupInfoSync() {
        doSignupInfoSync()
    }
    
    private func doSignupInfoSync() {
        let url = appsURL
            .appendingPathComponent("/app_users")
        
        let info = ZPreference.signupInfo
        let user = ZSignupWrapper(user:info)
        
        guard let request = try? APIRequest(method: .post, url: url,body:user) else {
            assert(false, "this shouldn't fail...")
            return
        }
        request.authorise(token: config.token)
        
        //set this false immediately - we can unset it if there is an error
        ZPreference.signupInfoNeedsSync = false

        APIClient<ZSignupWrapper>().fetch(request) {
            result in
            switch result {
            case .success(let wrapper):
                print("Zaphod: sent signup info to server")
                self.updateSubscribeInfo(serverId: wrapper.user.serverId, doNotSync: true)
            case .failure(let error):
                print("Zaphod: Error performing network request \(error)")
                //next time the app is launched, or info changes, we'll try again
                ZPreference.signupInfoNeedsSync = true
            }
        }
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
