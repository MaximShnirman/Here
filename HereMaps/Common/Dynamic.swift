//
//  Dynamic.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

class Dynamic<T> {
    
    var bind: (T) -> () = { _ in }
    
    var value: T? {
        didSet {
            bind(value!)
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
}
