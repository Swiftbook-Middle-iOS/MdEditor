//
//  EditorHomeInteractorTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 04.03.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class EditorHomeInteractorTests: XCTestCase {

	private var presenter: EditorHomePresenterSpy!
	private var delegate: MainMenuDelegateSpy!

	override func setUp() {
		presenter = EditorHomePresenterSpy()
		delegate = MainMenuDelegateSpy()
	}

	func test_fetchData_mustBeCorrect() {
		let sut = makeSut()

		sut.fetchData()

		XCTAssertTrue(presenter.didCallPresent, "Не вызван метод present у Presenter")
		XCTAssertFalse(presenter.receivedRecentFiles.isEmpty, "В Presenter передано 0 недавних файлов")
	}

	func test_menuItemSelected_openFile_mustBeCorrect() {
		let sut = makeSut()

		sut.menuItemSelected(item: EditorHomeModel.Request.MenuItemSelected.openFile)

		XCTAssertTrue(delegate.didCallOpenFileBrowser, "Не вызван метод делегата openFileBrowser")
	}

	func test_menuItemSelected_aboutApp_mustBeCorrect() {
		let sut = makeSut()

		sut.menuItemSelected(item: EditorHomeModel.Request.MenuItemSelected.aboutApp)

		XCTAssertTrue(delegate.didCallShowAbout, "Не вызван метод делегата showAbout")
	}

}

private extension EditorHomeInteractorTests {
	func makeSut() -> EditorHomeInteractor {
		let interactor = EditorHomeInteractor(recentFileManager: StubRecentFileManager(), presenter: presenter)
		interactor.delegate = delegate
		return interactor
	}
}
