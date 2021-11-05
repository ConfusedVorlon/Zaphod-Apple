//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

class Preference {
    static let prefix = "Zaphod_"

    private enum Key:String {
        case newsLastViewed
        case latestNews
    
        var key:String {
            return Preference.prefix + self.rawValue
        }
    }
    
    private static func pref(for key:Key) -> Any? {
        UserDefaults.standard.object(forKey: key.key)
    }
    
    private static func setPref(_ object:Any?,for key:Key){
        UserDefaults.standard.set(object, forKey: key.key)
    }
    
    static var newsLastViewed:Date {
        get {
            return pref(for: .newsLastViewed) as? Date ?? Date.distantPast
        }
        set {
            setPref(newValue, for: .newsLastViewed)
        }
    }
    
    static var latestNews:Date? {
        get {
            return pref(for: .newsLastViewed) as? Date
        }
        set {
            setPref(newValue, for: .newsLastViewed)
        }
    }
    
    static func debugReset() {
        setPref(nil, for: .newsLastViewed)
        setPref(nil, for: .latestNews)
    }
}
