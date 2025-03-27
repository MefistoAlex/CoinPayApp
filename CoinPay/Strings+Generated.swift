// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Button {
    /// Next
    internal static let next = L10n.tr("Localizable", "button.next", fallback: "Next")
  }
  internal enum Onboarding {
    /// Trusted by millions of people, part of one part
    internal static let title1 = L10n.tr("Localizable", "onboarding.title1", fallback: "Trusted by millions of people, part of one part")
    /// Spend money abroad, and track your expense
    internal static let title2 = L10n.tr("Localizable", "onboarding.title2", fallback: "Spend money abroad, and track your expense")
    /// Receive Money 
    /// From Anywhere In 
    /// The World
    internal static let title3 = L10n.tr("Localizable", "onboarding.title3", fallback: "Receive Money \nFrom Anywhere In \nThe World")
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
