//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

struct ZApp:Codable {
    let name:String
    let identifier:String
    let slug:String
    let latestNews:String
    
    enum CodingKeys: String, CodingKey {
        case name
        case identifier
        case slug
        case latestNews="latest_news"
    } 
}
