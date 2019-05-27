//
//  NavigationDropdownMenu.swift
//  Timely
//
//  Created by maropost on 27/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class NavigationDropdownMenu: UIView {

    var buttons: [UIButton]!
    var buttonBackgroundColors: [UIColor]!
    var buttonTitledColors: [UIColor]!

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.buttons = [UIButton]()
        self.buttonBackgroundColors = [UIColor]()
        self.buttonTitledColors = [UIColor]()
    }
    
    func setItems(withTitles titles: [String], andBackgroundColors bgColors: [UIColor], andTitleColors titleColors: [UIColor]) {
        var xAxis = 20
        for title in titles {
            let button = UIButton(type: .roundedRect)
            button.frame = CGRect(x: xAxis, y: 20, width: Int(self.frame.size.width/(titles.count + (20 * (titles.count + 1)))), height: 40)
            
            button.setTitle(title, for: .normal)
        }
    }
}
