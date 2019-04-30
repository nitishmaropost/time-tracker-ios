//
//  ColoredImageView.swift
//  Timely
//
//  Created by maropost on 29/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class ColoredImageView: UIImageView {
    @IBInspectable var alwaysTemplate: Bool = false {
        didSet {
            if alwaysTemplate {
                self.image = self.image?.withRenderingMode(.alwaysTemplate)
            } else {
                self.image = self.image?.withRenderingMode(.alwaysOriginal)
            }
            
        }
    }
}

//extension UIImageView {
//    func setImageRenderingMode(_ renderMode: UIImage.RenderingMode) {
//        assert(image != nil, "Image must be set before setting rendering mode")
//        // AlwaysOriginal as an example
//        image = image?.withRenderingMode(.alwaysOriginal)
//    }
//}
