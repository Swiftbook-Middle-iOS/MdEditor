//
//  FileBrowserViewController.swift
//  MdEditor
//
//  Created by Aleksandr Mamlygo on 05.02.24.
//  Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
//

import UIKit

class FileBrowserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

private extension FileBrowserViewController {
	func setupUI() {
		view.backgroundColor = Theme.white
		title = "example files"
	}
}
