//
//  TimelyUrls.swift
//  Timely
//
//  Created by maropost on 17/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import Alamofire

class TimelyUrls {
    static let shared = TimelyUrls()
    
    let HEADER : HTTPHeaders = [
        "Content-Type": "application/json; charset=utf-8"
    ]
    
    let kServerUrl = "http://173.168.100.191:8000/api/v1/"
    let kLoginUrl = "auth/login"
    
}
