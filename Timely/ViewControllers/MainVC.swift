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

        // Do any additional setup after loading the view.
        self.leftViewController = SideMenuVC()
        self.rightViewController = RightVC()
        self.leftViewPresentationStyle = .scaleFromBig
        self.rightViewPresentationStyle = .scaleFromBig
//        self.leftViewWidth = 3*UIScreen.main.bounds.size.width/5
//
        self.leftViewBackgroundColor = TimelyColors.shared.color_SideMenu
        self.leftViewCoverColor = TimelyColors.shared.color_SideMenu
       // self.rootViewCoverColorForLeftView = TimelyColors.shared.color_SideMenu
//
//        self.rightViewBackgroundColor = TimelyColors.shared.color_SideMenu
//        self.rightViewCoverColor = TimelyColors.shared.color_SideMenu
//        self.rootViewCoverColorForRightView = TimelyColors.shared.color_SideMenu
    }
}
