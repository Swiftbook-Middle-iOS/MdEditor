//
//  TodoListUITest.swift
//  MdEditorUITests
//
//  Created by Aleksandr Mamlygo on 27.01.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
import XCTest

final class TodoListUITest: XCTestCase {
	
	var todoListScreen: TodoListScreenObject!
	private let app = XCUIApplication()
	
	override func setUp() async throws {
		app.launchArguments = [
			CommandLineArguments.skipLogin.rawValue,
			CommandLineArguments.enableTesting.rawValue
		]
		todoListScreen = TodoListScreenObject(app: app)
	}
	
	func test_initialTasks_mustBeValid() {
		app.launch()
		
		todoListScreen
			.isTodoListScreen()
			.hasExpectedCountOfChecked(1)
			.hasExpectedCountOfUnchecked(4)
			.checkCellTitle(section: 0, index: 0, expectedTitle: L10n.StubTasks.doHomework)
			.checkCellTitle(section: 0, index: 1, expectedTitle: L10n.StubTasks.goShopping)
			.checkCellTitle(section: 0, index: 2, expectedTitle: L10n.StubTasks.writeTasks)
			.checkCellTitle(section: 0, index: 3, expectedTitle: L10n.StubTasks.solve)
			.checkCellTitle(section: 1, index: 0, expectedTitle: L10n.StubTasks.doWorkout)
	}
	
	func test_sectionTitles_mustBeValid() {
		app.launch()
		
		todoListScreen
			.isTodoListScreen()
			.checkSectionTitle(index: 0, expectedTitle: L10n.TaskManager.SectionTitles.incomplete)
			.checkSectionTitle(index: 1, expectedTitle: L10n.TaskManager.SectionTitles.complete)
	}
	
	func test_completeTask_mustBeValid() {
		app.launch()
		
		todoListScreen
			.isTodoListScreen()
			.tapCell(section: 0, index: 0)
			.hasExpectedCountOfChecked(2)
			.hasExpectedCountOfUnchecked(3)
			.checkCellTitle(section: 0, index: 0, expectedTitle: L10n.StubTasks.goShopping)
			.checkCellTitle(section: 0, index: 1, expectedTitle: L10n.StubTasks.writeTasks)
			.checkCellTitle(section: 0, index: 2, expectedTitle: L10n.StubTasks.solve)
			.checkCellTitle(section: 1, index: 0, expectedTitle: L10n.StubTasks.doHomework)
			.checkCellTitle(section: 1, index: 1, expectedTitle: L10n.StubTasks.doWorkout)
	}

	func test_undoTask_mustBeValid() {
		app.launch()

		todoListScreen
			.isTodoListScreen()
			.tapCell(section: 1, index: 0)
			.hasExpectedCountOfChecked(0)
			.hasExpectedCountOfUnchecked(5)
			.checkCellTitle(section: 0, index: 0, expectedTitle: L10n.StubTasks.doHomework)
			.checkCellTitle(section: 0, index: 1, expectedTitle: L10n.StubTasks.goShopping)
			.checkCellTitle(section: 0, index: 2, expectedTitle: L10n.StubTasks.writeTasks)
			.checkCellTitle(section: 0, index: 3, expectedTitle: L10n.StubTasks.doWorkout)
			.checkCellTitle(section: 0, index: 4, expectedTitle: L10n.StubTasks.solve)
	}
}
