//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation
import UserNotifications

/// Configuration struct for Zaphod
public class ZaphodConfig {

    /// Get your token from https://Zaphod.app
    let token:String
    
    /// By default, this is calculated from your bundle id - but you can use your own if you like
    let identifier:String

    /// Debugging - use local server
    let localhost:Bool
    
    /// The permissions requested when asking to display notifications
    /// This is implemented as a separate property to allow suppoft for earlier macOS versions
    /// If you don't want the defaults, then change your config before calling Zaphod.setup
    @available(iOS 10.0,macOS 10.14, *)
    var notificationPermissions:UNAuthorizationOptions {
        get {
            return (_notificationPermissions as? UNAuthorizationOptions) ?? [UNAuthorizationOptions.alert,UNAuthorizationOptions.badge]
        }
        set {
            _notificationPermissions = newValue
        }
    }
    private var _notificationPermissions:Any?

    public init(token: String,
                identifier newIdentifier:String? = nil,
                localhost:Bool = false) {
        self.token = token
        self.localhost = localhost
        if let newIdentifier = newIdentifier {
            self.identifier = ZaphodConfig.sanitise(newIdentifier)
        }
        else {
            guard let bundleId = Bundle.main[.id] as? String else {
                fatalError("Unable to read bundle id")
            }
            self.identifier = ZaphodConfig.sanitise(bundleId)
        }
    }
    
    private static func sanitise(_ identifier:String)->String {
        let lower = identifier.lowercased()
        let allowed = lower.replacingOccurrences( of:"[^0-9a-z]", with: "-", options: .regularExpression)
        return allowed
    }
    
}
