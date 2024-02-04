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
		checkTitle(contains: L10n.TodoList.title)
		return self
	}

	@discardableResult
	func checkCellTitle(section: Int, index: Int, expectedTitle: String) -> Self {
		let cell = getCell(section: section, index: index)
		assert(cell, [.exists])

		let titleLabel = cell.staticTexts.firstMatch.label
		let contains = titleLabel.contains(expectedTitle)

		XCTAssertTrue(contains, "Название ячейки \(titleLabel) не содержит ожидаемое значение \(expectedTitle)")
		return self
	}

	@discardableResult
	func hasExpectedCountOfChecked(_ count: Int) -> Self {
		assert(tableView.element, [.exists])
		let selected = tableView.element.children(matching: .cell).allElementsBoundByIndex.filter { $0.isSelected }
		
		XCTAssertEqual(selected.count, count, "Количество завершенных задач не соответствует ожидаемому")

		return self
	}

	func hasExpectedCountOfUnchecked(_ count: Int) -> Self {
		assert(tableView.element, [.exists])
		let selected = tableView.element.children(matching: .cell).allElementsBoundByIndex.filter { !$0.isSelected }

		XCTAssertEqual(selected.count, count, "Количество завершенных задач не соответствует ожидаемому")

		return self
	}

	@discardableResult
	func checkSectionTitle(index: Int, expectedTitle: String) -> Self {
		let section = getSection(at: index)
		XCTAssertEqual(section.label, expectedTitle, "Заголовок секции \(index) должен быть \(expectedTitle)")

		return self
	}

	@discardableResult
	func tapCell(section: Int, index: Int) -> Self {
		let cell = getCell(section: section, index: index)
		assert(cell, [.exists])
		cell.tap()

		return self
	}
	
	// MARK: Private methods
	private func getSection(at index: Int) -> XCUIElement {
		tableView.otherElements[AccessibilityIdentifier.section(section: index).description]
	}
	
	private func getCell(section: Int, index: Int) -> XCUIElement {
		tableView.cells.element(matching: .cell, identifier: AccessibilityIdentifier.cell(section: section, index: index).description)
	}
}
