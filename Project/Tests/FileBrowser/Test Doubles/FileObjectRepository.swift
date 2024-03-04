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
	static var stubFileIetms = [makeStubFolder(), makeStubMdFile(), makeStubTxtFile()]

	private static func makeStubFolder() -> File? {
		guard let assetsFolderUrl = Endpoints.assets else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}

	private static func makeStubMdFile() -> File? {
		guard let assetsFolderUrl = Endpoints.aboutMd else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}

	private static func makeStubTxtFile() -> File? {
		guard let assetsFolderUrl = Endpoints.testTxt else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}
}
