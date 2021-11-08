//
//  Example_ios_macApp.swift
//  Shared
//
//  Created by Rob Jonson on 05/11/2021.
//

import SwiftUI

@main
struct Example_SwiftUIApp: App {
    init() {
        //ensure that Config.shared is called to initialise Zaphod
        //you'll normally do this in appDidFinishLaunching
        _ = Config.shared
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
