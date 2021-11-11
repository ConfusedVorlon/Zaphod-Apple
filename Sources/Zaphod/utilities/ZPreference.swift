//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

public class ZPreference {
    static let prefix = "Zaphod_"
    
    internal enum Key:String, CaseIterable {
        case newsLastViewed = "Zaphod_newsLastViewed"
        case appInfo = "Zaphod_appInfo"
        case serverId = "Zaphod_serverID"
        case hasRegisteredEmail = "Zaphod_hasRegisteredEmail"
        case hasNotificationPermission = "Zaphod_hasNotificationPermission"
        
        var shouldSync:Bool {
            switch self {
            case .hasNotificationPermission:
                return false
            default:
                return true
            }
        }
        
        var key:String {
            return self.rawValue
        }
    }
    

    
    /// Handle a new value coming from iCloud
    /// - Parameters:
    ///   - object: new object
    ///   - key: key
    /// - Returns: return true if another synchronisation is required
    internal static func synchronisePref(object:Any?,for key:Key) -> Bool {
        switch key {
        case .newsLastViewed,.appInfo,.serverId:
            setPref(object, for: key)
            return false
            
        case .hasRegisteredEmail:
            guard let incomingValue = object as? Bool else {
                print("hasRegisteredEmail should be a bool...")
                return false
            }
            
            let oldValue = hasRegisteredEmail
            let newValue = oldValue || incomingValue
            setPref(newValue, for: .hasRegisteredEmail)
            if newValue != oldValue {
                return true
            }
            else {
                return false
            }
            
            
            
        case .hasNotificationPermission:
            assert(false,"this shouldn't sync!")
            return false
        }
        
        
    }
    
    public static var newsLastViewed:Date {
        get {
            return pref(for: .newsLastViewed) as? Date ?? Date.distantPast
        }
        set {
            setPref(newValue, for: .newsLastViewed)
        }
    }
    
    
    public static var appInfo:ZApp? {
        get {
            guard let data = pref(for: .appInfo) as? Data else {
                return nil
            }
            
            return data.decode()
        }
        set {
            setPref(newValue?.jsonData, for: .appInfo)
        }
    }
    
    static var serverId:String? {
        get {
            return pref(for: .serverId) as? String
        }
        set {
            setPref(newValue, for: .serverId)
        }
    }
    
    public static var hasRegisteredEmail:Bool {
        get {
            return pref(for: .hasRegisteredEmail) as? Bool ?? false
        }
        set {
            setPref(newValue, for: .hasRegisteredEmail)
        }
    }
    
    public static var hasNotificationPermission:Bool {
        get {
            return pref(for: .hasNotificationPermission) as? Bool ?? false
        }
        set {
            setPref(newValue, for: .hasNotificationPermission)
        }
    }
    
    public static func debugReset() {
        for key in Key.allCases {
            setPref(nil, for: key)
        }
    }
    
    //MARK: Workings...

    private static func pref(for key:Key) -> Any? {
        UserDefaults.standard.object(forKey: key.key)
    }
    
    private static func setPref(_ object:Any?,for key:Key){
        UserDefaults.standard.set(object, forKey: key.key)
    }
}
