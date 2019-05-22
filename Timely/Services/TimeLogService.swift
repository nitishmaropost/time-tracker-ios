//
//  TimeLogService.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class TimeLogService: NSObject {
    static let shared = TimeLogService()
    
    func getTimeLogHistory(completion: @escaping (TimelyAPIResult) -> ()) {
        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kTimeLogHistoryUrl)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER_WITH_TOKEN).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let timeLogDetails = Mapper<TimeLogDetails>().map(JSON: response.value as! [String : Any])
                return completion(.success(timeLogDetails!))
            }
            else {
                return completion(.error("Error while getting logs"))
            }
        }
    }
}
