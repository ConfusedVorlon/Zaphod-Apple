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
    
    @State var showSignup: Double = 0
    
    var body: some View {
        VStack(spacing:20) {
            Text("Zaphod SwiftUI Demo")
                .font(.headline)
            
            WhatsNewButton(){
                openURL(Zaphod.shared.whatsNewURL)
            }
            
            Button("Show Signup") {
                withAnimation {
                    self.showSignup = 1
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
            SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close: {
                withAnimation {
                    self.showSignup = 0
                }
            })
                .opacity(showSignup)
            )
    }
}

struct ContentView_Previews: PreviewProvider {  
    static var previews: some View {
//        ContentView()
        SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close: {})
    }
}
