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
    
    func getTimeLogHistory(requestDict: [String: String]?, completion: @escaping (TimelyAPIResult) -> ()) throws {
        AF.request("\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kTimeLogHistoryUrl)", method: .get, parameters: requestDict, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER_WITH_TOKEN).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                do {
                    let timeLogDetails = try JSONDecoder().decode(TimeLogDetails.self, from: response.data!)
                    return completion(.success(timeLogDetails))
                } catch {
                    print("JSONSerialization error\(error)")
                    return completion(.error("Error while getting logs"))
                }
            }
            else {
                return completion(.error("Error while getting logs"))
            }
        }
    }
}
