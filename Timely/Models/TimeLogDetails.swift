//
//  TimeLogDetails.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import ObjectMapper
import SwiftDate

class TimeLogDetails: Mappable {
    
    var length: Int?
    var rows: [TimeLog]?
    var pinTypeText: PinTypeText?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.length <- map["length"]
        self.rows <- map["rows"]
        self.pinTypeText <- map["pin_type_text"]
    }
}

class TimeLog : Mappable {
    
    var id: String?
    var employeeCode: Int?
    var logId: Int?
    var punchTime: String?
    var pinType: Int?
    var status: Int?
    var __v: Int?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.id <- map["_id"]
        self.employeeCode <- map["emp_code"]
        self.logId <- map["log_id"]
        self.punchTime <- map["punch_time_str"]
        self.pinType <- map["pin_type"]
        self.status <- map["status"]
        self.__v <- map["__v"]
    }
}

class PinTypeText : Mappable {
    
    var inFingerprint: String?
    var inCard: String?
    var outFingerprint: String?
    var outCard: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        self.inFingerprint <- map["1"]
        self.inCard <- map["4"]
        self.outFingerprint <- map["101"]
        self.outCard <- map["104"]
    }
    
    
}
