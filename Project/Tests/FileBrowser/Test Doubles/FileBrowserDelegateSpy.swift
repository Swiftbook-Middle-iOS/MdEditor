//
//  FileBrowserDelegateSpy.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

class FileBrowserDelegateSpy: IFileBrowserDelegate {
	private(set) var didCallOpenFile = false

	func openFolder(at file: File) {
		didCallOpenFile = true
	}
}
