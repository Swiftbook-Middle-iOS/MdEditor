//
//  FileBrowserViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

class FileBrowserViewController: UITableViewController {

	// MARK: Private properties
	private var viewModel = FileBrowserModel.ViewModel(files: [])

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}
}

extension FileBrowserViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.files.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let file = viewModel.files[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: file)

		return cell
	}
}

private extension FileBrowserViewController {
	func setupUI() {
		view.backgroundColor = Theme.white
		title = L10n.FileBrowser.title
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func configureCell(_ cell: UITableViewCell, with file: FileBrowserModel.ViewModel.FileModel) {
		var contentConfiguration = cell.defaultContentConfiguration()
		contentConfiguration.text = file.title
		cell.contentConfiguration = contentConfiguration
	}
}
