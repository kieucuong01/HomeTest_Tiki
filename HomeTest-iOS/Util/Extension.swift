//
//  ExtensionNSLayoutConstraint.swift
//  OwnersClub-ios
//
//  Created by Cuong Kieu on 6/21/18.
//  Copyright © 2018 Oceanize. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    @IBInspectable var constraintValue : CGFloat {
        set(value) {
            self.constant = value * AppUtil.displayScale
        }
        get {
            return self.constant
        }
    }
}

extension String {
    func width(font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: 70.0)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
