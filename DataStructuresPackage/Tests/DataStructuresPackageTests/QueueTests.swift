//
//  QueueTests.swift
//  
//
//  Created by Aleksandr Mamlygo on 08.01.24.
//

import XCTest
@testable import DataStructuresPackage

final class QueueTests: XCTestCase {

    func test_init_emptryQueue_shouldBeEmpty() {
        let sut = Queue<Int>()
        
        XCTAssertTrue(sut.isEmpty, "Созданная очередь не пустая")
        XCTAssertEqual(sut.count, 0, "Количество элементов в пустой очереди не равно 0")
        XCTAssertNil(sut.peek, "Удается получить элемент из пустой очереди")
    }
    
    func test_enqueue_twoValues_shouldHaveCorrectCountAndValue() {
        var sut = Queue<Int>()
        
        sut.enqueue(1)
        sut.enqueue(2)
        
        XCTAssertEqual(sut.count, 2, "Неверное количество значений в очереди")
        XCTAssertEqual(sut.peek, 1, "Некорректен первый элемент очереди")
    }

    func test_dequeue_oneValue_shouldHaveCorrectCountAndReturnedValue() {
        var sut = Queue<Int>()
        sut.enqueue(1)
        sut.enqueue(2)
        
        let dequeuedValue = sut.dequeue()
        
        XCTAssertEqual(dequeuedValue, 1, "Очередь вернула некорректное значение")
        XCTAssertEqual(sut.count, 1, "Количество значений в очереди неверно")
        XCTAssertEqual(sut.peek, 2, "Первый элемент в очереди после выполнения dequeue некорректен")
    }
    
    func test_dequeue_twoTimes_shouldHaveCorrectCountAndReturnedValue() {
        var sut = Queue<Int>()
        sut.enqueue(1)
        sut.enqueue(2)
        
        _ = sut.dequeue()
        let secondDequeuedValue = sut.dequeue()
        
        XCTAssertEqual(secondDequeuedValue, 2, "Очередь вернула некорректное значение")
        XCTAssertTrue(sut.isEmpty, "Очередь не пуста")
        XCTAssertEqual(sut.count, 0, "Количество значений в пустой очереди не 0")
        XCTAssertNil(sut.peek, "Удается получить элемент из пустой очереди")
    }
    
    func test_dequeue_fromEmptyQueue_shouldBeCorrect() {
        var sut = Queue<Int>()
        
        let dequeuedValue = sut.dequeue()
        
        XCTAssertNil(dequeuedValue, "Удалось получить значение из пустой очереди")
        XCTAssertEqual(sut.count, 0, "Количество значений в пустой очереди не 0")
        XCTAssertTrue(sut.isEmpty, "Очередь не пуста")
    }
    
    func test_peek_onTwoValues_shouldReturnCorrectValues() {
        var sut = Queue<Int>()
        sut.enqueue(1)
        sut.enqueue(2)
        
        let firstPeek = sut.peek
        _ = sut.dequeue()
        let secondPeek = sut.peek
        
        XCTAssertEqual(firstPeek, 1, "Очередь вернула некорректное значение")
        XCTAssertEqual(secondPeek, 2, "Очередь вернула некорректное значение")
        XCTAssertEqual(sut.count, 1, "Количество значений в очереди неверно")
    }
}


