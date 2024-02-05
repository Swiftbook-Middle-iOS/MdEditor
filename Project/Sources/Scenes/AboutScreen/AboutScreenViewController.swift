//
//  AboutScreenViewController.swift
//  MdEditor
//
//  Created by Александр Касьянов on 05.02.2024.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IAboutScreenViewController: AnyObject {
	func render(viewModel: AboutScreenModel.ViewModel)
}

final class AboutScreenViewController: UIViewController {

	// MARK: Dependencies
	var interactor: AboutScreenInteractor?

	// MARK: Private properties
	private var viewModel = AboutScreenModel.ViewModel(file: File())

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}
}

// MARK: Setup UI
private extension AboutScreenViewController {
	func setupUI() {
		view.backgroundColor = Theme.mainColor
		title = L10n.AboutScreen.title
		navigationController?.navigationBar.prefersLargeTitles = true
	}
}

// MARK: Layout UI
private extension AboutScreenViewController {
	func layout() {

	}
}

// MARK: IFileBrowserViewController
extension AboutScreenViewController: IAboutScreenViewController {
	func render(viewModel: AboutScreenModel.ViewModel) {
		self.viewModel = viewModel
		view.reloadInputViews()
	}
}
