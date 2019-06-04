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
        let manager = Alamofire.Session.default
        manager.session.configuration.timeoutIntervalForRequest = 120
        
        manager.request(requestDict!["start_date"] == "" ? "\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kTimeLogHistoryUrl)" : "\(TimelyUrls.shared.kServerUrl)\(TimelyUrls.shared.kTimeLogHistoryUrl)?start_date=\(requestDict!["start_date"] ?? "")&end_date=\(requestDict!["end_date"] ?? "")", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: TimelyUrls.shared.HEADER_WITH_TOKEN).responseJSON { (response) in
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
