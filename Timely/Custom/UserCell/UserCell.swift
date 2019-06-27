//
//  UserCell.swift
//  Timely
//
//  Created by maropost on 27/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    // IBOutlets
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelPosition: UILabel!
    @IBOutlet weak var labelDepartment: UILabel!
    @IBOutlet weak var labelCode: UILabel!
    @IBOutlet weak var labelEmail: UILabel!
    @IBOutlet weak var constraint_height_labelPosition: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_labelDepartment: NSLayoutConstraint!
    @IBOutlet weak var constraint_top_labelPosition: NSLayoutConstraint!
    @IBOutlet weak var constraint_top_labelDepartment: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.labelName.showAnimatedGradientSkeleton()
        self.labelCode.showAnimatedGradientSkeleton()
        self.labelDepartment.showAnimatedGradientSkeleton()
        self.labelPosition.showAnimatedGradientSkeleton()
        self.labelEmail.showAnimatedGradientSkeleton()
    }
    
    func hideSkeleton() {
        self.labelName.hideSkeleton()
        self.labelCode.hideSkeleton()
        self.labelDepartment.hideSkeleton()
        self.labelPosition.hideSkeleton()
        self.labelEmail.hideSkeleton()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.labelName.text = nil
        self.labelPosition.text = nil
        self.labelDepartment.text = nil
        self.labelCode.text = nil
        self.labelEmail.text = nil
        self.constraint_top_labelPosition.constant = 10
        self.constraint_top_labelDepartment.constant = 10
        self.constraint_height_labelPosition.constant = 20
        self.constraint_height_labelDepartment.constant = 20
    }
}
