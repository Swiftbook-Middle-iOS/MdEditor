//
//  FileManagerCoordinator.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IFileBrowserCoordinator: ICoordinator {
	var finishFlow: (() -> Void)? { get set }
}

class FileBrowserCoordinator: NSObject, IFileBrowserCoordinator {

	// MARK: Dependencies
	private let navigationController: UINavigationController
	private var topViewController: UIViewController?
	private var fileExplorer: IFileExplorer

	// MARK: Internal properties
	var finishFlow: (() -> Void)?

	init(navigationController: UINavigationController, topViewController: UIViewController?, fileExplorer: IFileExplorer) {
		self.navigationController = navigationController
		self.topViewController = topViewController
		self.fileExplorer = fileExplorer

		super.init()

		navigationController.delegate = self
	}

	func start() {
		showFileManagerScene(for: nil)
	}

	func showFileManagerScene(for file: File?) {
		let (viewController, interactor) = FileBrowserAssembler().assembly(
			fileExplorer: fileExplorer,
			currentPath: file?.url
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
	func showError() {
		return
	}

	func openFolder(url: URL) {
		switch File.parse(url: url) {
		case .success(let url):
			showFileManagerScene(for: url)
		case .failure:
			showError()
		}
	}
}
