//
//  ShiftCell.swift
//  Timely
//
//  Created by maropost on 28/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ShiftCell: UITableViewCell {

    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelWorkTime: UILabel!
    @IBOutlet weak var labelPremisesTime: UILabel!
    @IBOutlet weak var constraint_height_labelWorkTime: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_labelPremisesTime: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelDate.text = nil
        self.labelWorkTime.text = nil
        self.labelPremisesTime.text = nil
        self.constraint_height_labelPremisesTime.constant = 40
        self.constraint_height_labelWorkTime.constant = 40
    }
}
