//
//  ContentView.swift
//  Shared
//
//  Created by Rob Jonson on 05/11/2021.
//

import SwiftUI
import Zaphod

struct ContentView: View {
    @Environment(\.openURL) var openURL
    
    @State var showSignup: Bool = false
    
    var body: some View {
        VStack(spacing:20) {
            Text("Zaphod SwiftUI Demo")
                .font(.headline)
            
            WhatsNewButton(){ url in
                openURL(url)
            }
            
            Button("Show Signup") {
                withAnimation {
                    self.showSignup = true
                }
            }
            
            Button("Show FAQs") {
                openURL(Zaphod.shared.faqURL)
            }
            
            VStack(spacing:5) {
                Button("Reset Settings"){
                    Zaphod.shared.debugReset()
                }
                Text("Clears stored state and re-queries the server")
                    .font(.footnote)
            }
            .padding(.bottom)
            
            Spacer()
            

        }
        .padding()
        .frame(maxWidth:.infinity)
        .overlay(
            SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"),
                              show:$showSignup)
                
            )
    }
}

struct ContentView_Previews: PreviewProvider {  
    static var previews: some View {
//        ContentView()
        SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), show:.constant(true))
    }
}
