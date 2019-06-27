//
//  AttendanceService.swift
//  Timely
//
//  Created by maropost on 27/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class AttendanceService: NSObject {
    
    static let shared = AttendanceService()
    
    func getAttendanceDetails(completion: @escaping (TimelyAPIResult) -> ()) {
        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kAttendanceUrl)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER_WITH_TOKEN).responseJSON { (response) in
            print("\(response.response?.statusCode)")
            if response.response?.statusCode == 200 {
                let attendance = Mapper<Attendance>().map(JSON: response.value as! [String : Any])
                return completion(.success(attendance!))
            }
            else if response.response?.statusCode == 422 {
                return completion(.error("Error while getting attendance"))
            } else if response.response == nil {
                return completion(.error("Request timeout"))
            }
        }
    }
}
