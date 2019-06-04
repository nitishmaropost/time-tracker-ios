//
//  AuthenticationVC.swift
//  Timely
//
//  Created by maropost on 23/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import FontAwesome_swift

class AuthenticationVC: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var viewModel: LoginVM!
    @IBOutlet weak var viewTextFields: RoundedView!
    @IBOutlet weak var textFieldUsername: BindingTextField! {
        didSet {
            textFieldUsername.bind { self.viewModel.username = $0 }
        }
    }
    @IBOutlet weak var textFieldPassword: BindingTextField! {
        didSet {
            textFieldPassword.bind { self.viewModel.password = $0 }
        }
    }
    
    // Constraints
    @IBOutlet weak var constraint_left_viewTopOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_top_viewTopOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_top_viewTopRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_left_viewTopRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_right_viewBottomOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_bottom_viewBottomOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_right_viewBottomRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_bottom_viewBottomRed: NSLayoutConstraint!
    
    @IBOutlet weak var constraint_height_viewTopOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_width_viewTopOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_viewTopRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_width_viewTopRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_viewBottomOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_width_viewBottomOrange: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_viewBottomRed: NSLayoutConstraint!
    @IBOutlet weak var constraint_width_viewBottomRed: NSLayoutConstraint!
    
    @IBOutlet weak var viewRedTop: RoundedView!
    @IBOutlet weak var viewOrangeTop: RoundedView!
    @IBOutlet weak var viewRedBottom: RoundedView!
    @IBOutlet weak var viewOrangeBottom: RoundedView!
    
    @IBOutlet weak var textFieldEmail: UITextField!
    @IBOutlet weak var buttonAction: RoundedButton!
    @IBOutlet weak var buttonLogin: RoundedButton!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var viewLineBottom: UIView!
    @IBOutlet weak var buttonForgotPassword: UIButton!
    @IBOutlet weak var buttonRegister: UIButton!
    @IBOutlet weak var activityIndiactor: UIActivityIndicatorView!
    
    @IBOutlet weak var constraint_height_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_bottom_Label: NSLayoutConstraint!
    @IBOutlet weak var constraint_leading_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_trailing_buttonAction: NSLayoutConstraint!
    @IBOutlet weak var constraint_center_viewTextFields: NSLayoutConstraint!
    @IBOutlet weak var constraint_center_buttonAction: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buttonForgotPassword.isHidden = false
        self.buttonRegister.isHidden = true
        self.buttonLogin.isHidden = true
        self.activityIndiactor.isHidden = true
        self.setupUI()
        
        
    }
    
    func setupUI() {
        self.labelTitle.text = "Login"
        // For test
        self.textFieldUsername.text = "saurabh.thukral@maropost.com"
        self.textFieldPassword.text = "saurabh.thukral@maropost.com"
        self.viewModel.username = "saurabh.thukral@maropost.com"
        self.viewModel.password = "saurabh.thukral@maropost.com"
        
        self.textFieldUsername.setRightPaddingPoints(40)
        self.textFieldPassword.setRightPaddingPoints(40)
        
//        self.textFieldEmail.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height))
//        textField.rightViewMode = .always
        
        self.buttonForgotPassword.isHidden = false
        self.constraint_center_viewTextFields.constant = -30
        self.constraint_center_buttonAction.constant = -30
        self.constraint_height_viewTextFields.constant = 120
        self.textFieldEmail.isHidden = true
        self.viewLineBottom.isHidden = true
        self.viewTextFields.layoutIfNeeded()
        self.view.layoutIfNeeded()
        
        // Small screen devices
        if UIScreen.main.bounds.size.height <= 568 {
            self.constraint_height_viewTopRed.constant = 150
            self.constraint_width_viewTopRed.constant = 150
            self.constraint_height_viewTopOrange.constant = 150
            self.constraint_width_viewTopOrange.constant = 150
            
            self.constraint_height_viewBottomRed.constant = 150
            self.constraint_width_viewBottomRed.constant = 150
            self.constraint_height_viewBottomOrange.constant = 150
            self.constraint_width_viewBottomOrange.constant = 150
            
            self.constraint_top_viewTopOrange.constant = self.constraint_top_viewTopOrange.constant - 20
            
            self.viewRedTop.cornerRadius = 75
            self.viewOrangeTop.cornerRadius = 75
            self.viewRedBottom.cornerRadius = 75
            self.viewOrangeBottom.cornerRadius = 75
        }
    }
    
    @IBAction func buttonActionTapped(_ sender: RoundedButton) {
        self.textFieldUsername.resignFirstResponder()
        self.textFieldPassword.resignFirstResponder()
        if self.viewModel.checkValidations(view: self.view) && self.viewModel.isConnectedToInternet(view: self.view) {
            self.activityIndiactor.isHidden = false
            self.buttonAction.setTitle("", for: .normal)
            self.activityIndiactor.startAnimating()
            self.viewModel.callLoginService { (result) in
                self.activityIndiactor.stopAnimating()
                self.activityIndiactor.isHidden = true
                switch result {
                case .success(_):
                    let group = DispatchGroup()
                    group.enter()
                    DispatchQueue.main.async {
                        self.buttonAction.backgroundColor = UIColor(red: 44.0/255.0, green: 197.0/255.0, blue: 94.0/255.0, alpha: 1.0)
                        self.buttonAction.setTitle(String.fontAwesomeIcon(name: .check), for: .normal)
                        group.leave()
                    }
                    
                    group.notify(queue: .main) {
                        DispatchQueue.main.async {
                            let delaySeconds = 1.0
                            DispatchQueue.main.asyncAfter(deadline: .now() + delaySeconds) {
                                self.performSegue(withIdentifier: TimelyConstants.shared.segue_auth_to_home, sender: nil)
                            }
                        }
                    }
                    
                case .error(let error):
                    self.buttonAction.setTitle(String.fontAwesomeIcon(name: .arrowRight), for: .normal)
                    self.viewModel.setErrorMessage(message: error, view: self.view)
                default:
                    print("default")
                }
                
            }
        }
    }
    
    @IBAction func buttonSwitchModeTapped(_ sender: RoundedButton) {
        if sender.tag == 1 {
            self.buttonLogin.isHidden = true
            self.buttonRegister.isHidden = false
            self.animateViewOnSwitch(tag: 1)
        } else {
            self.buttonLogin.isHidden = false
            self.buttonRegister.isHidden = true
            self.animateViewOnSwitch(tag: 2)
        }
    }
    
    func animateViewOnSwitch(tag: Int) {
        if tag == 1 {
            // Show login
            UIView.animate(withDuration: 0) {
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
