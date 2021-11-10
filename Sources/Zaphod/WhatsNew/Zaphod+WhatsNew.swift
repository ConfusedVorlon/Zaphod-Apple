//
//  File.swift
//  
//
//  Created by Rob Jonson on 06/11/2021.
//

import Foundation

extension Zaphod {
    public var whatsNewURL:URL {
        if let url = ZPreference.appInfo?.news_url {
            return url
        }

        var urlC = URLComponents(string: "https://zaphod.app/a/na/news_items")!
        urlC["identifier"]=config.identifier
        
        return urlC.url!
    }
    
    public func markNewsAsSeen() {
        ZPreference.newsLastViewed = Date()
    }
}
