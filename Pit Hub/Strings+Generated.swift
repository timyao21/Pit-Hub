// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum S {
  /// Orbitron
  internal static let orbitron = S.tr("swiftgenLocalizable", "Orbitron", fallback: "Orbitron")
  /// PitHubIcon
  internal static let pitHubIcon = S.tr("swiftgenLocalizable", "pitHubIcon", fallback: "PitHubIcon")
  /// PitHubIconColor
  internal static let pitHubIconColor = S.tr("swiftgenLocalizable", "pitHubIconColor", fallback: "PitHubIconColor")
  /// PitIcon
  internal static let pitIcon = S.tr("swiftgenLocalizable", "pitIcon", fallback: "PitIcon")
  /// PrimaryBackground
  internal static let primaryBackground = S.tr("swiftgenLocalizable", "primaryBackground", fallback: "PrimaryBackground")
  /// Smiley Sans
  internal static let smileySans = S.tr("swiftgenLocalizable", "SmileySans", fallback: "Smiley Sans")
  /// Localizable.strings
  ///   Pit Hub
  /// 
  ///   Created by Junyu Yao on 12/2/24.
  internal static let title = S.tr("swiftgenLocalizable", "title", fallback: "Pit")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension S {
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
