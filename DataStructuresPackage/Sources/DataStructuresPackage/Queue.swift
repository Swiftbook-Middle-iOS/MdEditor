//
//  Queue.swift
//  
//
//  Created by Александр Мамлыго on /51/2567 BE.
//

import Foundation

public struct Queue<T> {
    private var elements: DoublyLinkedList<T> = DoublyLinkedList<T>()

    var isEmpty: Bool {
        elements.isEmpty
    }

    var count: Int {
        elements.count
    }

    mutating func enqueue(_ element: T) {
        elements.append(element)
    }

    mutating func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.pop()
    }
}
