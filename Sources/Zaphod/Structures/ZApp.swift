//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

public struct ZApp: ZJson {
    public let name: String
    public let identifier: String
    public let slug: String
    public let latestNews: Date
    public let newsUrl: URL
    public let faqUrl: URL
    public let faqCount: Int

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
