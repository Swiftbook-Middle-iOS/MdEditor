//
//  AboutAppAssembler.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import MarkdownPackage

enum AboutAppAssemblerError: Error {
	case couldNotFindUrl
}

final class AboutAppAssembler {
	private let fileExplorer: IFileExplorer

	init(fileExplorer: IFileExplorer) {
		self.fileExplorer = fileExplorer
	}

	func htmlAssembly(converter: IMarkdownToHtmlConverter) throws -> UIViewController {

		guard let assetsUrl = Endpoints.assets else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == "test.md"
			}

			let fileContent = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8)
			let text = converter.convert(markdownText: fileContent ?? "")

			return AboutAppViewController(htmlText: text)
		case .failure(let error):
			throw error
		}
	}

	func attributedAssembly(converter: IAttributedConverter) throws -> UIViewController {
		guard let assetsUrl = Endpoints.assets else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == "test.md"
			}

			let fileContent = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8)
			let text = converter.convertMdText(fileContent ?? "")

			return TextViewController(attributedText: text.joined())
		case .failure(let error):
			throw error
		}
	}

	func pdfAssembly(
		converter: IMarkdownToPdfConverter,
		markdownTextFileName: String,
		pdfAuthor: String,
		pdfTitle: String
	) throws -> UIViewController {
		guard let assetsUrl = Endpoints.assets else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == markdownTextFileName
			}

			let text = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8) ?? ""

			let data = converter.convert(markdownText: text, pdfAuthor: pdfAuthor, pdfTitle: pdfTitle)

			return PDFViewController(data: data)
		case .failure(let error):
			throw error
		}
	}
}
