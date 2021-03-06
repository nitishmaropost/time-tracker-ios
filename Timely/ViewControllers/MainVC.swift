//
//  MainVC.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit


class MainVC: LGSideMenuController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.leftViewController = SideMenuVC()
        self.rightViewController = RightVC()
        self.leftViewPresentationStyle = .scaleFromBig
        self.rightViewPresentationStyle = .scaleFromBig

        self.leftViewBackgroundColor = UIColor.white
        self.leftViewCoverColor = UIColor.white
        self.rightViewLayerBorderColor = TimelyColors.shared.kColorSideMenu
        self.rightViewLayerShadowColor = TimelyColors.shared.kColorSideMenu
        self.rightViewLayerShadowRadius = 2
    }
}
