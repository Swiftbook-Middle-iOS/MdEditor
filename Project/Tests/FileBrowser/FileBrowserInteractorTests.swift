//
//  FileBrowserInteractorTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class FileBrowserInteractorTests: XCTestCase {

	private var presenter: FileBrowserPresenterSpy!
	private var fileExplorer: FileExplorerMock!
	private let currentPath = URL(fileURLWithPath: NSTemporaryDirectory())

	override func setUp() {
		super.setUp()
		presenter = FileBrowserPresenterSpy()
		fileExplorer = FileExplorerMock()
	}

	func test_fetchData_withValidURL_mustBeSuccess() {
		let sut = makeSut(newDirClosure: { _ in })

		sut.fetchData()

		XCTAssertEqual(currentPath, fileExplorer.didScanPath, "File explorer не осуществил скнирование ожидаемой директории")
		XCTAssertTrue(presenter.didCallPresent, "Не вызван presenter.present(:)")
	}

	func test_fetchData_withError_mustBeCorrect() {
		let expectation = expectation(description: "Обработана ошибка при сканировании директории")
		let sut = makeSutWithError {
			expectation.fulfill()
		}

		sut.fetchData()

		waitForExpectations(timeout: 0.1) { error in
			XCTAssertNil(error, "Замыкание errorClosure не было вызвано")
		}
		XCTAssertFalse(presenter.didCallPresent, "Presenter.present(:) не должен быть вызван при ошибке FileExplorer")
	}

	func test_didSelectItem_fileSelected_mustBeCorrect() {
		var newDirClosureCalled = false
		let sut = makeSut(newDirClosure: { _ in newDirClosureCalled = true })
		sut.fetchData()

		sut.didSelectItem(at: 1)

		XCTAssertFalse(newDirClosureCalled, "Замыкание newDirClosure не должно вызываться при выборе файла")
	}

	func test_didSelectItem_folderSelected_mustBeCorrect() {
		var newDirClosureCalled = false
		let sut = makeSut(newDirClosure: { _ in newDirClosureCalled = true })
		sut.fetchData()

		sut.didSelectItem(at: 0)

		XCTAssertTrue(newDirClosureCalled, "Замыкание newDirClosure должно вызываться при выборе новой директории")
	}
}

private extension FileBrowserInteractorTests {
	func makeSut(newDirClosure: @escaping ((URL) -> Void)) -> FileBrowserInteractor {
		FileBrowserInteractor(
			fileExplorer: fileExplorer,
			currentPath: currentPath,
			presenter: presenter,
			newDirClosure: newDirClosure
		)
	}

	func makeSutWithError(errorClosure: (() -> Void)?) -> FileBrowserInteractor {
		fileExplorer.shouldThrowError = true

		return FileBrowserInteractor(
			fileExplorer: fileExplorer,
			currentPath: currentPath,
			presenter: presenter,
			newDirClosure: { _ in },
			errorClosure: errorClosure
		)
	}
}
