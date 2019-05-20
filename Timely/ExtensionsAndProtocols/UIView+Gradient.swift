//
//  UIView+Gradient.swift
//  Maropost MSC
//
//  Created by Nitish on 15/05/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import Foundation
import UIKit

/// UIView extension
extension UIView {
    
    /// Apply gradient color layer
    ///
    /// - Parameters:
    ///   - topColor: Gradient top color
    ///   - bottomColor: Gradient bottom color
    func setGradientColor(topColor: UIColor, bottomColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
