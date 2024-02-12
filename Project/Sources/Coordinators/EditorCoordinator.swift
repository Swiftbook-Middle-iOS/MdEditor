//
//  EditorCoordinator.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IEditorCoordinator: ICoordinator {
}

class EditorCoordinator: IEditorCoordinator {
	// MARK: Dependencies
	var navigationController: UINavigationController
	var fileExplorer: IFileExplorer
	var markdownConverter: IMarkdownToHtmlConverter

	// MARK: Initialization
	init(
		navigationController: UINavigationController,
		fileExplorer: IFileExplorer,
		markdownConverter: IMarkdownToHtmlConverter
	) {
		self.navigationController = navigationController
		self.fileExplorer = fileExplorer
		self.markdownConverter = markdownConverter
	}

	// MARK: Public functions
	func start() {
		let openFileClosure: () -> Void = { [weak self] in
			self?.openRootBrowserScreen()
		}

		let aboutAppClosure: () -> Void = { [weak self] in
			self?.openAboutAppScreen()
		}

		let viewController = EditorHomeAssembly().assembly(
			openFileClosure: openFileClosure,
			aboutAppClosure: aboutAppClosure
		)
		navigationController.setViewControllers([viewController], animated: true)
	}

	// MARK: Private functions
	private func openRootBrowserScreen() {
		navigationController.pushViewController(
			FileBrowserAssembler().rootAssembly { [weak self] newPath in
				self?.openBrowserScreen(at: newPath)
			},
			animated: true
		)
	}

	private func openBrowserScreen(at filePath: URL) {
		let newDirClosure: (URL) -> Void = { [weak self] newPath in
			self?.openBrowserScreen(at: newPath)
		}

		let errorClosure: () -> Void = { [weak self] in
			self?.showError(message: L10n.FileBrowser.accessError)
		}

		navigationController.pushViewController(
			FileBrowserAssembler().assembly(
				fileExplorer: fileExplorer,
				currentPath: filePath,
				newDirClosure: newDirClosure,
				errorClosure: errorClosure
			),
			animated: true
		)
	}

	private func openAboutAppScreen() {
		let viewController: AboutAppViewController
		do {
			viewController = try AboutAppAssembler().assembly(fileExplorer: fileExplorer, markdownConverter: markdownConverter)
		} catch AboutAppAssemblerError.couldNotFindUrl {
			showError(message: L10n.FileBrowser.invalidAssetsUrlError)
			return
		} catch {
			showError(message: L10n.FileBrowser.loadError(L10n.AboutApp.aboutFileName, L10n.FileBrowser.baseAssetsPath))
			return
		}
		navigationController.pushViewController(viewController, animated: true)
	}

	private func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(
			title: L10n.Error.text,
			message: message,
			preferredStyle: UIAlertController.Style.alert
		)
		let action = UIAlertAction(title: L10n.Ok.text, style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
