//
//  Attendance.swift
//  Timely
//
//  Created by maropost on 27/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import ObjectMapper

class Attendance: Mappable {
    
    var length: Int?
    var rows:[RowsShift]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.length <- map["length"]
        self.rows <- map["rows"]
    }
    
}

class RowsShift: Mappable {
    
    var userData: UserData!
    var workTime: Int?
    var onPremisesTime: Int?
    var presents: Int?
    var absents: Int?
    var holidays: Int?
    var shifts: [Shift]?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.userData <- map["user_data"]
        self.workTime <- map["work_time"]
        self.onPremisesTime <- map["on_premises_time"]
        self.presents <- map["presents"]
        self.absents <- map["absents"]
        self.absents <- map["absents"]
        self.absents <- map["absents"]
        self.absents <- map["absents"]
        self.shifts <- map["shifts"]
    }
}

class UserData: Mappable {
    
    var employeeCode: Int?
    var fullName: String?
    var email: String?
    var department: String?
    var position: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.employeeCode <- map["emp_code"]
        self.fullName <- map["full_name"]
        self.email <- map["email_id"]
        self.department <- map["department"]
        self.position <- map["position"]
    }
}

class Shift: Mappable {
    
    var empCode: Int?
    var dateString: String?
    var workTime: Int?
    var onPremisesTime: Int?
    var inTime: CLong?
    var outTime: CLong?
    var overTime: CLong?
    var status: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.empCode <- map["emp_code"]
        self.dateString <- map["dated_str"]
        self.workTime <- map["work_time"]
        self.onPremisesTime <- map["on_premises_time"]
        self.inTime <- map["in_time"]
        self.outTime <- map["out_time"]
        self.overTime <- map["over_time"]
        self.status <- map["status"]
    }
}
