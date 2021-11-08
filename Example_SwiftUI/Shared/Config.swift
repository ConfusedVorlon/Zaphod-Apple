//
//  Config.swift
//  Example_ios_mac
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation
import Zaphod

class Config {
    //As soon as shared is called, that triggers init() which initialises Zaphod
    static let shared = Config()
    let zaphod:Zaphod
    
    private init() {
        //You'll normally do this setup in your appDidFinishLaunching
        //In this example I'm doing it here so that we can keep a very simple SwiftUI app
        //without relying on the iOS 14 UIApplicationDelegateAdaptor
    
        let zaphodConfig = ZaphodConfig(token: "k2uytceBKkt7RbgFFU3c2iAJ")
        Zaphod.setup(zaphodConfig)
        zaphod = Zaphod.shared
    }
}
