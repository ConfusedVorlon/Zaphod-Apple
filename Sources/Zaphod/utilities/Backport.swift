//
//  File.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import Foundation
import SwiftUI

@available(macOS 10.15.0, iOS 13.0, *)
public struct Backport<Content> {
    public let content: Content

    public init(_ content: Content) {
        self.content = content
    }
}

@available(macOS 10.15.0, iOS 13.0, *)
extension View {
    var backport: Backport<Self> { Backport(self) }
}

@available(macOS 10.15.0, iOS 13.0, *)
extension Backport where Content: View {
    @ViewBuilder func keyboardShortcutDefault() -> some View {
        if #available(macOS 11, iOS 14, *) {
            content.keyboardShortcut(.defaultAction)
        } else {
            content
        }
    }

    @ViewBuilder
    func vibrantBackground() -> some View {
        if #available(macOS 12.0, iOS 15, *) {
            content.background(.thinMaterial)
        } else {
            content.background(Color.white.opacity(0.7))
        }
    }
}
