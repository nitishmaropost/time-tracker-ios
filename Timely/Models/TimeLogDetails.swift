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

//class TimeLogDetails: Mappable {
//
//    var length: Int?
//    var rows: [TimeLog]?
//    var pinTypeText: PinTypeText?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//        self.length <- map["length"]
//        self.rows <- map["rows"]
//        self.pinTypeText <- map["pin_type_text"]
//    }
//}
//
//class TimeLog : Mappable {
//
//    var id: String?
//    var employeeCode: Int?
//    var logId: Int?
//    var punchTime: String?
//    var pinType: Int?
//    var status: Int?
//    var __v: Int?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//        self.id <- map["_id"]
//        self.employeeCode <- map["emp_code"]
//        self.logId <- map["log_id"]
//        self.punchTime <- map["punch_time_str"]
//        self.pinType <- map["pin_type"]
//        self.status <- map["status"]
//        self.__v <- map["__v"]
//    }
//}
//
//class PinTypeText : Mappable {
//
//    var inFingerprint: String?
//    var inCard: String?
//    var outFingerprint: String?
//    var outCard: String?
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//        self.inFingerprint <- map["1"]
//        self.inCard <- map["4"]
//        self.outFingerprint <- map["101"]
//        self.outCard <- map["104"]
//    }
//
//
//}



class TimeLogDetails : Decodable {
    var rows: [TimeLog]?
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        rows = try values.decodeIfPresent([TimeLog].self, forKey: .rows)
        let pinTypeText = try values.decodeIfPresent([String:String].self, forKey: .pin_type_text)
        rows?.forEach({ (row) in
            if let pinId = row.pinId {
                row.pinType = pinTypeText?[String(pinId)]
            }
        })
    }
    
    enum CodingKeys: String, CodingKey {
        case rows
        case pin_type_text
    }
}

class TimeLog : Decodable {
    var id: String?
    var empCode: Int?
    var logId: Int
    var punchTime: String?
    var pinType: String?
    var pinId: Int?
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        empCode = try container.decode(Int.self, forKey: .empCode)
        logId = try container.decode(Int.self, forKey: .logId)
        punchTime = try container.decode(String.self, forKey: .punchTime)
        pinId = try container.decode(Int.self, forKey: .pinId)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case empCode = "emp_code"
        case logId = "log_id"
        case punchTime = "punch_time_str"
        case pinId = "pin_type"
    }
}
