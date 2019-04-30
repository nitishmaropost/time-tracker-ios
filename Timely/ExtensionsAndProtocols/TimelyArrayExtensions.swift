//
//  TimelyArrayExtensions.swift
//  Timely
//
//  Created by maropost on 30/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation

extension Array {
    func randomItem() -> Element? {
        if isEmpty { return nil }
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}
