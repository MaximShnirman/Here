//
//  Observable.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 20/09/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

class Observable<T> {
    
    var valueChanged: (T) -> () = { _ in }
    
    var value: T {
        didSet {
            DispatchQueue.main.async {
                self.valueChanged(self.value)
            }
        }
    }
    
    init(_ v: T) {
        value = v
    }
    
}
