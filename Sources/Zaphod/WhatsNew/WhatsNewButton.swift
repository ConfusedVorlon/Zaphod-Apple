//
//  SwiftUIView.swift
//  
//
//  Created by Rob Jonson on 06/11/2021.
//

import SwiftUI


@available(macOS 10.15.0,iOS 13.0, *)
public struct WhatsNewButton<Label>: View where Label : View {
    @ObservedObject private var info:ZaphodInfo
    public var newColor:Color
    var action:((URL)->Void)?
    var label:Label?
    
    public init(info:ZaphodInfo = Zaphod.shared.ui,
                newColor:Color = .red,
                action:((URL)->Void)?,
                @ViewBuilder label: () -> Label) {
        self.info = info
        self.newColor = newColor
        self.action = action
        self.label = label()
    }
    
    
    private var hasUnread:Bool {
        return info.hasUnreadNews
    }
        
    public var body: some View {
        Button(action: {
            self.clicked()
        }) {
            HStack(spacing:hasUnread ? 5 : 0) {
                Circle()
                    .foregroundColor(newColor)
                    .frame(width:hasUnread ? 6 : 0,height:6)
                    .shadow(color: .red, radius: hasUnread ? 3 : 0, x: 0, y: 0)
                    .frame(width: hasUnread ? nil : 0)
                             
                label
            }
            .animation(.easeIn(duration: 0.5), value: hasUnread)
            
        }
    }
    
    private func clicked() {
        if let action = action {
            action(Zaphod.shared.whatsNewURL)
        }
        else {
            print("Please assign an action to the What's new button")
        }
    }
}

@available(macOS 10.15.0,iOS 13.0, *)
extension WhatsNewButton where Label == Text {
    public init(info:ZaphodInfo = Zaphod.shared.ui,
                newColor:Color = .red,
                title:LocalizedStringKey = "What's New",
                action:((URL)->Void)?) {
        self.info = info
        self.newColor = newColor
        self.action = action
        self.label = Text(title)
    }
}


@available(macOS 10.15.0,iOS 13.0, *)
struct WhatsNewButton_Previews: PreviewProvider {
    static var previews: some View {
        WhatsNewButton(action:{_ in}) {
            Text("What exactly is new?")
        }
        
        WhatsNewButton(){_ in}
        
        WhatsNewButton(title:"Shortcut"){_ in}
    }
}
