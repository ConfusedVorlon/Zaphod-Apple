//
//  File.swift
//  
//
//  Created by Rob Jonson on 06/11/2021.
//

import Foundation

protocol ZJson:Codable {
    var jsonData:Data? {get}
}

extension ZJson {
    var jsonData:Data? {
        let encoder = JSONEncoder()
        if #available(macOS 10.12,iOS 10.0, *) {
            encoder.dateEncodingStrategy = .iso8601
        } else {
            // Fallback on earlier versions
        }

        return try? encoder.encode(self)
    }
}

extension Data {
    func decode<ResponseType>() -> ResponseType? where ResponseType:Decodable {
        let decoder = JSONDecoder()
        if #available(macOS 10.12,iOS 10.0, *) {
            decoder.dateDecodingStrategy = .iso8601
        }
        
        do {
            return try decoder.decode(ResponseType.self, from: self)
        } catch {
            print("error decoding\(error)")
            return nil
        }
    }
}
