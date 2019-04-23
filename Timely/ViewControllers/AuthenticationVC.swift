//
//  AuthenticationVC.swift
//  Timely
//
//  Created by maropost on 23/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class AuthenticationVC: UIViewController {
    
    @IBOutlet weak var viewTextFields: RoundedView!
    @IBOutlet weak var textFieldUsername: UITextField!
    @IBOutlet weak var textFieldPassword: UITextField!
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonAction: RoundedButton!
    @IBOutlet weak var buttonLogin: RoundedButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewLineBottom: UIView!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    
    
    @IBOutlet weak var constraint_height_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_bottom_Label: NSLayoutConstraint!
    @IBOutlet weak var constraint_leading_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_trailing_buttonAction: NSLayoutConstraint!
    @IBOutlet weak var constraint_center_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_center_buttonAction: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonForgotPassword.isHidden = true
        self.buttonLogin.isHidden = true
    }
    
    @IBAction func buttonActionTapped(_ sender: RoundedButton) {
        
    }
    
    @IBAction func buttonSwitchModeTapped(_ sender: RoundedButton) {
        if sender.tag == 1 {
            self.buttonLogin.isHidden = false
            self.buttonRegister.isHidden = true
            self.animateViewOnSwitch(tag: 1)
        } else {
            self.buttonLogin.isHidden = true
            self.buttonRegister.isHidden = false
            self.animateViewOnSwitch(tag: 2)
        }
    }
    
    func animateViewOnSwitch(tag: Int) {
        if tag == 1 {
//            // Show login
            
//            self.view.layoutIfNeeded()
//            self.view.layoutSubviews()
            
            UIView.animate(withDuration: 0) {
               // self.buttonSwitchMode.setTitle("Register", for: .normal)
                self.labelTitle.text = "Login"
                self.buttonForgotPassword.isHidden = false
                self.constraint_center_viewTextFields.constant = -30
                self.constraint_center_buttonAction.constant = -30
                self.constraint_height_viewTextFields.constant = 120
                self.textFieldEmail.isHidden = true
                self.viewLineBottom.isHidden = true
                self.viewTextFields.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
            
        } else {
            // Show register
            
            UIView.animate(withDuration: 0) {
                //self.buttonSwitchMode.setTitle("Login", for: .normal)
                self.labelTitle.text = "Register"
                self.buttonForgotPassword.isHidden = true
                self.constraint_center_viewTextFields.constant = 0
                self.constraint_center_buttonAction.constant = 0
                self.constraint_height_viewTextFields.constant = 180
                self.textFieldEmail.isHidden = false
                self.viewLineBottom.isHidden = false
                self.viewTextFields.layoutIfNeeded()
                self.view.layoutIfNeeded()
            }
        }
    }
}
