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
    var startDateString: String!
    var endDateString: String!
    var startDate: Date!
    var endDate: Date!
    var startDateDisplayString: String!
    var endDateDisplayString: String!
    
    override init() {
        super.init()
        self.dictLogDates = [String: Any]()
        self.setDefaultFilter()
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
    
    func startDateMilliSeconds(startDate: Date) -> String {
        return "\(startDate.millisecondsSince1970)"
    }
    
    func endDateMilliSeconds(endDate: Date) -> String {
        return "\(endDate.millisecondsSince1970)"
    }
    
    func setDefaultFilter() {
        self.startDate = Date().startOfWeek
        self.endDate = Date().endOfWeek
        self.startDateString = self.startDateMilliSeconds(startDate: self.startDate)
        self.endDateString = self.endDateMilliSeconds(endDate: self.endDate)
        self.setDisplayStrings()
    }
    
    func setDisplayStrings() {
        self.dateFormatter.dateFormat = "dd-MM-yyyy"
        self.startDateDisplayString = self.dateFormatter.string(from: self.startDate)
        self.endDateDisplayString = self.dateFormatter.string(from: self.endDate)
    }
    
    func getTimeString(dateString: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
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
    
    func getTimeLogHistory(requestDict: [String: String]?, completion: @escaping (TimelyAPIResult) -> ()) {
        do {
            try TimeLogService.shared.getTimeLogHistory(requestDict: requestDict) { (result) in
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
        }  catch {
            print("error")
        }
        
        
    }
}
