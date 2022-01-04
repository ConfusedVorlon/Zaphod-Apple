//
//  File.swift
//  
//
//  Created by Rob Jonson on 10/11/2021.
//

import Foundation
import Zaphod

#if os(iOS)
import UIKit

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil
    ) -> Bool {

        configureZaphod()

        return true
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {

        Zaphod.shared.set(notificationToken: deviceToken)
    }
}

#elseif os(macOS)
import AppKit

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        configureZaphod()
    }

}

#endif

extension AppDelegate {
    func configureZaphod() {
        let zaphodConfig = ZaphodConfig(token: "k2uytceBKkt7RbgFFU3c2iAJ")
        Zaphod.setup(zaphodConfig)
    }
}
