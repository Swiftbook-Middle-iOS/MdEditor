//
//  IShowingError.swift
//  TodoList
//
//  Created by Aleksandr Mamlygo on 09.12.23.
//

import UIKit

protocol IShowingError {
	/// Показ ошибки с сообщением в виде UIAlertController
	func showError(message: String)
}

extension IShowingError where Self: ICoordinator {
	func showError(message: String) {
		let alert: UIAlertController
		alert = UIAlertController(title: "Error", message: message, preferredStyle: UIAlertController.Style.alert)
		let action = UIAlertAction(title: "Ok", style: .default)
		alert.addAction(action)
		navigationController.present(alert, animated: true, completion: nil)
	}
}
