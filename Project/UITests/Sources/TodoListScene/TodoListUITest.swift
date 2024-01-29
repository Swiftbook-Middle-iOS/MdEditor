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
        app.launchArguments = [CommandLineArguments.skipLogin.rawValue]
        app.launchArguments += ["-AppleLanguages", "(en)"]
        todoListScreen = TodoListScreenObject(app: app)
    }
    
    func test_todoListTaskTitles_shouldExist() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
            .initialCellsHaveTitles()
    }
    
    func test_todoListCheckedTaskCount_initially_shouldBeOne() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
            .hasExpectedCountOfChecked(1)
    }
    
    func test_todoListSectionCount_shouldBeTwo() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
            .hasCorrectSectionCount()
    }
    
    func test_todoListSectionTitles_shouldBeCorrect() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
            .hasCompleteSection()
            .hasIncompleteSection()
    }
    
    func test_changeTaskStatus_shouldBeCorrect() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
            .tapFirstIncompleteTask()
            .completeSectionHasCorrectTaskCountAfterTap()
            .incompleteSectionHasCorrectTaskCountAfterTap()
            .completedSectionHasExpectedTaskTitle()
            .hasExpectedCountOfChecked(2)
    }
}
