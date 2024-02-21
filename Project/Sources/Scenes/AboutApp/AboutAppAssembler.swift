//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
import MarkdownPackage

enum AboutAppAssemblerError: Error {
	case couldNotFindUrl
}

final class AboutAppAssembler {
	func assembly(
		fileExplorer: IFileExplorer,
		lexer: Lexer,
		parser: Parser
	) throws -> AboutAppViewController {
		let viewController = AboutAppViewController()
		guard let assetsUrl = Bundle.main.resourceURL?.appendingPathComponent(L10n.FileBrowser.baseAssetsPath) else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		// TODO: change back to about
		let aboutFile = try fileExplorer.getFile(
			withName: "test.md",
			atURL: assetsUrl
		)

		viewController.mdText = try fileExplorer.loadTextFileBody(of: aboutFile)
		viewController.lexer = lexer
		viewController.parser = parser

		return viewController
	}
}
