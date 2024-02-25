//
//  EditorHomePresenter.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

protocol IEditorHomePresenter {
	func present(response: EditorHomeModel.Response)
}

final class EditorHomePresenter: IEditorHomePresenter {
	weak var view: IEditorHomeView?

	init(view: IEditorHomeView?) {
		self.view = view
	}

	func present(response: EditorHomeModel.Response) {
		let recentFilesModels = response.recentFiles.map { recentFile in
			EditorHomeModel.ViewModel.RecentFile(
				previewText: recentFile.previewText,
				fileName: recentFile.url?.lastPathComponent ?? ""
			)
		}

		view?.render(viewModel: EditorHomeModel.ViewModel(recentFiles: recentFilesModels))
	}
}
