//
//  EditorHomeViewControllerTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class EditorHomeViewControllerTests: XCTestCase {
	
	// MARK: Private properties
	private var interactor: EditorHomeInteractorSpy!
	private var window: UIWindow!
	private var sut: EditorHomeViewController!


	// MARK: Life cycle
	override func setUp() {
		super.setUp()

		sut = EditorHomeViewController()
		interactor = EditorHomeInteractorSpy()
		sut.interactor = interactor
		window = UIWindow()
		window.addSubview(sut.view)
		RunLoop.current.run(until: Date())
	}

	override func tearDown() {
		sut = nil
		interactor = nil
		window = nil

		super.tearDown()
	}

	// MARK: Test methods
	func test_viewDidLoad_shouldCallFetchData() {
		sut.viewDidLoad()

		XCTAssertTrue(interactor.didCallFetchData, "Не был вызван метод .fetchData(:)")
	}

	func test_openDocumentTapped_shouldPassCorrectMenuItem() {
		sut.openDocumentTapped()

		XCTAssertEqual(interactor.recievedMenuItem, EditorHomeModel.Request.MenuItemSelected.openFile, "Некорректно сформирован Request для пункта меню open file")
	}
	func test_aboutAppTapped_shouldPassCorrectMenuItem() {
		sut.aboutAppTapped()

		XCTAssertEqual(interactor.recievedMenuItem, EditorHomeModel.Request.MenuItemSelected.aboutApp, "Некорректно сформирован Request для пункта меню about app")
	}
}
