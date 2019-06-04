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
        self.layer.masksToBounds = false
        self.layer.cornerRadius = 5
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 4
        self.layer.shadowColor = UIColor.lightGray.cgColor
        
        self.labelHeader.backgroundColor = UIColor.white
        
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
        self.labelPinType.textColor = UIColor.black
        self.constrint_height_header.constant = 50
        
    }
}
