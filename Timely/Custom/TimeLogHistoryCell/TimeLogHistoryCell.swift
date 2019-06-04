//
//  TimeLogHistoryCell.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import SkeletonView

class TimeLogHistoryCell: UITableViewCell {
    
    @IBOutlet weak var labelHeader: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelPinType: UILabel!
    @IBOutlet weak var constrint_height_header: NSLayoutConstraint!
    
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.red.cgColor,
            UIColor.green.cgColor
        ]
        return layer
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelPinType.showAnimatedGradientSkeleton()
        self.labelTime.showAnimatedGradientSkeleton()
        self.labelHeader.showAnimatedGradientSkeleton()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func hideSkeleton() {
        self.labelTime.hideSkeleton()
        self.labelPinType.hideSkeleton()
        self.labelHeader.hideSkeleton()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelHeader.text = nil
        self.labelTime.text = nil
        self.labelPinType.text = nil
        self.constrint_height_header.constant = 50
        
    }
}
