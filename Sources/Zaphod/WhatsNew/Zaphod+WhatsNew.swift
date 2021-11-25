//
//  File.swift
//  
//
//  Created by Rob Jonson on 06/11/2021.
//

import Foundation

extension Zaphod {
    public var whatsNewURL:URL {
        if let url = ZPreference.appInfo?.newsUrl {
            return url
        }

        var urlC = URLComponents(url: Zaphod.serverURL, resolvingAgainstBaseURL: false)!
        urlC.path = "/a/na/news_items"
        urlC["identifier"]=config.identifier
        
        return urlC.url!
    }
    
    public func markNewsAsSeen() {
        ZPreference.newsLastViewed = Date()
        updateUI()
    }
}
