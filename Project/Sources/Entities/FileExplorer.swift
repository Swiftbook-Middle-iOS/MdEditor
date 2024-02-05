//
//  BadExample.swift
//  MdEditor
//
//  Created by Kirill Leonov on 02.02.2024.
//  Copyright © 2024 leonovka.SwiftBook. All rights reserved.
//

import Foundation

enum FileExplorerError: Error {
	case resourcePathNotFound
	case noAccessToDirectory
	case couldNotWriteToFile
}

protocol IFileExplorer {
	var files: [File] { get }
	func scan(path: String) throws
	func getFile(withName name: String, atPath: String) throws -> File
}

class File {
	enum FileType {
		case file
		case dir
	}

	var name = ""
	var path = ""
	var fullPath = ""
	var ext = ""
	var size: UInt64 = 0
	var type: FileType = .file
	var creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		"\(path)/\(name)"
	}

	func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}

	func getFormattedAttributes() -> String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if type == .dir {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}

	func loadFileBody() throws -> String {
		var text = ""
		guard let resourcePath = Bundle.main.resourcePath else { return text }
		let fullPath = resourcePath + "/\(path)/\(name)"
		text = try String(contentsOfFile: fullPath, encoding: String.Encoding.utf8)

		return text
	}
}

class FileExplorer: IFileExplorer {
	var files = [File]()

	func scan(path: String) throws {
		let fileManager = FileManager.default
		guard let resourcePath = Bundle.main.resourcePath else { throw FileExplorerError.resourcePathNotFound }
		let fullPath = resourcePath + "/\(path)"
		files.removeAll()

		var onlyFiles = [File]()
		var onlyFolders = [File]()

		let items = try fileManager.contentsOfDirectory(atPath: fullPath)
		for item in items {
			let file = try getFile(withName: item, atPath: path)
			if file.type == .dir {
				onlyFolders.append(file)
			} else {
				onlyFiles.append(file)
			}
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	func getFile(withName name: String, atPath: String) throws -> File {
		let fileManager = FileManager.default
		guard let resourcePath = Bundle.main.resourcePath else { throw FileExplorerError.resourcePathNotFound }
		let fullPath = resourcePath + "/\(atPath)"

		let attr = try fileManager.attributesOfItem(atPath: fullPath + "/" + name)

		let file = File()
		file.name = name
		file.path = atPath
		file.fullPath = fullPath
		if let fileType = attr[FileAttributeKey.type] as? FileAttributeType {
			if fileType == .typeDirectory {
				file.type = .dir
			} else if fileType == .typeRegular {
				file.type = .file
			}
		}
		if let fileSize = attr[FileAttributeKey.size] as? UInt64 {
			file.size = fileSize
		}
		if let creationDate = attr[FileAttributeKey.creationDate] as? Date {
			file.creationDate = creationDate
		}
		if let modificationDate = attr[FileAttributeKey.modificationDate] as? Date {
			file.modificationDate = modificationDate
		}

		if file.type == .dir {
			file.ext = ""
		} else {
			file.ext = String(describing: name.split(separator: ".").last ?? "")
		}

		return file
	}

	static func createFile(withName name: String) throws {
		guard let resourcePath = Bundle.main.resourcePath else { throw FileExplorerError.resourcePathNotFound }
		let fullName = resourcePath + "/\(name)"
		let empty = ""
		try empty.write(toFile: fullName, atomically: false, encoding: .utf8)
	}

	static func createFile2(withName name: String) {
		guard let resourcePath = Bundle.main.resourcePath else { return }
		let fullPath = resourcePath + "/\(name)"
		let data = "Created on \(Date())".data(using: String.Encoding.utf8)
		let fileManager = FileManager.default
		fileManager.createFile(atPath: fullPath, contents: data, attributes: [:])
	}

	/// Создание папки.
	/// - Parameter name: Имя папки.
	static func createFolder(withName name: String) throws {
		guard let resourcePath = Bundle.main.resourcePath else { return }
		let fullPath = resourcePath + "/\(name)"
		let fileManager = FileManager.default
		try fileManager.createDirectory(atPath: fullPath, withIntermediateDirectories: false, attributes: nil)
	}
}