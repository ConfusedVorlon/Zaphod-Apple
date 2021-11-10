//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

class PreferenceSync {
    static var canSync:Bool = false {
        didSet {
            if !canSync && oldValue != canSync {
                print("Zaphod unable to synchronise keys via iCloud")
            }
        }
    }
    
    
    struct Notif {
        static let changed = NSNotification.Name.init(rawValue: "ZaphodPreferenceSyncChange")
    }
    
    @objc class func updateToiCloud(_ notificationObject: Notification?) {

        let dict = UserDefaults.standard.dictionaryRepresentation()
        dict.forEach { (key: String, value: Any) in
            if let prefKey = ZPreference.Key(rawValue: key), prefKey.shouldSync {
                NSUbiquitousKeyValueStore.default.set(value, forKey: key)
            }
        }

        canSync = NSUbiquitousKeyValueStore.default.synchronize()
    }

    @objc class func updateFromiCloud(_ notificationObject: Notification?) {

        let iCloudStore = NSUbiquitousKeyValueStore.default
        let dict = iCloudStore.dictionaryRepresentation
        var newSyncRequired = false

        // prevent NSUserDefaultsDidChangeNotification from being posted while we update from iCloud

        NotificationCenter.default.removeObserver(
            self,
            name: UserDefaults.didChangeNotification,
            object: nil)

        dict.forEach { (key: String, value: Any) in
            if let prefKey = ZPreference.Key(rawValue: key), prefKey.shouldSync {
                let needsSync = ZPreference.synchronisePref(object: value, for: prefKey)
                if needsSync {
                    newSyncRequired = true
                }
            }
        }
        
        UserDefaults.standard.synchronize()
        
        if newSyncRequired {
            updateToiCloud(nil)
        }

        // enable NSUserDefaultsDidChangeNotification notifications again
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateToiCloud(_:)),
            name: UserDefaults.didChangeNotification,
            object: nil)

        NotificationCenter.default.post(name: Notif.changed, object: nil)
    }

    class func start() {

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateFromiCloud(_:)),
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: nil)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateToiCloud(_:)),
            name: UserDefaults.didChangeNotification,
            object: nil)

    }

    class func dealloc() {

        NotificationCenter.default.removeObserver(
            self,
            name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
            object: nil)

        NotificationCenter.default.removeObserver(
            self,
            name: UserDefaults.didChangeNotification,
            object: nil)
    }
}
