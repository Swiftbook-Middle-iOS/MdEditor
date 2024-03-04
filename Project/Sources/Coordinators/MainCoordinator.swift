//
//  MainCoordinator.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit
import MarkdownPackage

class MainCoordinator: BaseCoordinator {
	// MARK: Dependencies
	var navigationController: UINavigationController
	var fileExplorer = FileExplorer()
	var recentFileManager = StubRecentFileManager()
	var attributedConverter = AttributedConverter()

	// MARK: Initialization
	init(
		navigationController: UINavigationController
	) {
		self.navigationController = navigationController
	}

	// MARK: Public functions
	override func start() {
		let (viewController, interactor) = EditorHomeAssembly().assembly(recentFileManager: recentFileManager)

		interactor.delegate = self
		navigationController.setViewControllers([viewController], animated: true)
	}

	// MARK: Private functions
	private func openBrowserScreen() {
		let topViewController = navigationController.topViewController

		let coordinator = FileBrowserCoordinator(
			navigationController: navigationController,
			topViewController: topViewController,
			fileExplorer: fileExplorer,
			attributedConverter: attributedConverter
		)

		addDependency(coordinator)

		coordinator.finishFlow = { [weak self, weak coordinator] in
			guard let self = self else { return }
			if let topViewController = topViewController {
				self.navigationController.popToViewController(topViewController, animated: true)
			} else {
				self.navigationController.popToRootViewController(animated: true)
			}

			if let coordinator = coordinator {
				self.removeDependency(coordinator)
			}
		}

		coordinator.start()
	}

	private func openAboutAppScreen() {
		let viewController: UIViewController
		do {
			viewController = try AboutAppAssembler(fileExplorer: fileExplorer).attributedAssembly(converter: attributedConverter)
		} catch AboutAppAssemblerError.couldNotFindUrl {
			showError(message: L10n.FileBrowser.invalidAssetsUrlError)
			return
		} catch {
			showError(message: L10n.FileBrowser.loadError(DefaultFileNames.aboutFileName, DefaultFileNames.baseAssetsPath))
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

extension MainCoordinator: IMainMenuDelegate {
	func openFileBroweser() {
		openBrowserScreen()
	}

	func showAbout() {
		openAboutAppScreen()
	}
}
