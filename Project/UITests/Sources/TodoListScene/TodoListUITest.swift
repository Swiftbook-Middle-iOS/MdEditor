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
    let app = XCUIApplication()
    
    override func setUp() async throws {
        app.launchArguments = [CommandLineArguments.skipLogin.rawValue]
        todoListScreen = TodoListScreenObject(app: app)
    }
    
    func test_todoList() {
        app.launch()
        
        todoListScreen
            .isTodoListScreen()
    }
}
