//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation
#if canImport(Combine)
import Combine
#endif



/// If you're using a recent(ish) version of iOS or MacOS, then you can use ZaphodInfo as an ObservableObject
/// Either include directly in SwiftUI code - or use combine to watch for changes
/// If you're on an older version - then you can watch for changes via the ZaphodInfo.Notif.changed notification
public class ZaphodInfo {
    struct Notif {
        static let changed = NSNotification.Name("ZaphodInfoChangedNotification")
    }
    
    /// Whether there is news more recent than the last time Zaphod.markNewsAsSeen() was called
    public var hasUnreadNews:Bool = false {
        willSet {
            sendChangeIfSupported()
        }
        didSet {
            if oldValue != hasUnreadNews {
                sendChangeNotification()
            }
        }
    }
    
    internal func sendChangeNotification() {
        NotificationCenter.default.post(name: Notif.changed, object: self)
    }
    
    private func sendChangeIfSupported() {
        if #available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *) {
            self.objectWillChange.send()
        }
    }
}

@available(iOS 13.0, OSX 10.15, tvOS 13.0, watchOS 6.0, *)
extension ZaphodInfo:ObservableObject {
    
}


