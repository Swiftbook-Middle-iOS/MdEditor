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

		guard let assetsUrl = Bundle.main.resourceURL?.appendingPathComponent(Endpoints.baseAssetsPath.rawValue) else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == "test.md"
			}

			let tokens = lexer.tokenize(String(data: file?.contentOfFile() ?? Data(), encoding: .utf8) ?? "")
			let document = parser.parse(tokens: tokens)
			let visitor = HTMLVisitor()

			let text = document.accept(visitor: visitor).joined()

//			return AboutAppTextViewController(attributedText: text.joined())
			return AboutAppViewController(htmlText: text)
		case .failure(let error):
			throw error
		}
	}
}
