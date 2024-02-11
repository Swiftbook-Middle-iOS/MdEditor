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
	private var currentPath: URL
	private var presenter: IFileBrowserPresenter
	private var newDirClosure: (URL) -> Void
	private var errorClosure: (() -> Void)?

	// MARK: Initialization
	init(
		fileExplorer: IFileExplorer,
		currentPath: URL,
		presenter: IFileBrowserPresenter,
		newDirClosure: @escaping (URL) -> Void,
		errorClosure: (() -> Void)? = nil
	) {
		self.fileExplorer = fileExplorer
		self.currentPath = currentPath
		self.presenter = presenter
		self.newDirClosure = newDirClosure
		self.errorClosure = errorClosure
	}

	// MARK: Public methods
	func fetchData() {
		do {
			try fileExplorer.scan(path: currentPath)
			presenter.present(response: FileBrowserModel.Response(files: fileExplorer.files, currentPath: currentPath))
		} catch {
			errorClosure?()
		}
	}

	func didSelectItem(at index: Int) {
		let item = fileExplorer.files[index]
		if item.type == .dir {
			let newURL = currentPath.appendingPathComponent(item.name)
			newDirClosure(newURL)
		}
	}
}
