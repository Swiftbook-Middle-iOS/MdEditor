//
//  FileBrowserViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IFileBrowserViewController: AnyObject {
	func render(viewModel: FileBrowserModel.ViewModel)
}

class FileBrowserViewController: UITableViewController {

	// MARK: Dependencies
	var interactor: IFileBrowserInteractor?

	// MARK: Private properties
	private var viewModel = FileBrowserModel.ViewModel(items: [])

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(true)
		interactor?.fetchData()
	}
}

// MARK: UITableViewController
extension FileBrowserViewController {
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewModel.items.count
	}

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let object = viewModel.items[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
		configureCell(cell, with: object)

		return cell
	}

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		interactor?.didSelectItem(at: indexPath.row)
	}
}

// MARK: UI Setup
private extension FileBrowserViewController {
	func setupUI() {
		view.backgroundColor = Theme.white
		title = L10n.FileBrowser.title
		self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
	}

	func configureCell(_ cell: UITableViewCell, with object: FileBrowserModel.ViewModel.ItemModel) {
		var contentConfiguration = cell.defaultContentConfiguration()
		switch object {
		case .file(let fileModel):
			contentConfiguration.text = fileModel.title
			contentConfiguration.image = UIImage(systemName: "doc.richtext")
		case .dir(let dirModel):
			contentConfiguration.text = dirModel.title
			contentConfiguration.image = UIImage(systemName: "folder")
		}
		cell.contentConfiguration = contentConfiguration
	}
}

// MARK: IFileBrowserViewController
extension FileBrowserViewController: IFileBrowserViewController {
	func render(viewModel: FileBrowserModel.ViewModel) {
		self.viewModel = viewModel
		tableView.reloadData()
	}
}
