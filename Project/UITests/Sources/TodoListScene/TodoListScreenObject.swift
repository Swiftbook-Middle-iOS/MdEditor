//
//  TodoListScreenObject.swift
//  MdEditorUITests
//
//  Created by Aleksandr Mamlygo on 27.01.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest

final class TodoListScreenObject: BaseScreenObject {
    
    // MARK: Private properties
    
    private lazy var tableView = app.tables.matching(identifier: AccessibilityIdentifier.todoListTableView.description)
    private let expectedSectionCount = 2
    private let expectedStartingCompleteTaskCount = 1
    private let expectedStartingIncompleteTaskCount = 4
    
    // MARK: ScreenObject methods
    
    @discardableResult
    func isTodoListScreen() -> Self {
        assert(tableView.element, [.exists])
        return self
    }
    
    func hasCorrectSectionCount() {
        assert(getSectionLabel(section: expectedSectionCount - 1), [.exists])
        assert(getSectionLabel(section: expectedSectionCount), [.doesNotExist])
    }
    
    @discardableResult
    func hasCompleteSection() -> Self {
        XCTAssertTrue(getSectionTitles(count: expectedSectionCount).contains("Complete"), "В названиях секций отсутствует Complete")
        return self
    }
    
    @discardableResult
    func hasIncompleteSection() -> Self {
        XCTAssertTrue(getSectionTitles(count: expectedSectionCount).contains("Uncompleted"), "В названиях секций отсутствует Uncompleted")
        return self
    }
    
    @discardableResult
    func tapFirstIncompleteTask() -> Self {
        let firstCell = getCell(section: 0, index: 0)
        firstCell.tap()

        return self
    }
    
    @discardableResult
    func incompleteSectionHasCorrectTaskCountAfterTap() -> Self {
        // Correcting for 0 based index + one removed task
        let lastIndex = expectedStartingIncompleteTaskCount - 2
        
        assert(getCell(section: 0, index: lastIndex), [.exists])
        assert(getCell(section: 0, index: lastIndex + 1), [.doesNotExist])
        
        return self
    }
    
    @discardableResult
    func completeSectionHasCorrectTaskCountAfterTap() -> Self {
        // Correcting for 0 based index + one added task
        let lastIndex = expectedStartingCompleteTaskCount
        
        assert(getCell(section: 1, index: lastIndex), [.exists])
        assert(getCell(section: 1, index: lastIndex + 1), [.doesNotExist])
        
        return self
    }
    
    func completedSectionHasExpectedTaskTitle() {
        let hasExpectedTitle = (0...expectedStartingCompleteTaskCount).map {
            getCellTitle(cell: getCell(section: 1, index: $0))
        }.contains("!!! Do homework")
        
        XCTAssertTrue(hasExpectedTitle, "Секция завершенных задач не содержит задачу с ожидаемым названием")
    }
    
    // MARK: Private methods
    private func getSectionLabel(section: Int) -> XCUIElement {
        tableView.staticTexts.matching(
            identifier: AccessibilityIdentifier.sectionLabel(section: section).description
        ).element
    }
    
    private func getSectionTitles(count: Int) -> [String] {
        return (0..<count).map { getSectionLabel(section: $0).label }
    }
    
    private func getCell(section: Int, index: Int) -> XCUIElement {
        tableView.cells.element(matching: .cell, identifier: AccessibilityIdentifier.cell(section: section, index: index).description)
    }
    
    private func getCellTitle(cell: XCUIElement) -> String {
        cell.staticTexts.firstMatch.label
    }
}


