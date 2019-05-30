//
//  TimeLogDetails.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import ObjectMapper

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
