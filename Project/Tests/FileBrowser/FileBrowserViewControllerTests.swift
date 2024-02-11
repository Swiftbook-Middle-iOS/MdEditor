//
//  FileBrowserViewControllerTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class FileBrowserViewControllerTests: XCTestCase {

	// MARK: Private properties
	private var interactor: FileBrowserInteractorSpy!
	private var window: UIWindow!
	private var sut: FileBrowserViewController!

	// MARK: Life cycle

	override func setUp() {
		super.setUp()

		sut = FileBrowserViewController()
		interactor = FileBrowserInteractorSpy()
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
	func test_viewWillAppear_shouldCallFetchData() {
		sut.viewWillAppear(false)

		XCTAssertTrue(interactor.didCallFetchData, "Не был вызван метод .fetchData(:)")
	}
}
