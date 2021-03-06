//
//  Queue.swift
//  SwiftAlgorithmAndDataStructure
//
//  Created by Martin Kuchar on 2020-07-09.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

public final class MyQueue<E> : Sequence {
    
    private(set) var count = 0
    private var head: Node<E>? = nil
    private var tail: Node<E>? = nil
    
    fileprivate class Node<E> {
        fileprivate var item: E
        fileprivate var next: Node<E>?
        
        fileprivate init(_ item: E, _ next: Node<E>? = nil) {
            self.item = item
            self.next = next
        }
    }
    
    public init() { }
    
    /// Returns true or false
    /// - Returns: True if the queue is empty, otherwise False
    public func isEmpty() -> Bool {
        return count == 0
    }
    
    public func enqueue(item: E) {
        let oldLast = tail
        self.tail = Node<E>(item)
        if isEmpty() {
            self.head = tail
        } else {
            oldLast?.next = tail
        }
        count += 1
    }
    
    public func dequeue() -> E? {
        if let item = head?.item {
            head = head?.next
            count -= 1
            if isEmpty() {
                tail = nil
            }
            return item
        }
        return nil
    }
    
    public func peek() -> E? {
        return head?.item
    }
    
    public struct QueueIterator<E> : IteratorProtocol {
        private var current: Node<E>?
        
        fileprivate init(_ first: Node<E>?) {
            self.current = first
        }
        
        public mutating func next() -> E? {
            if let item = current?.item {
                self.current = current?.next
                return item
            }
            return nil
        }
        
        public typealias Element = E
    }
    
    public func makeIterator() -> QueueIterator<E> {
        return QueueIterator<E>(head)
    }
}
