//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

struct ZApp:ZJson {
    let name:String
    let identifier:String
    let slug:String
    let latestNews:Date
    let news_url:URL
    let faq_url:URL
    
    enum CodingKeys: String, CodingKey {
        case name
        case identifier
        case slug
        case latestNews="latest_news"
        case news_url
        case faq_url
    }
}
