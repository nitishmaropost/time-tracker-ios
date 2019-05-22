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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.labelPinType.backgroundColor = UIColor.white
        self.labelTime.backgroundColor = UIColor.white
        self.contentView.backgroundColor = UIColor.white
        self.labelPinType.showAnimatedGradientSkeleton()
        self.labelTime.showAnimatedGradientSkeleton()
        self.labelHeader.showAnimatedGradientSkeleton()
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
