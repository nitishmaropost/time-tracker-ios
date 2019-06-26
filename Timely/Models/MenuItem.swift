//
//  MenuItem.swift
//  Timely
//
//  Created by maropost on 26/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

class MenuItem : NSObject{
    var title: String?
    var image: UIImage?
    
    init(title: String, image: UIImage) {
        super.init()
        self.title = title
        self.image = image
    }
}
