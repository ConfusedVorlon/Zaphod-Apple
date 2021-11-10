//
//  File.swift
//  
//
//  Created by Rob Jonson on 10/11/2021.
//

import Foundation
import SwiftUI

@available(macOS 10.15.0,iOS 13.0, *)
struct VStackIfCompact<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
#if os(iOS)

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                content
            }
        }
        else {
            HStack {
                content
            }
        }
    }
#elseif os(macOS)
    var body: some View {
        HStack {
            content
        }
    }
#endif
}
