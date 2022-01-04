//
//  SignupPreview.swift.swift
//  Example_SwiftUI
//
//  Created by Rob Jonson on 24/11/2021.
//

import SwiftUI
import Zaphod

@available(macOS 10.15.0, iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWrapperView(text: SignupText.newFeaturesOtherApps.from("-Rob"), show: .constant(true))
    }
}
