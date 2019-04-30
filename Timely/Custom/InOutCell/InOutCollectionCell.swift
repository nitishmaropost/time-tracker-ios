//
//  InOutCollectionCell.swift
//  Timely
//
//  Created by maropost on 30/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class InOutCollectionCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 4
        self.layer.shadowRadius = 8
        self.layer.shadowOffset = CGSize(width: 2, height: 2)
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.cornerRadius = 8
    }

}
