//
//  TomatoFarm.swift
//  Graphs
//
//  Created by Martin Kuchar on 2020-07-27.
//  Copyright © 2020 Martin Kuchar. All rights reserved.
//

import Foundation

public final class Queue<E> : Sequence {
    
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

func numOfDays() {
    struct Square {
        let x: Int
        let y: Int
    }
    let farmSize = readLine()!.split(separator: " ").map { Int($0)! }
    let farmWidth = farmSize[0]
    let farmHeight = farmSize[1]
    var farm = [[Int]]()
    
    let dx = [1, -1, 0, 0]
    let dy = [0, 0, -1, 1]
    
    for _ in 0..<farmHeight {
        farm.append(readLine()!.split(separator: " ").map { Int($0)! })
    }
    print(farm)
    
    func ripeAdjc() -> Int {
        let q = Queue<Square>()
        let qAdj = Queue<Int>() // another queue to keep track of the depth from the current square
        
        // Enqueue all the 1s and will do BFS from all the 1s at once.
        for i in 0..<farmHeight {
            for j in 0..<farmWidth {
                if farm[i][j] == 1 {
                    q.enqueue(item: Square(x: i, y: j))
                    qAdj.enqueue(item: 0)
                }
            }
        }

        var duration = Int()
        
        while !q.isEmpty() {
            let s = q.dequeue()!
            duration = qAdj.dequeue()!
            for i in 0...3 {
                let nx = s.x + dx[i]
                let ny = s.y + dy[i]
                if nx >= 0 && nx < farmHeight && ny >= 0 && ny < farmWidth {
                    if farm[nx][ny] == 0 {
                        q.enqueue(item: Square(x: nx, y: ny))
                        qAdj.enqueue(item: duration + 1)
                        farm[nx][ny] = 1
                    }
                }
                
            }
        }
        return duration
    }
    
    var numOfDays = 0
    
    numOfDays += ripeAdjc()
    
    // Check if all the 0s were changed to 1s otherwise return -1
    for i in 0..<farmHeight {
        for j in 0..<farmWidth {
            if farm[i][j] == 0 {
              numOfDays = -1
            }
        }
    }
    
    print(numOfDays)
}
