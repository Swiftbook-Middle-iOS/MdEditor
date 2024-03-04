//
//  FileBrowserDelegateSpy.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /252/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation
@testable import MdEditor

class FileBrowserDelegateSpy: IFileBrowserDelegate {
	
	private(set) var didCallOpenFolder = false
	private(set) var didCallOpenFile = false

	func openFolder(at file: File) {
		didCallOpenFolder = true
	}

	func openFile(at location: URL) {
		didCallOpenFile = true
	}
}
