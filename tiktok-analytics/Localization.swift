// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum Localization {
  /// Alert
  internal static let alert = Localization.tr("Localizable", "alert")
  /// Analyse
  internal static let analyse = Localization.tr("Localizable", "analyse")
  /// Apply
  internal static let apply = Localization.tr("Localizable", "apply")
  /// Comments
  internal static let comments = Localization.tr("Localizable", "comments")
  /// Continue
  internal static let `continue` = Localization.tr("Localizable", "continue")
  /// Current follow details
  internal static let currentFollowDetails = Localization.tr("Localizable", "current_follow_details")
  /// Date
  internal static let date = Localization.tr("Localizable", "date")
  /// Fill username
  internal static let fillUsername = Localization.tr("Localizable", "fill_username")
  /// Followers
  internal static let followers = Localization.tr("Localizable", "followers")
  /// Following
  internal static let following = Localization.tr("Localizable", "following")
  /// Gained
  internal static let gained = Localization.tr("Localizable", "gained")
  /// Hearts
  internal static let hearts = Localization.tr("Localizable", "hearts")
  /// Likes
  internal static let likes = Localization.tr("Localizable", "likes")
  /// Profile is loading
  internal static let loading = Localization.tr("Localizable", "loading")
  /// Lost
  internal static let lost = Localization.tr("Localizable", "lost")
  /// Please, enter valid username
  internal static let notFound = Localization.tr("Localizable", "not_found")
  /// Powerful Analytics for TikTok
  internal static let onboardingA1 = Localization.tr("Localizable", "onboarding_a_1")
  /// Tracking Activity of Any Profile
  internal static let onboardingA2 = Localization.tr("Localizable", "onboarding_a_2")
  /// Analylise Own Profile
  internal static let onboardingB1 = Localization.tr("Localizable", "onboarding_b_1")
  /// Track Activity of Another Profile
  internal static let onboardingB2 = Localization.tr("Localizable", "onboarding_b_2")
  /// Choose Type of Action
  internal static let onboardingBTitle = Localization.tr("Localizable", "onboarding_b_title")
  /// Videos
  internal static let onboardingC1 = Localization.tr("Localizable", "onboarding_c_1")
  /// Shares
  internal static let onboardingC2 = Localization.tr("Localizable", "onboarding_c_2")
  /// Likes
  internal static let onboardingC3 = Localization.tr("Localizable", "onboarding_c_3")
  /// Followers
  internal static let onboardingC4 = Localization.tr("Localizable", "onboarding_c_4")
  /// Choose Indicators You Want To Track
  internal static let onboardingCTitle = Localization.tr("Localizable", "onboarding_c_title")
  /// Enter TikTok username
  internal static let onboardingDTitle = Localization.tr("Localizable", "onboarding_d_title")
  /// Start your free 3-day trial %@/year
  internal static func premiumButtonTitle(_ p1: String) -> String {
    return Localization.tr("Localizable", "premium_button_title", p1)
  }
  /// Now You Track all Insides and Boost Your Profile
  internal static let premiumTitle = Localization.tr("Localizable", "premium_title")
  /// Privacy Policy
  internal static let privacyPolicy = Localization.tr("Localizable", "privacy_policy")
  /// Recent videos
  internal static let recentVideos = Localization.tr("Localizable", "recent_videos")
  /// Shares
  internal static let shares = Localization.tr("Localizable", "shares")
  /// Show Analytics
  internal static let showAnalytics = Localization.tr("Localizable", "show_analytics")
  /// Sort by
  internal static let sortBy = Localization.tr("Localizable", "sort_by")
  /// This trial automatically renews into a paid subscription and will continue to automatically renew until you cancel. Please see our Privacy Policy and Terms of Use.
  internal static let subscriptionInfo = Localization.tr("Localizable", "subscription_info")
  /// Terms of use
  internal static let terms = Localization.tr("Localizable", "terms")
  /// TikTok Username
  internal static let textFieldPlaceholder = Localization.tr("Localizable", "text_field_placeholder")
  /// TikTok Analytics
  internal static let tiktokAnalytics = Localization.tr("Localizable", "tiktok_analytics")
  /// Top Videos
  internal static let topVideos = Localization.tr("Localizable", "top_videos")
  /// Videos
  internal static let videos = Localization.tr("Localizable", "videos")
  /// Views
  internal static let views = Localization.tr("Localizable", "views")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension Localization {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
