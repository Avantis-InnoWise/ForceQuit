// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Macquitter
  internal static let appTitle = L10n.tr("Localizable", "appTitle")
  /// Cant't get an application name
  internal static let nameError = L10n.tr("Localizable", "nameError")
  /// Open ForceQuit
  internal static let openApp = L10n.tr("Localizable", "openApp")
  /// Force quit
  internal static let quit = L10n.tr("Localizable", "quit")
  /// Type a file's name
  internal static let searchPlaceholder = L10n.tr("Localizable", "searchPlaceholder")
  /// Select all
  internal static let select = L10n.tr("Localizable", "select")
  /// Terminate all
  internal static let terminateAll = L10n.tr("Localizable", "terminateAll")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
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
