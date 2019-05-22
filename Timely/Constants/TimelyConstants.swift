//
//  TimelyConstants.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

class TimelyConstants {
    static let shared = TimelyConstants()
    
    // Seagues
    let segue_auth_to_home = "auth_to_home"
    let segue_splash_to_login = "splash_to_login"
    let segue_home_to_history = "home_to_history"
    
    // Keychain keys
    let token = "token"
    
    // Pin types
    let pinTypes: [String: String] = ["1": "In Fingerprint",
                                      "4": "In Card",
                                      "101": "Out Fingerprint",
                                      "104": "Out Card"]
}
