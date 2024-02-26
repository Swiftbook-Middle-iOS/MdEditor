//
//  Endpoints.swift
//  MdEditor
//
//  Created by Александр Мамлыго on /242/2567 BE.
//  Copyright © 2567 BE Swiftbook-Middle-iOS. All rights reserved.
//

import Foundation

enum DefaultFileNames: String {
	case baseAssetsPath = "Assets"
	case aboutFileName = "Assets/about.md"
	case testFileName = "Assets/test.md"
}

enum Endpoints {
	static var assets = Bundle.main.resourceURL?.appendingPathComponent(DefaultFileNames.baseAssetsPath.rawValue)
	static var testMd = Bundle.main.resourceURL?.appendingPathComponent(DefaultFileNames.testFileName.rawValue)
	static var aboutMd = Bundle.main.resourceURL?.appendingPathComponent(DefaultFileNames.aboutFileName.rawValue)
}
