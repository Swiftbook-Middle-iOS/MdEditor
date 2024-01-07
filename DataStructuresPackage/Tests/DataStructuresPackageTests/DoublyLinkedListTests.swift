//
//  DoublyLinkedListTests.swift
//  
//
//  Created by Александр Мамлыго on /71/2567 BE.
//

import XCTest
@testable import DataStructuresPackage

final class DoublyLinkedListTests: XCTestCase {
    
    func test_initIntList_withoutArguments_shouldCreateZeroCountList() {
        let sut = makeEmptyIntSut()
        
        XCTAssertEqual(sut.count, 0, "В пустом списке должно быть 0 элементов")
    }
    
    func test_initIntList_withValue_shouldCreateOneCountList() {
        let sut = makeIntSutWithOneValue()
        
        XCTAssertEqual(sut.count, 1)
    }
    
    func test_push_shouldIncreaseCountByOne() {
        var sut = makeIntSutWithOneValue()
        
        let initialCount = sut.count
        sut.push(5)
        
        XCTAssertEqual(sut.count, initialCount + 1, "Push should increase list's count by one")
    }
    
    func test_push_multipleTimes_popShouldReturnLastPushed() {
        var sut = makeEmptyIntSut()
        
        sut.push(5)
        let lastPush = 6
        sut.push(lastPush)
        
        XCTAssertEqual(sut.pop(), 6, "Push should add elements to beginning of array")
    }
    
    func test_append_shouldIncreaseCountByOne() {
        var sut = makeIntSutWithOneValue()
        
        let initialCount = sut.count
        sut.append(7)
        
        XCTAssertEqual(sut.count, initialCount + 1, "Append should increase list's count by one")
    }
    
    func test_append_multipleTimes_removeLastShouldReturnLastAppended() {
        var sut = makeEmptyIntSut()
        
        sut.append(10)
        let lastAppend = 0
        sut.append(lastAppend)
        
        XCTAssertEqual(sut.removeLast(), lastAppend, "Append should add elements to end of array")
    }
    
    func test_insert_shouldIncreaseCountByOne() {
        var sut = makeIntSutWithOneValue()
        
        let initialCount = sut.count
        sut.insert(10, after: 0)
        
        XCTAssertEqual(sut.count, initialCount + 1, "Insert should increase element count by one")
    }
    
    func test_insert_afterNonExistentIndex_shouldNotIncreaseCount() {
        var sut = makeIntSutWithOneValue()
        
        let initialCount = sut.count
        sut.insert(5, after: -10)
        
        XCTAssertEqual(sut.count, initialCount, "Insert after non-existent index should not increase count")
    }
    
    func test_insert_afterLastIndex_shouldMatchReturnLast() {
        var sut = makeIntSutWithOneValue()
        
        sut.append(20)
        let valueToInsertAtEnd = 45
        sut.insert(valueToInsertAtEnd, after: sut.count - 1)
        
        XCTAssertEqual(valueToInsertAtEnd, sut.removeLast(), "Inserted value at end should be the last")
    }
    
    func test_insert_inMiddle() {
        var sut = makeIntSutWithThreeValues()
        
        sut.insert(7, after: 1)
        
        XCTAssertEqual(sut.description, "6 -> 5 -> 7 -> 4", "7 should be added after 5")
    }
    
    func test_insert_afterZero_shouldBeSecond() {
        var sut = makeIntSutWithThreeValues()
        
        sut.insert(7, after: 0)
        
        XCTAssertEqual(sut.description, "6 -> 7 -> 5 -> 4", "7 should bethe second value in list)")
    }
    
    func test_pop_fromEmptyList_shouldReturnNil() {
        var sut = makeEmptyIntSut()
        
        XCTAssertNil(sut.pop(), "Pop from empty list should return nil")
    }
    
    func test_pop_fromNonEmptyList_shouldDecreaseCount() {
        var sut = makeIntSutWithOneValue()
        
        let initialCount = sut.count
        _ = sut.pop()
        
        XCTAssertEqual(sut.count, initialCount - 1, "Pop from non-empty list should decrease count")
    }
    
    func test_pop_fromNonEmptyList_shouldRemoveFirstValue() {
        var sut = makeIntSutWithThreeValues()
        
        _ = sut.pop()
        
        XCTAssertEqual(sut.description, "5 -> 4", "6 should be removed (as the first value)")
    }
    
    func test_pop_fromOneElementList_listShoudBeEmpty() {
        var sut = makeIntSutWithOneValue()
        
        _ = sut.pop()
        
        XCTAssertTrue(sut.isEmpty, "List should remain empty after the only item is removed")
    }
    
    func test_removeLast_fromEmptyList_shouldReturnNil() {
        var sut = makeEmptyIntSut()
        
        XCTAssertNil(sut.removeLast(), "Remove last from empty list should return nil")
    }
    
    func test_removeLast_fromNonEmptyList_shouldDecreaseCount() {
        var sut = makeIntSutWithThreeValues()
        
        let initialCount = sut.count
        _ = sut.removeLast()
        
        XCTAssertEqual(sut.count, initialCount - 1, "removeLast from non-empty list should decrease count")
    }
    
    func test_removeLast_fromNonEmptyList_shouldRemoveLastElement() {
        var sut = makeIntSutWithThreeValues()
        
        _ = sut.removeLast()
        
        XCTAssertEqual(sut.description, "6 -> 5", "4 should be removed (as the last value)")
    }
    
    func test_removeLast_fromOneElementList_listShoudBeEmpty() {
        var sut = makeIntSutWithOneValue()
        
        _ = sut.removeLast()
        
        XCTAssertTrue(sut.isEmpty, "List should remain empty after the only item is removed")
    }
    
    func test_removeAfter_fromEmptyList_shouldReturnNil() {
        var sut = makeEmptyIntSut()
        
        XCTAssertNil(sut.remove(after: 0), "Remove from empty list should return nil")
    }
    
    func test_removeAfter_fromEmptyList_countShouldRemainZero() {
        var sut = makeEmptyIntSut()
        
        _ = sut.remove(after: 0)
        
        XCTAssertEqual(sut.count, 0, "Remove from empty list should leave list with 0 count")
    }
    
    func test_removeAfter_tail_shouldReturnNil() {
        var sut = makeIntSutWithThreeValues()
        
        XCTAssertNil(sut.remove(after: 2), "Remove from after tail should return nil")
    }
    
    func test_removeAfter_tail_shouldNotDecreaseCount() {
        var sut = makeIntSutWithThreeValues()
        
        let initialCount = sut.count
        _ = sut.remove(after: 2)
        
        XCTAssertEqual(initialCount, sut.count, "Removing element after tail should not decrease count")
    }
    
    func test_removeAfter_firstElementFromThreeElemenentList_shouldReduceCount() {
        var sut = makeIntSutWithThreeValues()
        
        let initialCount = sut.count
        _ = sut.remove(after: 0)
        
        XCTAssertEqual(initialCount - 1, sut.count, "Removing after first element should decrease count")
    }
    
    func test_removeAfter_secondElementFromThreeElemenentList_shouldRemoveLast() {
        var sut = makeIntSutWithThreeValues()
        
        _ = sut.remove(after: 1)
        
        XCTAssertEqual(sut.description, "6 -> 5", "Removing element after after second should remove 4 and leave 6 -> 5")
    }
    
    func test_removeAfter_negativeIndex_shouldNotReduceCount() {
        var sut = makeIntSutWithThreeValues()
        
        let initialCount = sut.count
        _ = sut.remove(after: -1)
        
        XCTAssertEqual(initialCount, sut.count, "Removing after invalid index should not decrease count")
    }
    
    func test_removeAfter_negativeIndex_shouldNotChangeList() {
        var sut = makeIntSutWithThreeValues()
        
        let initialDesc = sut.description
        _ = sut.remove(after: -1)
        
        XCTAssertEqual(initialDesc, sut.description, "Removing after invalid index should not change list")
    }
}

extension DoublyLinkedListTests {
    func makeEmptyIntSut() -> DoublyLinkedList<Int> {
        DoublyLinkedList<Int>()
    }
    
    func makeIntSutWithOneValue() -> DoublyLinkedList<Int> {
        DoublyLinkedList(value: 4)
    }
    
    func makeIntSutWithThreeValues() -> DoublyLinkedList<Int> {
        /// returns 6 -> 5 -> 4 list
        var list = DoublyLinkedList(value: 4)
        list.push(5)
        list.push(6)
        
        return list
    }
}
