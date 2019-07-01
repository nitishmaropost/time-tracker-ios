//
//  AttendanceVM.swift
//  Timely
//
//  Created by maropost on 27/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

class AttendanceVM: NSObject {
    var attendance: Attendance?
    var selectedRow: RowsShift?
    var filteredUsers = [RowsShift]()
    
    func getAttendanceDetails(completion: @escaping (TimelyAPIResult) -> ()) {
        AttendanceService.shared.getAttendanceDetails { (result) in
            
            switch result {
            case .success(let attendance):
                let attend = attendance as? Attendance
                self.attendance = attend
                return completion(.success(attendance))
            case .error(let error):
                return completion(.error(error))
            @unknown default:
                print("default")
            }
        }
    }
}
