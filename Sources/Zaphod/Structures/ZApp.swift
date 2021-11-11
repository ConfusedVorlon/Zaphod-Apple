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
    let newsUrl:URL
    let faqUrl:URL
    let faqCount:Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case identifier
        case slug
        case latestNews="latest_news"
        case newsUrl="news_url"
        case faqUrl="faq_url"
        case faqCount="faq_count"
    }
}
