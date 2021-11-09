//
//  File.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import Foundation
import SwiftUI


#if os(iOS)
import UIKit

@available(macOS 10.15.0,iOS 13.0, *)
extension UIColor {
    var color:Color {
        return Color(self)
    }
}

@available(iOS 13.0, *)
extension Color {
    static let backgroundColor = UIColor.systemBackground.color
}
#elseif os(macOS)
 
import AppKit

@available(macOS 10.15.0,iOS 13.0, *)
extension NSColor {
    var color:Color {
        return Color(self)
    }
}

@available(macOS 10.15.0, *)
extension Color {
    static let backgroundColor = NSColor.windowBackgroundColor.color
}

#endif

