//
//  File.swift
//  
//
//  Created by Rob Jonson on 08/11/2021.
//

#if !os(watchOS) && !os(tvOS) && canImport(UIKit)

import Foundation
import UIKit

extension UIView {

    var firstViewController: UIViewController? {

        var responder: UIResponder? = self

        while responder != nil {

            if let responder = responder as? UIViewController {
                return responder
            }
            responder = responder?.next
        }
        return nil
    }
}

#endif
