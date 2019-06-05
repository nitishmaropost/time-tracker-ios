//
//  ResponseEnums.swift
//  Timely
//
//  Created by maropost on 17/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

enum TimelyAPIResult {
    case success(Any)
    case error(String)
}

enum Navigations {
    case today
    case week
    case month
    case all
}
