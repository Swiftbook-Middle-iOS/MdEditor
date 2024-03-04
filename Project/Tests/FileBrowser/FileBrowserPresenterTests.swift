//
//  FileBrowserPresenterTests.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import XCTest
@testable import MdEditor

final class FileBrowserPresenterTests: XCTestCase {

	private var viewController: FileBrowserViewControllerSpy!
	private var stubFileItems = FileObjectRepository.stubFileIetms

	override func setUp() {
		viewController = FileBrowserViewControllerSpy()
	}

	func test_present_withDefaultTitle_mustBeCorrect() {
		let sut = makeSut()
		let response = FileBrowserModel.Response(files: [], currentPath: URL(fileURLWithPath: "/"))

		sut.present(response: response)

		XCTAssertTrue(viewController.didCallRender, "Не вызван viewController.render(:)")
		XCTAssertEqual(viewController.receivedViewModel.title, L10n.FileBrowser.defaultTitle, "Ошибка в title в модели данных")
	}

	func test_present_withTitleFromPath_mustBeCorrect() {
		let sut = makeSut()
		let filePath = "/project/sources/about.md"
		let expectedName = "about.md"
		let response = FileBrowserModel.Response(files: [], currentPath: URL(fileURLWithPath: filePath))

		sut.present(response: response)

		XCTAssertTrue(viewController.didCallRender, "Не вызван viewController.render(:)")
		XCTAssertEqual(viewController.receivedViewModel.title, expectedName, "Ошибка в title в модели данных")
	}

	func test_present_withMappedFiles_mustBeCorrect() {
		let sut = makeSut()
		let response = FileBrowserModel.Response(files: stubFileItems.compactMap {$0}, currentPath: URL(fileURLWithPath: "/"))

		sut.present(response: response)
		let fileCount = viewController.receivedViewModel.items.filter {
			 if case .file(_) = $0 { return true }
			 return false
		 }.count
		 let dirCount = viewController.receivedViewModel.items.filter {
			 if case .dir(_) = $0 { return true }
			 return false
		 }.count

		XCTAssertTrue(viewController.didCallRender, "Не вызван viewController.render(:)")
		XCTAssertEqual(stubFileItems.count, viewController.receivedViewModel.items.count, "Ошибка в модели данных, не все файлы переданы во ViewModel")
		XCTAssertEqual(fileCount, 2, "Ошибка в модели данных, должен быть только 1 файл")
		XCTAssertEqual(dirCount, 1, "Ошибка в модели данных, должна быть только 1 директория")
	}
}

private extension FileBrowserPresenterTests {
	func makeSut() -> FileBrowserPresenter {
		FileBrowserPresenter(viewController: viewController)
	}
}
