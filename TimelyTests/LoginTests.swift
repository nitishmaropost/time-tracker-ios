//
//  LoginTests.swift
//  TimelyTests
//
//  Created by maropost on 22/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import XCTest
@testable import Timely

class LoginTests: XCTestCase {

    var vc = AuthenticationVC()
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.vc = storyboard.instantiateViewController(withIdentifier: "AuthenticationVC") as! AuthenticationVC
        _ = self.vc.view
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testValidateUser() {
        vc.textFieldUsername.text = "a@b.com"
        vc.textFieldPassword.text = "aaaa"
        vc.viewModel.username = "a@b.com"
        vc.viewModel.password = "aaaa"
        let _ = self.vc.viewModel.checkValidations(view: self.vc.view)
    }
    
    func testNetworkConnectivity() {
        let _ = self.vc.viewModel.isConnectedToInternet(view: self.vc.view)
    }
}
