//
//  SwiftUIView.swift
//  
//
//  Created by Rob Jonson on 09/11/2021.
//

import SwiftUI

@available(macOS 10.15.0,iOS 13.0, *)
public struct SignupEmailView: View {
    var text:SignupText
    var close:()->Void
    
    public init(text:SignupText,close:@escaping ()->Void){

        self.close = close
        self.text = text
        
        self.text.doReplacements()
    }

    public var body: some View {
        VStack(spacing:20) {
            Text(text.emailHeading)
                .font(.headline)
                .foregroundColor(.primary)
            
            Text(text.body)
                .font(.body)
                .foregroundColor(.secondary)
            
            if let from = text.from {
                Text(from)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
            
            EnterEmailView(text:text,close:close)
            
            Button(text.noButton) {
                self.close()
            }
        }
        .padding()
        .background(Color.backgroundColor)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct SignupEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SignupEmailView(text:SignupText.newFeaturesOtherApps.from("-Rob"), close:{})
    }
}


@available(macOS 10.15.0,iOS 13.0, *)
struct EnterEmailView: View {
    var text:SignupText
    var close:()->Void
    
    @available(macOS 12.0,iOS 15.0, *)
    @FocusState private var focusEmail:Bool
    
    @State private var email:String = ""
    
    init(text:SignupText,close:@escaping ()->Void){

        self.text = text
        self.close = close
        
        if #available(macOS 12.0,iOS 15.0, *) {
            focusEmail = true
        }
    }
    
    var body: some View {
        VStackIfCompact {
            
            if #available(macOS 12.0,iOS 15.0, *) {
                TextField("Your Email", text: $email)
                    .disableAutocorrection(true)
                    .padding(10)
                    .cornerRadius(5)
                    .border(.selection)
                    .focused($focusEmail)
            }
            Button(text.yesButton){
                self.close()
            }
            .backport.keyboardShortcutDefault()
        }
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
struct VStackIfCompact<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
#if os(iOS)

    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var body: some View {
        if horizontalSizeClass == .compact {
            VStack {
                content
            }
        }
        else {
            HStack {
                content
            }
        }
    }
#elseif os(macOS)
    var body: some View {
        HStack {
            content
        }
    }
#endif
}


