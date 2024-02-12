//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum AboutAppAssemblerError: Error {
	case couldNotFindUrl
}

final class AboutAppAssembler {
	func assembly(
		fileExplorer: IFileExplorer,
		markdownConverter: IMarkdownToHtmlConverter
	) throws -> AboutAppViewController {
		let viewController = AboutAppViewController()
		guard let assetsUrl = Bundle.main.resourceURL?.appendingPathComponent(L10n.FileBrowser.baseAssetsPath) else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		let aboutFile = try fileExplorer.getFile(
			withName: L10n.AboutApp.aboutFileName,
			atURL: assetsUrl
		)

		viewController.mdText = try aboutFile.loadFileBody()
		viewController.markdownCoverter = markdownConverter
		return viewController
	}
}
