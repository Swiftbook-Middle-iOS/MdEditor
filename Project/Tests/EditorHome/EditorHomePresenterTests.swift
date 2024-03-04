//
//  EditorHomePresenterTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class EditorHomePresenterTests: XCTestCase {

	private var viewController: EditorHomeViewControllerSpy!
	private var stubRecentFiles = StubRecentFileManager().getRecentFiles()

	override func setUp() {
		viewController = EditorHomeViewControllerSpy()
	}

	func test_present_withStubFiles_mustBeCorrect() {
		let sut = makeSut()

		sut.present(response: EditorHomeModel.Response(recentFiles: stubRecentFiles))

		XCTAssertTrue(viewController.didCallRender, "Не вызван метод render у viewController'a")
		XCTAssertEqual(stubRecentFiles.count, viewController.receivedFiles.count, "Не все модели файлов переданы View")
	}
}

private extension EditorHomePresenterTests {
	func makeSut() -> EditorHomePresenter {
		EditorHomePresenter(view: viewController)
	}
}
