//
//  TimelyColorsUtility.swift
//  Timely
//
//  Created by maropost on 23/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

class TimelyColorsUtility {
    static let shared = TimelyColorsUtility()
    
    func changeTint(forImage imageView: UIImageView, color: UIColor) {
        imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = color
    }
}
