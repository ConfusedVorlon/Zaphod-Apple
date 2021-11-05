//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/11/2021.
//

import Foundation

/// Configuration struct for Zaphod
public struct ZaphodConfig {

    /// Get your token from https://Zaphod.app
    let token:String
    let identifier:String
    let checkForUpdates:Bool

    public init(token: String, identifier newIdentifier:String? = nil ,checkForUpdates: Bool = true) {
        self.token = token
        self.checkForUpdates = checkForUpdates
        if let newIdentifier = newIdentifier {
            self.identifier = ZaphodConfig.sanitise(newIdentifier)
        }
        else {
            guard let bundleId = Bundle.main[.id] as? String else {
                fatalError("Unable to read bundle id")
            }
            self.identifier = ZaphodConfig.sanitise(bundleId)
        }
    }
    
    private static func sanitise(_ identifier:String)->String {
        let lower = identifier.lowercased()
        let allowed = lower.replacingOccurrences( of:"[^0-9a-z]", with: "-", options: .regularExpression)
        return allowed
    }
    
}
