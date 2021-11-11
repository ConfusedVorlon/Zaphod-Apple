//
//  __PROJECT_NAME__.swift
//  __PROJECT_NAME__
//
//  Created by Rob Jonson on Nov 5, 2021.
//  Copyright © 2021 Hobbyist Software Limited. All rights reserved.
//

import Foundation
import SwiftUI


open class Zaphod{
    
    /// Main singleton accessor
    public static let shared = Zaphod()
    
    private static var config:ZaphodConfig?
    internal let config:ZaphodConfig
    
    /// Call setup with your ZConfig instance before accessing Zaphod.shared
    /// - Parameter config: Zaphod Configuration
    public class func setup(_ config:ZaphodConfig){
        Zaphod.config = config
        _ = Zaphod.shared
    }
    
    
    /// Access info that can power UI related to Zaphod
    public let ui = ZaphodInfo()
    
    public enum Fail: String,Error {
        case emailNotValid
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: PreferenceSync.Notif.changed,
            object: nil)
    }
    
    /// Don't use init directly - call setup() with your config, then use Zaphod.shared
    private init() {
        guard let config = Zaphod.config else {
            fatalError("Error - you must call Zaphod.setup(<config>) before accessing Zaphod.shared")
        }
        self.config = config
          
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(prefsDidSync),
            name: PreferenceSync.Notif.changed,
            object: nil)
        
        DispatchQueue.background.async {
            //PreferenceSync.start()
            self.getAppInfo()
        }
        
        setupForNotifications()
        
        updateUI()
    }

    @objc private func prefsDidSync() {
        updateUI()
    }
    
    internal func updateUI() {
        DispatchQueue.main.async {
            if let latestNews = ZPreference.appInfo?.latestNews  {
                self.ui.hasUnreadNews = (latestNews > ZPreference.newsLastViewed)
            }
            else {
                self.ui.hasUnreadNews = false
            }
        }
    }
    
    private func getAppInfo() {
        let url = URL(string: "https://Zaphod.app/api/z1/apps")!.appendingPathComponent(config.identifier)
        let request = APIRequest(method: .get, url: url)
        request.headers = [HTTPHeader(field: "Authorization", value: config.token)]
        
        APIClient<ZAppInfo>().fetch(request) {
            result in
            switch result {
            case .success(let info):
                ZPreference.appInfo = info.app
                print("Zaphod: Updated from server")
                self.updateUI()
            case .failure(let error):
                print("Zaphod: Error performing network request \(error)")
            }
        }

        
    }
    
    /// Use when debugging to test your UI as the state changes
    /// This deletes all stored state
    open func debugReset() {
        ZPreference.debugReset()
        updateUI()
        
        DispatchQueue.background.asyncAfter(delay: 2) {
            self.getAppInfo()
        }
    }

}
