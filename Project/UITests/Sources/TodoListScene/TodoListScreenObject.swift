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
    
    // MARK: ScreenObject methods
    
    @discardableResult
    func isTodoListScreen() -> Self {
        assert(tableView.element, [.exists])
        return self
    }
    
    func hasExactlyTwoSections() {
        assert(getSection(section: expectedSectionCount - 1), [.exists])
        assert(getSection(section: expectedSectionCount), [.doesNotExist])
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
    
    // MARK: Private methods
    private func getSection(section: Int) -> XCUIElement {
        tableView.staticTexts.matching(
            identifier: AccessibilityIdentifier.sectionLabel(section: section).description
        ).element
    }
    
    private func getSectionTitles(count: Int) -> [String] {
        return (0..<count).map { getSection(section: $0).label }
    }
}


