//
//  EditorHomeViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

protocol IEditorHomeView: AnyObject {
	func render(viewModel: EditorHomeModel.ViewModel)
}

final class EditorHomeViewController: UIViewController {

	// MARK: Dependencies
	var interactor: IEditorHomeInteractor?

	// MARK: Private properties
	private var viewModel = EditorHomeModel.ViewModel(recentFiles: [])

	private let coverHeight: CGFloat = 200
	private let coverWidth: CGFloat = 100

	private lazy var collectionViewRecentFiles: UICollectionView = makeCollectionView(
		accessibilityIdentifier: AccessibilityIdentifier.recentFileCollectionView.description
	)

	private lazy var newDocumentButton: UIButton = makeButton(
		imageName: Images.EdtorHome.newDocImageName.rawValue,
		title: L10n.EditorHome.newButtonTitle,
		accessibilityIdentifier: AccessibilityIdentifier.newDocumentButton.description
	)

	private lazy var openFileButton: UIButton = {
		let button = makeButton(
			imageName: Images.EdtorHome.openFileImageName.rawValue,
			title: L10n.EditorHome.openButtonTitle,
			accessibilityIdentifier: AccessibilityIdentifier.openFileButton.description
		)
		button.addTarget(nil, action: #selector(openDocumentTapped), for: .touchUpInside)
		return button
	}()

	private lazy var aboutButton: UIButton = {
		let button = makeButton(
			imageName: Images.EdtorHome.aboutAppImageName.rawValue,
			title: L10n.EditorHome.aboutButtonTitle,
			accessibilityIdentifier: AccessibilityIdentifier.aboutAppButton.description
		)
		button.addTarget(nil, action: #selector(aboutAppTapped), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
		interactor?.fetchData()
	}

	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		layout()
	}

	@objc
	func openDocumentTapped() {
		interactor?.menuItemSelected(item: .openFile)
	}

	@objc
	func aboutAppTapped() {
		interactor?.menuItemSelected(item: .aboutApp)
	}
}

// MARK: Setup UI
private extension EditorHomeViewController {
	func makeCollectionView(accessibilityIdentifier: String) -> UICollectionView {
		let layout = makeFlowLayout()

		let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
		collectionView.isPagingEnabled = true
		collectionView.translatesAutoresizingMaskIntoConstraints = false
		collectionView.backgroundColor = Theme.white
		collectionView.showsHorizontalScrollIndicator = false

		collectionView.accessibilityIdentifier = accessibilityIdentifier
		collectionView.delegate = self
		collectionView.dataSource = self

		return collectionView
	}

	func makeFlowLayout() -> UICollectionViewFlowLayout {
		let layout = UICollectionViewFlowLayout()
		layout.itemSize = CGSize(width: coverWidth, height: coverHeight)
		layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: Sizes.Padding.normal)
		layout.scrollDirection = .horizontal
		layout.minimumLineSpacing = Sizes.Padding.double
		layout.minimumInteritemSpacing = Sizes.Padding.double

		return layout
	}

	func makeButton(imageName: String, title: String, accessibilityIdentifier: String) -> UIButton {
		let button = UIButton()

		button.configuration = .borderless()
		button.configuration?.imagePadding = Sizes.Padding.half

		button.configuration?.baseForegroundColor = Theme.black
		button.configuration?.image = UIImage(systemName: imageName)?.withTintColor(
			Theme.mainColor,
			renderingMode: .alwaysOriginal
		)

		button.configuration?.title = title
		button.contentHorizontalAlignment = .leading
		button.configuration?.contentInsets = .init(
			top: Sizes.Padding.normal,
			leading: Sizes.Padding.half,
			bottom: Sizes.Padding.normal,
			trailing: 0
		)

		button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
		button.titleLabel?.adjustsFontForContentSizeCategory = true

		button.accessibilityIdentifier = accessibilityIdentifier
		button.translatesAutoresizingMaskIntoConstraints = false
		return button
	}

	func setupUI() {
		view.backgroundColor = Theme.white
		title = L10n.EditorHome.title
		navigationController?.navigationBar.prefersLargeTitles = true
		navigationController?.view.backgroundColor = Theme.white

		view.addSubview(newDocumentButton)
		view.addSubview(aboutButton)
		view.addSubview(openFileButton)
		view.addSubview(collectionViewRecentFiles)

		collectionViewRecentFiles.register(
			RecentFileCollectionViewCell.self,
			forCellWithReuseIdentifier: RecentFileCollectionViewCell.reusableIdentifier
		)
	}
}

// MARK: Layout UI
private extension EditorHomeViewController {
	func layout() {
		let constraints = [
			collectionViewRecentFiles.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			collectionViewRecentFiles.leadingAnchor.constraint(equalTo: view.leadingAnchor),
			collectionViewRecentFiles.trailingAnchor.constraint(equalTo: view.trailingAnchor),
			collectionViewRecentFiles.heightAnchor.constraint(equalToConstant: 200),

			newDocumentButton.topAnchor.constraint(
				equalTo: collectionViewRecentFiles.bottomAnchor,
				constant: Sizes.Padding.double
			),
			newDocumentButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			newDocumentButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),

			openFileButton.topAnchor.constraint(equalTo: newDocumentButton.bottomAnchor, constant: Sizes.Padding.normal),
			openFileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			openFileButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal),

			aboutButton.topAnchor.constraint(equalTo: openFileButton.bottomAnchor, constant: Sizes.Padding.normal),
			aboutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Sizes.Padding.normal),
			aboutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Sizes.Padding.normal)
		]

		NSLayoutConstraint.activate(constraints)
	}
}

// MARK: Collection view delegate
extension EditorHomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		viewModel.recentFiles.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(
			withReuseIdentifier: RecentFileCollectionViewCell.reusableIdentifier,
			for: indexPath
		) as! RecentFileCollectionViewCell // swiftlint:disable:this force_cast

		let viewModel = viewModel.recentFiles[indexPath.row]
		cell.configure(fileName: viewModel.fileName, previewText: viewModel.previewText)

		return cell
	}
}

// MARK: IEditorHomeView
extension EditorHomeViewController: IEditorHomeView {
	func render(viewModel: EditorHomeModel.ViewModel) {
		self.viewModel = viewModel
		collectionViewRecentFiles.reloadData()
	}
}
