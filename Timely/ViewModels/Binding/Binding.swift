//
//  Binding.swift
//  Maropost MSC
//
//  Created by Nitish on 20/04/18.
//  Copyright © 2018 Nitish. All rights reserved.
//

import Foundation

class Binding<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
}
