//
//  FileObjectRepository.swift
//  MdEditorTests
//
//  Created by Aleksandr Mamlygo on 11.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

final class FileObjectRepository {
	static var stubFileIetms = [makeStubFolder(), makeStubFile()]

	private static func makeStubFolder() -> File {
		let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
		let folderPath = temporaryDirectoryURL.deletingLastPathComponent()

		let stubFolder = File(name: "Folder", path: folderPath, type: .dir, size: 0, creationDate: Date(), modificationDate: Date())

		return stubFolder
	}

	private static func makeStubFile() -> File {
		let temporaryDirectoryURL = URL(fileURLWithPath: NSTemporaryDirectory())
		let filePath = temporaryDirectoryURL.deletingLastPathComponent()

		let stubFile = File(name: "File", path: filePath, type: .file, size: 0, creationDate: Date(), modificationDate: Date())

		return stubFile
	}
}
