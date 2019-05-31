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
    
    func setGradientColor(topColor: UIColor, bottomColor: UIColor, cornerRadius: CGFloat, shadowRadius: CGFloat, shadowOffset: CGSize, shadowOpacity: CGFloat, shadowColor: UIColor, parentView: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = parentView.bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.locations = [0.0, 1.0]
       // gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        gradientLayer.shadowRadius = shadowRadius
        gradientLayer.shadowOffset = shadowOffset
        gradientLayer.shadowOpacity = Float(shadowOpacity)
        gradientLayer.shadowColor = shadowColor.cgColor
        
        parentView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
