//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/11/2021.
//

import Foundation
import UIKit

public class UIWhatsNewButton:UIView {
 
    weak var button:UIButton?
    private var info:ZaphodInfo
    @IBInspectable  var newColor:UIColor {
        didSet {
            updateButton()
        }
    }

    var action:(()->Void)?
    
    public init(info: ZaphodInfo = Zaphod.shared.ui,
                newColor: UIColor = UIColor.red,
                type: UIButton.ButtonType = .system,
                action:(()->Void)? = nil) {
        let aButton = UIButton.init(type: type)
        self.button = aButton
        self.info = info
        self.newColor = newColor
        self.action = action
        
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        let aButton = UIButton.init(type: .system)
        self.button = aButton
        self.info = Zaphod.shared.ui
        self.newColor = UIColor.red
        self.action = nil
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        setupButton()
    }
    
    private func setupButton() {
        guard let button = button else {
            return
        }
        
        self.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("What's New", for: .normal)

        button.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        button.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        updateButton()
    }
    
    private func updateButton() {
        button?.setImage(newImage, for: .normal)
    }
    
    var newImage:UIImage? {
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
