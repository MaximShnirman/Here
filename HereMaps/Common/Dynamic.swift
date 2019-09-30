//
//  Dynamic.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

// reference:
// https://medium.com/@azamsharp/mvvm-in-ios-from-net-perspective-580eb7f4f129
// https://medium.com/@azamsharp/mvvm-in-ios-viewmodel-and-networking-5bbe1d768c7f

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
