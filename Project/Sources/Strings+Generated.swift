// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum LoginButton {
    /// Localizable.strings
    ///   MdEditor
    /// 
    ///   Created by Aleksandr Mamlygo on 15.01.24.
    ///   Copyright © 2024 Swiftbook-Middle-iOS. All rights reserved.
    internal static let title = L10n.tr("Localizable", "loginButton.title", fallback: "Login")
  }
  internal enum LoginTextField {
    /// Login
    internal static let placeholder = L10n.tr("Localizable", "loginTextField.placeholder", fallback: "Login")
  }
  internal enum LoginView {
    /// Authorization
    internal static let title = L10n.tr("Localizable", "loginView.title", fallback: "Authorization")
  }
  internal enum PassTextField {
    /// Password
    internal static let placeholder = L10n.tr("Localizable", "passTextField.placeholder", fallback: "Password")
  }
  internal enum StubTasks {
    /// Do homework
    internal static let title0 = L10n.tr("Localizable", "stubTasks.title0", fallback: "Do homework")
    /// Do Workout
    internal static let title1 = L10n.tr("Localizable", "stubTasks.title1", fallback: "Do Workout")
    /// Write new tasks
    internal static let title2 = L10n.tr("Localizable", "stubTasks.title2", fallback: "Write new tasks")
    /// Solve 3 algorithms
    internal static let title3 = L10n.tr("Localizable", "stubTasks.title3", fallback: "Solve 3 algorithms")
    /// Go shopping
    internal static let title4 = L10n.tr("Localizable", "stubTasks.title4", fallback: "Go shopping")
  }
  internal enum TaskManager {
    internal enum SectionTitles {
      /// All
      internal static let allTasks = L10n.tr("Localizable", "taskManager.sectionTitles.allTasks", fallback: "All")
      /// Complete
      internal static let complete = L10n.tr("Localizable", "taskManager.sectionTitles.complete", fallback: "Complete")
      /// Important
      internal static let important = L10n.tr("Localizable", "taskManager.sectionTitles.important", fallback: "Important")
      /// Uncompleted
      internal static let incomplete = L10n.tr("Localizable", "taskManager.sectionTitles.incomplete", fallback: "Uncompleted")
      /// Regular
      internal static let regular = L10n.tr("Localizable", "taskManager.sectionTitles.regular", fallback: "Regular")
    }
  }
  internal enum TodoListView {
    /// TodoList
    internal static let title = L10n.tr("Localizable", "todoListView.title", fallback: "TodoList")
    internal enum Deadline {
      /// Deadline %@
      internal static func description(_ p1: Any) -> String {
        return L10n.tr("Localizable", "todoListView.deadline.description", String(describing: p1), fallback: "Deadline %@")
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
