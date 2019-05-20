//
//  Reachability.swift
//  Maropost MSC
//
//  Created by maropost on 25/06/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import Foundation
import Alamofire

struct Connectivity {
    static let sharedInstance = NetworkReachabilityManager()!
    static var isConnectedToInternet:Bool {
        return self.sharedInstance.isReachable
    }
}
