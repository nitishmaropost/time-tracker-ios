//
//  ViewController.swift
//  Timely
//
//  Created by maropost on 22/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewPink: UIView!
    @IBOutlet weak var viewRed: UIView!
    @IBOutlet weak var viewRedBottom: UIView!
    @IBOutlet weak var viewPinkBottom: UIView!
    @IBOutlet weak var viewTextFields: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureUI()
    }

    func configureUI() {
        self.viewRed.layer.cornerRadius = self.viewRed.frame.size.width/2
        self.viewPink.layer.cornerRadius = self.viewPink.frame.size.width/2
        self.viewRedBottom.layer.cornerRadius = self.viewRedBottom.frame.size.width/2
        self.viewPinkBottom.layer.cornerRadius = self.viewPinkBottom.frame.size.width/2
        self.viewTextFields.layer.masksToBounds = false
        self.viewTextFields.layer.cornerRadius = 50
        self.viewTextFields.layer.shadowColor = UIColor.lightGray.cgColor
        self.viewTextFields.layer.shadowOpacity = 6
        self.viewTextFields.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.viewTextFields.layer.shadowRadius = 8
    }
}

