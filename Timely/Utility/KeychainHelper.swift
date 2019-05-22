//
//  KeychainHelper.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import SwiftKeychainWrapper


class KeychainHelper {
    static let shared = KeychainHelper()
    
    
    init() {
        
    }
    
    func setValueInKeychain(forKey key: String, value: String) {
        let _: Bool = KeychainWrapper.standard.set(value, forKey: key)
    }
    
    func getValueInKeychain(forKey key: String) -> String {
        return KeychainWrapper.standard.string(forKey: key) ?? ""
    }
}
