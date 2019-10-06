//
//  LinkedList.swift
//  HereMaps
//
//  Created by Maxim Shnirman on 04/10/2019.
//  Copyright © 2019 MaxMan. All rights reserved.
//

import Foundation

struct List<Value> {
    private(set) var firstNode: Node?
    private(set) var lastNode: Node?
}

extension List {
    class Node {
        var value: Value
        fileprivate(set) weak var previous: Node?
        fileprivate(set) var next: Node?

        init(value: Value) {
            self.value = value
        }
    }
}

extension List: Sequence {
    func makeIterator() -> AnyIterator<Value> {
        var node = firstNode

        return AnyIterator {
            let value = node?.value
            node = node?.next
            return value
        }
    }
}

extension List {
    @discardableResult
    mutating func append(_ value: Value) -> Node {
        let node = Node(value: value)
        node.previous = lastNode

        lastNode?.next = node
        lastNode = node

        if firstNode == nil {
            firstNode = node
        }

        return node
    }
}

extension List {
    mutating func remove(_ node: Node) {
        node.previous?.next = node.next
        node.next?.previous = node.previous

        // Using "triple-equals" we can compare two class
        // instances by identity, rather than by value:
        if firstNode === node {
            firstNode = node.next
        }

        if lastNode === node {
            lastNode = node.previous
        }
    }
}
