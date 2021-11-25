//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/11/2021.
//

import Foundation

extension Zaphod {
    public var faqURL:URL {
        if let url = ZPreference.appInfo?.faqUrl {
            return url
        }

        var urlC = URLComponents(url: Zaphod.serverURL, resolvingAgainstBaseURL: false)!
        urlC.path = "/a/na/faqs"
        urlC["identifier"]=config.identifier
        
        return urlC.url!
    }
    
}
