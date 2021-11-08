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
        VStack {
            Text("Zaphod mini Demo")
                .padding()
            
            WhatsNewButton(){
                openURL(Zaphod.shared.whatsNewURL)
            }
            
            Button(action: {
                Zaphod.shared.debugReset()
            }) {
                Text("Reset Zaphod Settings")
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
