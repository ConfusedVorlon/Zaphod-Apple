//
//  SwiftUIView.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import SwiftUI

@available(macOS 10.15.0,iOS 13.0, *)
public struct SignupNotificationView: View {
    var text:SignupText
    var close:()->Void
    
    public init(text:SignupText,close:@escaping ()->Void){

        self.close = close
        self.text = text
        
        self.text.doReplacements()
    }

    public var body: some View {
        VStack(spacing:20) {
            Text(text.notificationHeading)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(text.notificationBody)
                .font(.body)
                .foregroundColor(.secondary)
                .frame(maxWidth:.infinity)
                .multilineTextAlignment(.leading)

            Button(text.notificationYesButton) {
                Zaphod.shared.requestNotificationPermission {
                    self.close()
                }
            }
            .backport.keyboardShortcutDefault()
            
            Button(text.notificationNoButton) {
                self.close()
            }
            .font(.subheadline)
        }
        .padding()
        .padding(.vertical)
        .background(
            LinearGradient(gradient: Gradient(colors: text.backgroundColors), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct SignupNotificationView_Previews: PreviewProvider {
    static var previews: some View {
        SignupNotificationView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close:{})
    }
}

