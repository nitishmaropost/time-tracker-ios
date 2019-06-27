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
    
    let HEADER_WITH_TOKEN: HTTPHeaders = [
        "Content-Type": "application/json; charset=utf-8",
        "x-access-token": "\(KeychainHelper.shared.getValueInKeychain(forKey: TimelyConstants.shared.token))"
    ]
    // http://35.200.185.188/
//    let kServerUrl = "http://173.168.100.191:8000/api/v1/"
    let kServerUrl = "http://35.200.185.188/api/v1/"
    let kLoginUrl = "auth/login"
    let kTimeLogHistoryUrl = "attendance/logs"
    let kAttendanceUrl = "attendance/shifts?start_date=1558204200000&end_date=1558722600000"
    
}
