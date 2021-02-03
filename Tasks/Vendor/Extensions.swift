//
//  Extensions.swift
//  khomasy
//
//  Created by Ali Amin on 3/31/18.
//  Copyright © 2018 Khomasy. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(cornerRadius: CGFloat? = nil,
                   shadowRadius: CGFloat = 1,
                   shadowColor: UIColor = UIColor.black,
                   opacity: Float = 0.4,
                   offset: CGSize = CGSize(width: 0.0, height: 0.5))
    {
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        } else {
            layer.cornerRadius = bounds.size.height / 2
        }
        layer.shadowRadius = shadowRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
    }
}


extension UITextField {
    func addMarginViewWidth(_ width: CGFloat) {
        let leftMarginView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                  size: CGSize(width: width,
                                                               height: bounds.size.height)))
        leftView = leftMarginView
        let rightMarginView = UIView(frame: CGRect(origin: CGPoint(x: 0, y: 0),
                                                   size: CGSize(width: width,
                                                                height: bounds.size.height)))
        rightView = rightMarginView
        leftViewMode = .always
        rightViewMode = .always
    }
}
