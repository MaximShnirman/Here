//
//  Cache.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 03/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

final class Cache<Key: Hashable, Value> {
    private let wrapped = NSCache<WrappedKey, Entry>()
    
    func set(_ value: Value, for key: Key) {
        let entry = Entry(value: value)
        wrapped.setObject(entry, forKey: WrappedKey(key))
    }
    
    func object(for key: Key) -> Value? {
        let entry = wrapped.object(forKey: WrappedKey(key))
        return entry!.value
    }
    
    func remove(for key: Key) {
        wrapped.removeObject(forKey: WrappedKey(key))
    }
}

private extension Cache {
    final class WrappedKey: NSObject {
        let key: Key

        init(_ key: Key) { self.key = key }

        override var hash: Int { return key.hashValue }

        override func isEqual(_ object: Any?) -> Bool {
            guard let value = object as? WrappedKey else {
                return false
            }

            return value.key == key
        }
    }
}

private extension Cache {
    final class Entry {
        let value: Value

        init(value: Value) {
            self.value = value
        }
    }
}

extension Cache {
    subscript(key: Key) -> Value? {
        get {
            return object(for: key)
        }
        set {
            guard let value = newValue else {
                remove(for: key)
                return
            }

            set(value, for: key)
        }
    }
}
