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
