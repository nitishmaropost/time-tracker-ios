//
//  LoginVM.swift
//  Timely
//
//  Created by maropost on 20/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

class LoginVM: NSObject {
    
    var username: String?
    var password: String?
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    override init() {
        
    }
    
    /// Set error message and display on the view.
    ///
    /// - Parameters:
    ///   - message: Message content
    ///   - view: View on which message is to be displayed.
    func setErrorMessage(message: String, view: UIView) {
        UIView.hr_setToastThemeColor(color: UIColor(red: 246.0/255.0, green: 96.0/255.0, blue: 102.0/255.0, alpha: 1.0))
        view.makeToast(message: message, duration: 2.0, position: HRToastPositionDefault as AnyObject)
    }
    
    /// Empty email validation
    ///
    /// - Returns: Validation result - true/false
    func isEmailEmpty() -> Bool {
        if self.username == nil || self.username!.isEmpty {
            return true
        }
        
        return false
    }
    
    /// Empty password validation
    ///
    /// - Returns: Validation result - true/false
    func isPasswordEmpty() -> Bool {
        if self.password == nil || self.password!.isEmpty {
            return true
        }
        
        return false
    }
    
    /// Email valid format validation
    ///
    /// - Returns: Validation result - true/false
    func isEmailValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.username)
    }
    
    /// Check for client side validations.
    func checkValidations(view: UIView) -> Bool {
        var isValid = true
        if self.isEmailEmpty() && self.isPasswordEmpty() {
            isValid = false
            self.setErrorMessage(message: "Email and Password required", view: view)
        } else if self.isEmailEmpty() {
            isValid = false
            self.setErrorMessage(message: "Email required", view: view)
        } else if self.isPasswordEmpty() {
            isValid = false
            self.setErrorMessage(message: "Password required", view: view)
        }
        else if !self.isEmailValid() {
            isValid = false
            self.setErrorMessage(message: "Invalid email", view: view)
        }
        
        return isValid
    }
    
    /// Check if connected to internet
    ///
    /// - Parameter view: View object for setting the error message which needs to be displayed.
    /// - Returns: Boolen - true is connected, false if not connected.
    func isConnectedToInternet(view: UIView) -> Bool {
        if Connectivity.isConnectedToInternet {
            return true
        } else {
            self.setErrorMessage(message: "No internet connection", view: view)
            return false
        }
    }
    
    func callLoginService(completion: @escaping (LoginResult) -> ()) {
        LoginService.shared.login(requestDict: ["username": self.username ?? "saurabh.thukral@maropost.com", "password": self.password ?? "saurabh.thukral@maropost.com"]) { (result) in
            
            switch result {
            case .success(let user):
                return completion(.success(user))
            case .error(let error):
                return completion(.error(error))
            @unknown default:
                print("default")
            }
        }
    }
}
