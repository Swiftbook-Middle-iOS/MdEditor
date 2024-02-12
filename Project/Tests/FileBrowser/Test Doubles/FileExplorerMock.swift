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
	var didScanPath: URL?
	var shouldThrowError = false

	func scan(path: URL) throws {
		if shouldThrowError {
			throw MockFileExplorerError.scanFailed
		}
		stubItems.forEach { files.append($0) }
		didScanPath = path
	}
	
	func getFile(withName name: String, atURL: URL) throws -> MdEditor.File {
		return File()
	}

	func loadTextFileBody(of file: MdEditor.File) throws -> String {
		return ""
	}
}
