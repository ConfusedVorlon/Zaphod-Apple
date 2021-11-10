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
    var requests:[Request] = [.email,.notification]
    @State var currentRequest:Request
    
    
    enum Request {
        case email
        case notification
    }
    
    
    public init(text:SignupText,close:@escaping ()->Void){
        self.text = text
        self.close = close
        guard let firstRequest = requests.first else {
            fatalError("You have to show at least one request")
        }
        self.currentRequest = firstRequest  
    }
    
    public var body: some View {
            VStack {
                Spacer()
                
                
                if currentRequest == .email {
                    SignupEmailView(text: text,close:{closePage()})
                            .padding()
                            .transition(.asymmetric(insertion: .move(edge:.trailing), removal: .scale))
                }
                
                if currentRequest == .notification {
                    SignupNotificationView(text: text,close:{closePage()})
                            .padding()
                            .transition(.asymmetric(insertion: .move(edge:.trailing), removal: .scale))
                }
                
                Spacer()
            }
            .backport.vibrantBackground()
    }
    
    func closePage() {
        if let currentIndex = requests.firstIndex(of: currentRequest),
           (currentIndex + 1) < requests.count {
            withAnimation {
                currentRequest = requests[currentIndex + 1]
            }
        }
        else {
            close()
        }
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close:{})
    }
}


