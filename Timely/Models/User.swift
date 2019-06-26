//
//  UserInfo.swift
//  Timely
//
//  Created by maropost on 17/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {

    // Variables
    var userInfo: UserInfo?
    var token: String?

    required init?(map: Map) {

    }
    
    init() {
        
    }

     func mapping(map: Map) {
        self.userInfo <- map["user_info"]
        self.token <- map["token"]
    }
}

class UserInfo: Mappable {

    // Variables
    var fullName: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var employeeCode: Int?
    var userRole: String?

    required init?(map: Map) {

    }

    func mapping(map: Map) {
        self.fullName <- map["full_name"]
        self.firstName <- map["first_name"]
        self.lastName <- map["last_name"]
        self.email <- map["email_id"]
        self.employeeCode <- map["emp_code"]
        self.userRole <- map["user_role"]
    }
}

