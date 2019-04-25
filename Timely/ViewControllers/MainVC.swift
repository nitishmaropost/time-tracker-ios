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

        self.leftViewBackgroundColor = TimelyColors.shared.kColorSideMenu
        self.leftViewCoverColor = TimelyColors.shared.kColorSideMenu
    }
}
