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
	case notATextFile
}

protocol IFileExplorer {
	var files: [File] { get }
	func scan(path: URL) throws
	func getFile(withName name: String, atURL: URL) throws -> File
	func loadTextFileBody(of file: File) throws -> String
}

class File {
	enum FileType {
		case file
		case dir
	}

	var name = ""
	var path: URL?
	var fullPath: URL?
	var size: UInt64 = 0
	var type: FileType = .file
	var creationDate = Date()
	var modificationDate = Date()
	var fullname: String {
		guard let fullPath = fullPath else { return "" }
		return fullPath.absoluteString
	}
	var ext: String {
		if type == .file {
			return String(describing: name.split(separator: ".").last ?? "")
		}
		return ""
	}

	// MARK: Private methods
	private func getFormattedSize(with size: UInt64) -> String {
		var convertedValue = Double(size)
		var multiplyFactor = 0
		let tokens = ["bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"]
		while convertedValue > 1024 {
			convertedValue /= 1024
			multiplyFactor += 1
		}
		return String(format: "%4.2f %@", convertedValue, tokens[multiplyFactor])
	}

	private func getFormattedSize() -> String {
		return getFormattedSize(with: size)
	}
}

extension File: CustomStringConvertible {
	var description: String {
		let formattedSize = getFormattedSize()
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy.MM.dd HH:mm:ss"

		if type == .dir {
			return "\(dateFormatter.string(from: modificationDate)) | <dir>"
		} else {
			return "\"\(ext)\" – \(dateFormatter.string(from: modificationDate)) | \(formattedSize)"
		}
	}
}

class FileExplorer: IFileExplorer {
	var files = [File]()

	func scan(path: URL) throws {
		let fileManager = FileManager.default
		files.removeAll()

		var onlyFiles = [File]()
		var onlyFolders = [File]()

		let items = try fileManager.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
		for item in items {
			let file = try getFile(withName: item.lastPathComponent, atURL: item.deletingLastPathComponent())
			if file.type == .dir {
				onlyFolders.append(file)
			} else {
				onlyFiles.append(file)
			}
		}

		files.append(contentsOf: onlyFolders)
		files.append(contentsOf: onlyFiles)
	}

	func loadTextFileBody(of file: File) throws -> String {
		let textFileExts = ["md", "txt"]
		guard textFileExts.contains(file.ext) else { throw FileExplorerError.notATextFile }

		var text = ""
		guard let fullPath = file.fullPath else { return text }
		text = try String(contentsOf: fullPath, encoding: String.Encoding.utf8)

		return text
	}

	func getFile(withName name: String, atURL: URL) throws -> File {
		let fileManager = FileManager.default
		let fileURL = atURL.appendingPathComponent(name)

		let attr = try fileManager.attributesOfItem(atPath: fileURL.path)

		let file = File()
		file.name = name
		file.path = atURL
		file.fullPath = fileURL
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
