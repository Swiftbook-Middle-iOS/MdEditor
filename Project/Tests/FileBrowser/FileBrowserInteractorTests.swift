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
	private var delegate: FileBrowserDelegateSpy!

	override func setUp() {
		super.setUp()
		presenter = FileBrowserPresenterSpy()
		fileExplorer = FileExplorerMock()
		delegate = FileBrowserDelegateSpy()
	}

	func test_fetchData_withNilFile_mustBeCorrect() {
		let sut = makeSutWithNilFile()

		sut.fetchData()

		XCTAssertFalse(presenter.receivedFiles.isEmpty, "Не были сгенерированы файлы для корневой директории")
		XCTAssertTrue(presenter.didCallPresent, "Не вызван presenter.present(:)")
	}

	func test_fetchData_withValidFile_mustBeCorrect() {
		let sut = makeSutWithValidFiles()

		sut?.fetchData()

		XCTAssertNotNil(fileExplorer.didGetFilesFromPath, "Не вызван метод contentsOfFolder(:)")
		XCTAssertTrue(presenter.didCallPresent, "Не вызван presenter.present(:)")
	}

	func test_didSelectItem_folderSelected_mustBeCorrect() {
		let sut = makeSutWithValidFiles()
		sut?.fetchData()

		sut?.didSelectItem(at: 0)

		XCTAssertTrue(delegate.didCallOpenFolder, "Метод openFolder не вызван у делегата при выборе папки")
	}

	func test_didSelectItem_mdFileSelected_mustBeCorrect() {
		let sut = makeSutWithValidFiles()
		sut?.fetchData()

		sut?.didSelectItem(at: 1)

		XCTAssertTrue(delegate.didCallOpenFile, "Метод openFile не вызван у делегата при выборе md файла")
	}

	func test_didSelectItem_nonMdFileSelected_mustBeCorrect() {
		let sut = makeSutWithValidFiles()
		sut?.fetchData()

		sut?.didSelectItem(at: 2)

		XCTAssertFalse(delegate.didCallOpenFile, "Метод openFile вызван у делегата при выборе .txt файла")
	}
}

private extension FileBrowserInteractorTests {
	func makeSutWithNilFile() -> FileBrowserInteractor {
		FileBrowserInteractor(
			fileExplorer: fileExplorer,
			currentFile: nil,
			presenter: presenter
		)
	}

	func makeSutWithValidFiles() -> FileBrowserInteractor? {
		guard let assetsFolderUrl = Endpoints.assets else {
			return nil
		}

		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			let interactor = FileBrowserInteractor(
				fileExplorer: fileExplorer,
				currentFile: folder,
				presenter: presenter
			)
			interactor.delegate = delegate

			return interactor
		case .failure:
			return nil
		}
	}
}
