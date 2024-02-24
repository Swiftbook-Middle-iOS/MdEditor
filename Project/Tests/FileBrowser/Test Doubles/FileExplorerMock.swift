//
//  MockFileExplorer.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

enum MockFileExplorerError: Error {
	case scanFailed
}

final class FileExplorerMock: IFileExplorer {
	private var stubItems = FileObjectRepository.stubFileIetms

	var files = [MdEditor.File]()
	var didGetFilesFromPath: URL?
	var shouldThrowError = false

	func contentsOfFolder(at url: URL) -> Result<[MdEditor.File], Error> {
		if shouldThrowError {
			return .failure(MockFileExplorerError.scanFailed)
		}
		stubItems.forEach { files.append($0!) }
		didGetFilesFromPath = url
		return .success(files)
	}

	func createFolder(at url: URL, withName name: String) -> Result<MdEditor.File, Error> {
		.failure(NSError())
	}

	func createNewFile(at url: URL, fileName: String) -> Result<MdEditor.File, Error> {
		.failure(NSError())
	}
}
