//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import MarkdownPackage

protocol IFileBrowserCoordinator: ICoordinator {
	var finishFlow: (() -> Void)? { get set }
}

class FileBrowserCoordinator: NSObject, IFileBrowserCoordinator {

	// MARK: Dependencies
	private let navigationController: UINavigationController
	private var topViewController: UIViewController?
	private var fileExplorer: IFileExplorer
	private var attributedConverter: IAttributedConverter

	// MARK: Internal properties
	var finishFlow: (() -> Void)?

	init(
		navigationController: UINavigationController,
		topViewController: UIViewController?,
		fileExplorer: IFileExplorer,
		attributedConverter: IAttributedConverter
	) {
		self.navigationController = navigationController
		self.topViewController = topViewController
		self.fileExplorer = fileExplorer
		self.attributedConverter = attributedConverter

		super.init()

		navigationController.delegate = self
	}

	func start() {
		showFileManagerScene(for: nil)
	}

	func showFileManagerScene(for file: File?) {
		let (viewController, interactor) = FileBrowserAssembler().assembly(
			fileExplorer: fileExplorer,
			currentFile: file
		)

		interactor.delegate = self

		navigationController.pushViewController(viewController, animated: true)
	}
}

extension FileBrowserCoordinator: UINavigationControllerDelegate {
	func navigationController(
		_ navigationController: UINavigationController,
		didShow viewController: UIViewController,
		animated: Bool
	) {
		if viewController === topViewController {
			finishFlow?()
		}
	}
}

extension FileBrowserCoordinator: IFileBrowserDelegate {
	func openFolder(at file: File) {
		showFileManagerScene(for: file)
	}

	func openFile(at location: URL) {
		if case let .success(file) = File.parse(url: location) {
			let mdText = String(data: file.contentOfFile() ?? Data(), encoding: .utf8) ?? ""
			let converted = attributedConverter.convertMdText(mdText)

			let viewController = AttributedTextViewController(attributedText: converted.joined())
			navigationController.pushViewController(viewController, animated: true)
		}
	}
}
