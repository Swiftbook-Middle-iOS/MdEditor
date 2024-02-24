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

	private static func makeStubFolder() -> File? {
		guard let assetsFolderUrl = Bundle.main.resourceURL?.appendingPathComponent(L10n.FileBrowser.baseAssetsPath) else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}

	private static func makeStubFile() -> File? {
		guard let assetsFolderUrl = Bundle.main.resourceURL?
			.appendingPathComponent(L10n.FileBrowser.baseAssetsPath)
			.appendingPathComponent("about.md")
		else {
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
