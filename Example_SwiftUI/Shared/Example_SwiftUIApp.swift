//
//  Example_ios_macApp.swift
//  Shared
//
//  Created by Rob Jonson on 05/11/2021.
//

import SwiftUI

@main
struct Example_SwiftUIApp: App {
  
#if os(iOS)
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#elseif os(macOS)
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
#endif
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
