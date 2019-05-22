//
//  TimeLogHistoryVM.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import SwiftDate

class TimeLogHistoryVM : NSObject {
    
    var dictLogDates: [String: Any]?
    var timeLogDetails: TimeLogDetails!
    let dateFormatter = DateFormatter()
    
    override init() {
        self.dictLogDates = [String: Any]()
    }
    
    func convertDateStringToDate(logString: String) -> DateInRegion {
        let dateString = logString.components(separatedBy: "T")[0]
        return dateString.toDate()!
    }
    
    func groupDetailsByDate() {
        
    }
    
    func returnPinTypeString(pinType: String) -> String {
        var pintText: String!
        for key in TimelyConstants.shared.pinTypes.keys {
            if pinType == key {
                pintText = TimelyConstants.shared.pinTypes[key]
                break
            }
        }
        
        return pintText
    }
    
    func getTimeString(dateString: String) -> String {
        let dateStringWithoutMilisec = dateString.components(separatedBy: ".")[0]
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateStringWithoutMilisec)
        dateFormatter.dateFormat = "hh:mm a"
        let timeString = dateFormatter.string(from: date!)
        return timeString
    }
    
    func dateStringDifferent(currentRowDateString: String, previousRowDateString: String) -> Bool {
        let dateStringCurrent = currentRowDateString.components(separatedBy: "T")[0]
        let dateStringPrevious = previousRowDateString.components(separatedBy: "T")[0]
        if dateStringCurrent == dateStringPrevious {
            return false
        }
        
        return true
    }
    
    func getTimeLogHistory(completion: @escaping (TimelyAPIResult) -> ()) {
        TimeLogService.shared.getTimeLogHistory { (result) in
            switch result {
            case .success(let timeLogHistory):
                let history = timeLogHistory as? TimeLogDetails
                self.timeLogDetails = history

                
                return completion(.success(timeLogHistory))
            case .error(let error):
                return completion(.error(error))
            @unknown default:
                print("default")
            }
        }
    }
}
