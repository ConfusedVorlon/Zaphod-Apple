//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/11/2021.
//

import Foundation


#if !os(watchOS) && !os(tvOS) && canImport(UIKit)

import UIKit

public class UIWhatsNewButton:UIButton {
 
    private var info:ZaphodInfo = Zaphod.shared.ui
    @IBInspectable  var newColor:UIColor = .red {
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
        setTitle("What's New", for: .normal)
        update()
        
        changeToken = NotificationCenter.default.addObserver(forName: ZaphodInfo.Notif.changed, object: nil, queue: .main) { [weak self] _ in
            self?.update()
        }
        
        self.addTarget(self, action: #selector(defaultAction), for: .touchUpInside)
    }
    
    open func update() {
            if self.info.hasUnreadNews {
                self.setImage(self.newImage, for: .normal)
            }
            else {
                //should just be able to set nil here - but it doesn't work
                //iOS keeps the old image in play (iOS 15)
                self.setImage(self.empty, for: .normal)
            }
    }
    
    @objc
    /// if there are no other targets set - then the button will attempt to open the what's new page in safari
    /// presenting over the current viewController
    open func defaultAction() {
        //just us!
        guard allTargets.count == 1 else {
            return
        }
        let url = Zaphod.shared.whatsNewURL
        
        if let vc = self.firstViewController {
            vc.openSafari(url: url)
        }
        else {
            UIApplication.shared.open(url)
        }
    }
    
    /// Dummy empty image to allow setting image to 'nil'
    private var empty:UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: 1, height: 1))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return image?.withRenderingMode(.alwaysOriginal)
    }
     
    
    /// The image shown when there is new news available
    open var newImage:UIImage? {
        let rect = CGRect(origin: .zero, size: CGSize(width: 14, height: 14))
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setShadow(offset: .zero, blur: 5)
            context.setFillColor(newColor.cgColor)
            context.fillEllipse(in: CGRect(x: 4, y: 4, width: 6, height: 6))
        }
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    
        return image?.withRenderingMode(.alwaysOriginal)
    }

}

#endif
