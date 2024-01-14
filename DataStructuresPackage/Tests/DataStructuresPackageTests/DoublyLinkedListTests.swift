//
//  DoublyLinkedListTests.swift
//  
//
//  Created by Александр Мамлыго on /71/2567 BE.
//

import XCTest
@testable import DataStructuresPackage

final class DoublyLinkedListTests: XCTestCase {
    
    func test_init_withoutArguments_shouldBeEmpty() {
        let sut = DoublyLinkedList<Int>()
        
        XCTAssertTrue(sut.isEmpty, "Ожидался пустой список")
        XCTAssertEqual(sut.count, 0, "Ожидалась длина списка 0")
        XCTAssertNil(sut.headValue, "Ожидалось отсутствие head")
        XCTAssertNil(sut.tailValue, "Ожидалось отсутствие tail")
    }
    
    func test_init_withValue_shouldBeCorrect() {
        let expectedValue = 5
        
        let sut = DoublyLinkedList(value: expectedValue)
        
        XCTAssertFalse(sut.isEmpty, "Ожидалось создание не пустого списка")
        XCTAssertEqual(sut.count, 1, "Ожидался список из 1 элемента")
        XCTAssertEqual(sut.headValue, expectedValue, "Head списка пуст")
        XCTAssertEqual(sut.tailValue, expectedValue, "Tail списка пуст")
    }
    
    func test_push_twoTimesOnEmptryList_shouldHaveCorrectCount() {
        var sut = DoublyLinkedList<Int>()
        
        sut.push(5)
        sut.push(0)
        
        XCTAssertFalse(sut.isEmpty, "Список из двух элементов не должен быть пуст")
        XCTAssertEqual(sut.count, 2, "Ожидался список из двух элементов")
    }
    
    func test_append_twoTimesOnEmptyList_shouldHaveCorrectCount() {
        var sut = DoublyLinkedList<Int>()
        
        sut.append(5)
        sut.append(0)
        
        XCTAssertFalse(sut.isEmpty, "Список из двух элементов не должен быть пуст")
        XCTAssertEqual(sut.count, 2, "Ожидался список из двух элементов")
    }
    
    func test_insert_intoMiddle_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        
        sut.insert(6, after: 0)
        
        XCTAssertEqual(sut.count, 3, "Ожидался список из 3х элементов")
        XCTAssertEqual(sut.headValue, 3, "Значение head неверно")
        XCTAssertEqual(sut.tailValue, 5, "Значение tail неверно")
    }
    
    func test_insert_afterInvalidIndex_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        
        sut.insert(6, after: 3)
        
        XCTAssertEqual(sut.count, 2, "Ожидался список из 2х элементов")
        XCTAssertEqual(sut.headValue, 3, "Значение head неверно")
        XCTAssertEqual(sut.tailValue, 5, "Значение tail неверно")
    }
    
    func test_insert_afterTail_shouldHaveCorrectValuesAndCount() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        
        sut.insert(6, after: 1)
        
        XCTAssertEqual(sut.count, 3, "Ожидался список из 3х элементов")
        XCTAssertEqual(sut.headValue, 3, "Значение head неверно")
        XCTAssertEqual(sut.tailValue, 6, "Значение tail неверно")
    }
    
    func test_removeAfter_fromThreeElementList_shouldHaveCorrectCountAndValue() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        sut.append(6)
        
        let removedValue = sut.remove(after: 0)
        
        XCTAssertEqual(sut.count, 2, "Ожидался список из 2 значений")
        XCTAssertEqual(removedValue, 5, "RemoveLast вернул неверное значение")
        XCTAssertEqual(sut.headValue, 3, "Неверное значение 3")
        XCTAssertEqual(sut.tailValue, 6, "Неверное значение 6")
    }
    
    func test_removeAfter_fromEmptyList_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        
        let removedValue = sut.remove(after: 0)
        
        XCTAssertTrue(sut.isEmpty, "Список не пустой")
        XCTAssertEqual(sut.count, 0, "Количество элементов не 0")
        XCTAssertNil(removedValue, "Ожидалось пустое значение")
    }
    
    func test_removeAfter_tailFromTwoElementList_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        sut.push(3)
        sut.push(5)
        
        let removedValue = sut.remove(after: 1)
        
        XCTAssertEqual(sut.count, 2, "Количество элементов было изменено")
        XCTAssertNil(removedValue, "Ожидалось пустое значение")
    }
    
    func test_pop_fromTwoElementList_shouldHaveCorrectCountAndValue() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        
        let popValue = sut.pop()
        
        XCTAssertEqual(sut.count, 1, "Ожидался список из 1 элемента")
        XCTAssertEqual(popValue, 3, "Pop вернул неверное значение")
        XCTAssertEqual(sut.headValue, 5, "Неверное значение head")
        XCTAssertEqual(sut.headValue, 5, "Неверное значение tail")
    }
    
    func test_pop_fromEmptyList_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        
        let popValue = sut.pop()
        
        XCTAssertTrue(sut.isEmpty, "Список не пустой")
        XCTAssertEqual(sut.count, 0, "Количество элементов списка не 0")
        XCTAssertNil(popValue, "Pop вернул не пустое значение")
    }
    
    func test_removeLast_fromTwoElementList_shouldHaveCorrectCountAndValue() {
        var sut = DoublyLinkedList<Int>()
        sut.append(3)
        sut.append(5)
        
        let removedValue = sut.removeLast()
        
        XCTAssertEqual(sut.count, 1, "Ожидался список из 1 элемента")
        XCTAssertEqual(removedValue, 5, "Pop вернул неверное значение")
        XCTAssertEqual(sut.headValue, 3, "Неверное значение head")
        XCTAssertEqual(sut.headValue, 3, "Неверное значение tail")
    }
    
    func test_removeLast_fromEmptyList_shouldBeCorrect() {
        var sut = DoublyLinkedList<Int>()
        
        let removedValue = sut.removeLast()
        
        XCTAssertEqual(sut.count, 0, "Количество элементов списка не 0")
        XCTAssertTrue(sut.isEmpty, "Список не пуст")
        XCTAssertNil(removedValue, "Возвращено не пустое значение")
    }
    
    func test_valueAtIndex_shouldReturnCorrectValue() {
        var sut = DoublyLinkedList<Int>()
        sut.append(1)
        sut.append(2)
        sut.append(3)
        sut.append(4)
        sut.append(5)
        
        let valueAtNegativeOne = sut.value(at: -1)
        let valueAt0 = sut.value(at: 0)
        let valueAt1 = sut.value(at: 1)
        let valueAt2 = sut.value(at: 2)
        let valueAt3 = sut.value(at: 3)
        let valueAt4 = sut.value(at: 4)
        let valueAt5 = sut.value(at: 5)
        
        XCTAssertEqual(valueAt0, 1, "Неверное значение по запрошенному индексу")
        XCTAssertEqual(valueAt1, 2, "Неверное значение по запрошенному индексу")
        XCTAssertEqual(valueAt2, 3, "Неверное значение по запрошенному индексу")
        XCTAssertEqual(valueAt3, 4, "Неверное значение по запрошенному индексу")
        XCTAssertEqual(valueAt4, 5, "Неверное значение по запрошенному индексу")
        XCTAssertNil(valueAt5, "Список вернул несуществующее значение")
        XCTAssertNil(valueAtNegativeOne, "Список вернул несуществующее значение")
    }
}


