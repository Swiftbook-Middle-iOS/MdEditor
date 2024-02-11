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
		let stubFolder = File()
		stubFolder.name = "Folder"
		stubFolder.path = URL(fileURLWithPath: NSTemporaryDirectory()).deletingLastPathComponent()
		stubFolder.fullPath = URL(fileURLWithPath: NSTemporaryDirectory()).deletingLastPathComponent()
		stubFolder.type = .dir

		return stubFolder
	}

	private static func makeStubFile() -> File {
		let stubFile = File()
		stubFile.name = "File"
		stubFile.path = URL(fileURLWithPath: NSTemporaryDirectory()).deletingLastPathComponent()
		stubFile.fullPath = URL(fileURLWithPath: NSTemporaryDirectory()).deletingLastPathComponent()
		stubFile.type = .file

		return stubFile
	}
}
