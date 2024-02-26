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

	func assembly() throws -> UIViewController {

		guard let assetsUrl = Endpoints.assets else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == "test.md"
			}

			let fileContent = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8)
			let text = MarkdownToHtmlConverter().convert(markdownText: fileContent ?? "")

//			return AboutAppTextViewController(attributedText: text.joined())
			return AboutAppViewController(htmlText: text)
		case .failure(let error):
			throw error
		}
	}

	func pdfAssembly(markdownTextFileName: String, pdfAuthor: String, pdfTitle: String) throws -> UIViewController {
		guard let assetsUrl = Endpoints.assets else {
			throw AboutAppAssemblerError.couldNotFindUrl
		}

		switch fileExplorer.contentsOfFolder(at: assetsUrl) {
		case .success(let files):
			let file = files.first { file in
				file.name == markdownTextFileName
			}

			let text = String(data: file?.contentOfFile() ?? Data(), encoding: .utf8) ?? ""

			let data = MarkdownToPdfConverter().convert(markdownText: text, pdfAuthor: pdfAuthor, pdfTitle: pdfTitle)

			return PDFViewController(data: data)
		case .failure(let error):
			throw error
		}
	}
}
