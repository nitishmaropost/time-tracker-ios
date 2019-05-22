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
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelHeader.text = nil
        self.labelTime.text = nil
        self.labelPinType.text = nil
        self.constrint_height_header.constant = 50
        
    }
}
