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
    var requests:[Request] = [.email,.notification]
    @State var currentRequest:Request
    @Binding var show:Bool
    
    enum Request {
        case email
        case notification
    }
    
    public init(text:SignupText,show:Binding<Bool>){
        self.text = text
        self._show = show
        guard let firstRequest = requests.first else {
            fatalError("You have to show at least one request")
        }
        self.currentRequest = firstRequest  
    }
    
    public var body: some View {
        if show {
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
            .transition(.move(edge:.bottom))
        }
        else {
            EmptyView()
        }

    }
    
    func closePage() {
        withAnimation {
            if let currentIndex = requests.firstIndex(of: currentRequest),
               (currentIndex + 1) < requests.count {
                currentRequest = requests[currentIndex + 1]
            }
            else {
                show = false
            }
        }
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SignupWrapperView(text:SignupText.newFeaturesOtherApps.from("-Rob"), show:.constant(true))
    }
}


