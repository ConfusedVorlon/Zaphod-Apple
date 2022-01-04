//
//  File.swift
//  
//
//  Created by Rob Jonson on 10/11/2021.
//

import Foundation
import SwiftUI

@available(macOS 10.15.0, iOS 13.0, *)
struct CenteredIfCompact<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

#if os(iOS)

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            HStack(alignment:.center) {
                content
            }
            .frame(maxWidth:.infinity)
        } else {
            content
        }
    }
#elseif os(macOS)
    var body: some View {
        HStack(alignment:.center) {
            content
        }
        .frame(maxWidth:.infinity)
    }
#endif
}
