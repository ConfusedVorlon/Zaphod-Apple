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
    
    var body: some View {
        VStack(spacing:20) {
            Text("Zaphod SwiftUI Demo")
            
            WhatsNewButton(){
                openURL(Zaphod.shared.whatsNewURL)
            }
            
            Button(action: {
                Zaphod.shared.debugReset()
            }) {
                VStack {
                    Text("Reset Settings")
                    Text("Clears stored state and re-queries the server")
                        .font(.footnote)
                }
            }
        }
        .padding()
        

    }
}

struct ContentView_Previews: PreviewProvider {  
    static var previews: some View {
        ContentView()
    }
}
