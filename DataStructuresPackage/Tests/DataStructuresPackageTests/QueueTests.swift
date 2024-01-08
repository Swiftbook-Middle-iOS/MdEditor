//
//  QueueTests.swift
//  
//
//  Created by Aleksandr Mamlygo on 08.01.24.
//

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {

    func test_initIntQueue_shouldCreateEmptyQueue() {
        let sut = makeEmptyIntSut()
        
        XCTAssertTrue(sut.isEmpty, "Queue should be empty when initialized with no arguments")
    }
    
    func test_initIntQueue_shouldHaveZeroCount() {
        let sut = makeEmptyIntSut()
        
        XCTAssertEqual(sut.count, 0, "Queue should have 0 count when initialized with no arguments")
    }
    
    func test_enqueue_shouldIncreaseCount() {
        var sut = makeEmptyIntSut()
        
        let initialCount = sut.count
        sut.enqueue(10)
        
        XCTAssertEqual(initialCount + 1, sut.count, "Enqueue on empty queue should increase count by 1")
    }
    
    func test_enqueue_tenTimes_shouldIncreaseCountByTen() {
        var sut = makeEmptyIntSut()
        
        let initialCount = sut.count
        let count = 10
        for n in 1...count {
            sut.enqueue(n)
        }
        
        XCTAssertEqual(initialCount + count, sut.count, "Enqueue 10 times on empty queue should increase count by 10")
    }

    func test_dequeue_onEmptyQueue_shouldReturnNil() {
        var sut = makeEmptyIntSut()
        
        XCTAssertNil(sut.dequeue(), "Dequeue from empty queue should return nil")
    }
    
    func test_dequeue_onEmptyQueue_shouldNotChangeCount() {
        var sut = makeEmptyIntSut()
        
        let initialCount = sut.count
        _ = sut.dequeue()
        
        XCTAssertEqual(initialCount, sut.count, "Dequeue from empty queue should not decrease count")
    }
    
    func test_dequeue_afterEnqueue_shouldReturnSameElement() {
        var sut = makeEmptyIntSut()
        
        let elementToEnqueue = 143
        sut.enqueue(elementToEnqueue)
        
        XCTAssertEqual(sut.dequeue(), elementToEnqueue, "Element to enqueue should match the dequeued")
    }
    
    func test_dequeue_afterOneEnqueue_shouldReduceCountByOne() {
        var sut = makeEmptyIntSut()
        
        sut.enqueue(143)
        let initialCount = sut.count
        _ = sut.dequeue()
        
        XCTAssertEqual(sut.count, initialCount - 1, "Dequeue from non-empty queue should reduce count by one")
    }
    
    func test_dequeue_twoTimesAfterMultipleEnqueue_shouldReduceCountByTwo() {
        var sut = makeEmptyIntSut()
        
        for n in (1...100) {
            sut.enqueue(n)
        }
        
        let initialCount = sut.count
        
        _ = sut.dequeue()
        _ = sut.dequeue()
        
        XCTAssertEqual(sut.count, initialCount - 2, "Dequeue two times from non-empty queue should reduce count by two")
    }
    
    func test_dequeue_twoTimes_shouldReturnSecondToLastElement() {
        var sut = makeEmptyIntSut()
        
        let firstElement = 4
        let secondElement = 5
        let thirdElement = 6
        let fourthElement = 8
        
        sut.enqueue(firstElement)
        sut.enqueue(secondElement)
        sut.enqueue(thirdElement)
        sut.enqueue(fourthElement)
        
        _ = sut.dequeue()
        let secondDequeued = sut.dequeue()
        
        XCTAssertEqual(secondDequeued, secondElement, "Second dequeued should match third added for 4-element queue")
    }
}

extension QueueTests {
    func makeEmptyIntSut() -> Queue<Int> {
        Queue<Int>()
    }
}
