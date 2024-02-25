//
//  FileBrowserInteractor.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

/// Протокол для FileBrowserInteractor
protocol IFileBrowserInteractor {
	/// Метод для первичного сканирования директории и получения файлов
	func fetchData()
	/// Метод, вызываемый при выборе файла/директории
	func didSelectItem(at index: Int)
}

protocol IFileBrowserDelegate: AnyObject {
	func showError()
	func openFolder(url: URL)
}

/// Имплементация FileBrowserInteractor для просмотра файлов в одной конкретной директории
/// - Parameters:
///     - fileExplorer: Объект, подписанный под`IFileExplorer`, необходим для сканирования пути и 
///       получения объектов `File`
///     - currentPath: URL директории, который будет сканироваться при поиске файлов
///     - presenter: Объект, подписанный под `IFileBrowserPresenter` для презентации полученных данных
///     - newDirClosure: Замыкание для вызова при выборе новой диретории, в которое передается  ее URL
///     - errorClosure: Опциональное замыкание для вызова при ошибке во время сканирования директории
final class FileBrowserInteractor: IFileBrowserInteractor {

	// MARK: Dependencies
	private var fileExplorer: IFileExplorer
	private var currentPath: URL?
	private var presenter: IFileBrowserPresenter

	weak var delegate: IFileBrowserDelegate?

	// MARK: Private properties
	private var currentFiles: [File] = []

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentPath: URL?,
		presenter: IFileBrowserPresenter
	) {
		self.fileExplorer = fileExplorer
		self.currentPath = currentPath
		self.presenter = presenter
	}

	// MARK: Public methods
	func fetchData() {
		if let currentPath = currentPath {
			do {
				let filesResult = fileExplorer.contentsOfFolder(at: currentPath)
				switch filesResult {
				case .success(let files):
					currentFiles = files
					presenter.present(response: FileBrowserModel.Response(files: currentFiles, currentPath: currentPath))
				case .failure(let error):
					throw error
				}
			} catch {
				delegate?.showError()
			}
		} else {
			currentFiles = [makeFileForAssetsFolder(), makeFileForDocumentsFolder()].compactMap { $0 }
			presenter.present(response: FileBrowserModel.Response(files: currentFiles, currentPath: nil))
		}
	}

	func didSelectItem(at index: Int) {
		let item = currentFiles[index]
		if let currentPath = currentPath, item.isFolder {
			let newURL = currentPath.appendingPathComponent(item.name)
			delegate?.openFolder(url: newURL)
		} else if item.isFolder {
			delegate?.openFolder(url: item.url)
		}
	}

	// MARK: Private methods
	private func makeFileForAssetsFolder() -> File? {
		guard let assetsFolderUrl = Bundle.main.resourceURL?.appendingPathComponent(Endpoints.baseAssetsPath.rawValue) else {
			return nil
		}
		switch File.parse(url: assetsFolderUrl) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}

	private func makeFileForDocumentsFolder() -> File? {
		guard let documentsURL = try? FileManager.default.url(
			for: .documentDirectory,
			in: .userDomainMask,
			appropriateFor: nil,
			create: false
		) else {
			return nil
		}

		switch File.parse(url: documentsURL) {
		case .success(let folder):
			return folder
		case .failure:
			return nil
		}
	}
}
