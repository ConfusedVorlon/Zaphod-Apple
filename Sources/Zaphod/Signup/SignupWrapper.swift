//
//  SwiftUIView.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import SwiftUI

@available(macOS 10.15.0,iOS 13.0, *)
public struct SignupWrapperView: View {
    var text:SignupText
    var close:()->Void
    
    public init(text:SignupText,close:@escaping ()->Void){
        self.text = text
        self.close = close
    }
    
    public var body: some View {
            VStack {
                Spacer()
                    SignupEmailView(text: text,close:close)
                        .padding()
                Spacer()
            }
            .backport.vibrantBackground()
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close:{})
    }
}


