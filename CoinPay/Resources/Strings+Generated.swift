// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Authorisation {
    internal enum ConfirmPhone {
      /// Can resend after
      internal static let canResend = L10n.tr("Localizable", "authorisation.confirm_phone.can_resend", fallback: "Can resend after")
      /// You've entered wrong code
      internal static let codeMissmatch = L10n.tr("Localizable", "authorisation.confirm_phone.code_missmatch", fallback: "You've entered wrong code")
      /// Didn’t get a code?
      internal static let didntGetCode = L10n.tr("Localizable", "authorisation.confirm_phone.didnt_get_code", fallback: "Didn’t get a code?")
      /// We send 6 digits code to 
      internal static let subtitle = L10n.tr("Localizable", "authorisation.confirm_phone.subtitle", fallback: "We send 6 digits code to ")
      /// Confirm your phone
      internal static let title = L10n.tr("Localizable", "authorisation.confirm_phone.title", fallback: "Confirm your phone")
    }
    internal enum CreateAccount {
      /// Chose your country
      internal static let choseYourCountry = L10n.tr("Localizable", "authorisation.create_account.chose_your_country", fallback: "Chose your country")
      /// Enter password
      internal static let enterPassword = L10n.tr("Localizable", "authorisation.create_account.enter_password", fallback: "Enter password")
      /// Mobile number
      internal static let mobileNumber = L10n.tr("Localizable", "authorisation.create_account.mobile_number", fallback: "Mobile number")
      /// Password
      internal static let password = L10n.tr("Localizable", "authorisation.create_account.password", fallback: "Password")
      /// Phone
      internal static let phone = L10n.tr("Localizable", "authorisation.create_account.phone", fallback: "Phone")
      /// Is this correct?
      internal static let phoneVerificationSubtitle = L10n.tr("Localizable", "authorisation.create_account.phone_verification_subtitle", fallback: "Is this correct?")
      /// Verify your phone number before we send code
      internal static let phoneVerificationTitle = L10n.tr("Localizable", "authorisation.create_account.phone_verification_title", fallback: "Verify your phone number before we send code")
      /// Enter your mobile number to verify your account
      internal static let subtitle = L10n.tr("Localizable", "authorisation.create_account.subtitle", fallback: "Enter your mobile number to verify your account")
      /// Create an Account
      internal static let title = L10n.tr("Localizable", "authorisation.create_account.title", fallback: "Create an Account")
      /// Wrong phone number
      internal static let wrongPhoneNumber = L10n.tr("Localizable", "authorisation.create_account.wrong_phone_number", fallback: "Wrong phone number")
      /// Your location
      internal static let yourLocation = L10n.tr("Localizable", "authorisation.create_account.your_location", fallback: "Your location")
    }
    internal enum Signup {
      /// and
      internal static let and = L10n.tr("Localizable", "authorisation.signup.and", fallback: "and")
      /// Privacy Policy
      internal static let privacy = L10n.tr("Localizable", "authorisation.signup.privacy", fallback: "Privacy Policy")
      /// Coinpay is a powerful tool that allows you to easily send, receive, and track all your transactions.
      internal static let subtitle = L10n.tr("Localizable", "authorisation.signup.subtitle", fallback: "Coinpay is a powerful tool that allows you to easily send, receive, and track all your transactions.")
      /// Terms of Service
      internal static let terms = L10n.tr("Localizable", "authorisation.signup.terms", fallback: "Terms of Service")
      /// By continuing you accept our
      internal static let termsTitle = L10n.tr("Localizable", "authorisation.signup.terms_title", fallback: "By continuing you accept our")
      /// Create your 
      /// Coinpay account
      internal static let title = L10n.tr("Localizable", "authorisation.signup.title", fallback: "Create your \nCoinpay account")
    }
  }
  internal enum Button {
    /// Done
    internal static let done = L10n.tr("Localizable", "button.done", fallback: "Done")
    /// Log in
    internal static let logIn = L10n.tr("Localizable", "button.log_in", fallback: "Log in")
    /// Next
    internal static let next = L10n.tr("Localizable", "button.next", fallback: "Next")
    /// No
    internal static let no = L10n.tr("Localizable", "button.no", fallback: "No")
    /// Resend
    internal static let resend = L10n.tr("Localizable", "button.resend", fallback: "Resend")
    /// Sign up
    internal static let signUp = L10n.tr("Localizable", "button.sign_up", fallback: "Sign up")
    /// Verify Your Number
    internal static let verify = L10n.tr("Localizable", "button.verify", fallback: "Verify Your Number")
    /// Yes
    internal static let yes = L10n.tr("Localizable", "button.yes", fallback: "Yes")
  }
  internal enum Error {
    /// Decoding Error
    internal static let decoding = L10n.tr("Localizable", "error.decoding", fallback: "Decoding Error")
    /// HTTP Error: %s
    internal static func http(_ p1: UnsafePointer<CChar>) -> String {
      return L10n.tr("Localizable", "error.http", p1, fallback: "HTTP Error: %s")
    }
    /// Invalid URL
    internal static let invalidUrl = L10n.tr("Localizable", "error.invalid_url", fallback: "Invalid URL")
    /// Error
    internal static let title = L10n.tr("Localizable", "error.title", fallback: "Error")
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
