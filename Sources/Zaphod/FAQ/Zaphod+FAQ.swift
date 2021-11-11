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

        var urlC = URLComponents(string: "https://zaphod.app/a/na/faqs")!
        urlC["identifier"]=config.identifier
        
        return urlC.url!
    }
    
}
