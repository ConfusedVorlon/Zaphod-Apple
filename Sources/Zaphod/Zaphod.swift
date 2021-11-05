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
    private let config:ZaphodConfig
    
    public let ui = ZaphodInfo()
    
    /// Call setup with your ZConfig instance before accessing Zaphod.shared
    /// - Parameter config: Zaphod Configuration
    public class func setup(_ config:ZaphodConfig){
        Zaphod.config = config
    }
    
    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: PreferenceSync.Notif.changed,
            object: nil)
    }

    
    public func markNewsAsSeen() {
        Preference.newsLastViewed = Date()
    }
    
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
    }

    @objc private func prefsDidSync() {
        print("Update from iCloud prefs")
        updateUI()
    }
    
    private func updateUI() {
        DispatchQueue.main.async {
            if let latestNews = Preference.latestNews  {
                self.ui.hasUnreadNews = (latestNews > Preference.newsLastViewed)
            }
            else {
                self.ui.hasUnreadNews = false
            }
        }
    }
    
    private func getAppInfo() {
        let url = URL(string: "http://127.0.0.1:3000/api/z1/apps")!.appendingPathComponent(config.identifier)
        let request = APIRequest(method: .get, url: url)
        request.headers = [HTTPHeader(field: "Authorization", value: config.token)]
        
        APIClient<ZAppInfo>().fetch(request) {
            result in
            switch result {
            case .success(let info):
                print("Received app info: \(info)")
            case .failure(let error):
                print("Error performing network request \(error)")
            }
        }

        
    }
    
    func debugReset() {
        Preference.debugReset()
        updateUI()
        getAppInfo()
    }

}
