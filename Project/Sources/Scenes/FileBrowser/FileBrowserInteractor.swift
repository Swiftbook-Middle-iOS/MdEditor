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
	func openFolder(at file: File)
	func openFile(at location: URL)
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
	private var currentFile: File?
	private var presenter: IFileBrowserPresenter

	weak var delegate: IFileBrowserDelegate?

	// MARK: Private properties
	private var currentFiles: [File] = []

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentFile: File?,
		presenter: IFileBrowserPresenter
	) {
		self.fileExplorer = fileExplorer
		self.currentFile = currentFile
		self.presenter = presenter
	}

	// MARK: Public methods
	func fetchData() {
		if let currentFile = currentFile {
			let filesResult = fileExplorer.contentsOfFolder(at: currentFile.url)
				switch filesResult {
				case .success(let files):
					currentFiles = files
					presenter.present(response: FileBrowserModel.Response(files: currentFiles, currentPath: currentFile.url))
				case .failure:
					break
				}
		} else {
			currentFiles = [makeFileForAssetsFolder(), makeFileForDocumentsFolder()].compactMap { $0 }
			presenter.present(response: FileBrowserModel.Response(files: currentFiles, currentPath: nil))
		}
	}

	func didSelectItem(at index: Int) {
		let item = currentFiles[index]
		if item.isFolder {
			delegate?.openFolder(at: item)
		} else if item.ext == "md" {
			delegate?.openFile(at: item.url)
		}
	}

	// MARK: Private methods
	private func makeFileForAssetsFolder() -> File? {
		guard let assetsFolderUrl = Endpoints.assets else {
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
