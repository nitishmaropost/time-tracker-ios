//
//  SwitchTheme.swift
//  Timely
//
//  Created by Marorpost India on 12/09/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable

class SwitchTheme: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
