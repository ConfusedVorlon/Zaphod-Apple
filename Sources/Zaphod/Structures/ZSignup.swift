//
//  File.swift
//  
//
//  Created by Rob Jonson on 12/11/2021.
//

import Foundation

struct ZSignupWrapper: ZJson, Equatable {
    var user: ZSignup

    enum CodingKeys: String, CodingKey {
        case user="app_user"
    }
}

struct ZSignup: ZJson, Equatable {
    var serverId: UUID?
    var email: String?
    var applePush: String?

    enum CodingKeys: String, CodingKey {
        case serverId="id"
        case email
        case applePush="apple_push"
    }
}
