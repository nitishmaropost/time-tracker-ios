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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
