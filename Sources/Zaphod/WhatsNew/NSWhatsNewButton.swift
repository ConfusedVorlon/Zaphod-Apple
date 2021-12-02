//
//  NSWhatsNewButton.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 01/12/2021.
//


import Foundation


#if !os(watchOS) && !os(tvOS) && canImport(AppKit)


import AppKit
import Zaphod

public class NSWhatsNewButton:NSButton {
 
    private var info:ZaphodInfo = Zaphod.shared.ui
    @IBInspectable  var newColor:NSColor = .red {
        didSet {
            update()
        }
    }
 
    /**
     An initializer that initializes the object with a NSCoder object.
     - Parameter aDecoder: A NSCoder instance.
     */
    public required init?(coder aDecoder: NSCoder) {
      super.init(coder: aDecoder)
      prepare()
    }
    
    /**
     An initializer that initializes the object with a CGRect object.
     If AutoLayout is used, it is better to initilize the instance
     using the init() initializer.
     - Parameter frame: A CGRect instance.
     */
    public override init(frame: CGRect) {
      super.init(frame: frame)
      /// Set these here to avoid overriding storyboard values
      prepare()
    }
    
    deinit {
        if let changeToken = changeToken {
            NotificationCenter.default.removeObserver(changeToken)
        }
    }

    var changeToken: NSObjectProtocol?
    private func prepare() {
        title = "What's New"
        update()
        
        changeToken = NotificationCenter.default.addObserver(forName: ZaphodInfo.Notif.changed, object: nil, queue: .main) { [weak self] _ in
            self?.update()
        }
        
        self.target = self
        self.action = #selector(defaultAction)
    }
    
    open func update() {
            if self.info.hasUnreadNews {
                self.image = self.newImage
            }
            else {
                self.image = nil
            }
    }
    
    @objc
    /// by default, the button will mark news as seen and open the 'what's new' url
    /// you can override this by setting up your own target/action
    open func defaultAction() {
        Zaphod.shared.markNewsAsSeen()
        
        let url = Zaphod.shared.whatsNewURL
        NSWorkspace.shared.open(url)
    }

    /// The image shown when there is new news available
    open var newImage:NSImage {
        let image = NSImage()
        image.size =  CGSize(width: 14, height: 14)
        image.lockFocus()
        
        if let context = NSGraphicsContext.current?.cgContext {
            context.setShadow(offset: .zero, blur: 5)
            context.setFillColor(newColor.cgColor)
            context.fillEllipse(in: CGRect(x: 4, y: 4, width: 6, height: 6))
        }
        
        image.unlockFocus()
    
        return image
    }

}


#endif
