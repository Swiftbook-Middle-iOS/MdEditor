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
		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == "test.md"
			}

			viewController.mdText = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8)
		case .failure(let error):
			throw error
		}

		viewController.lexer = lexer
		viewController.parser = parser

		return viewController
	}
}
