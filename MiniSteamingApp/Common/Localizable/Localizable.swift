//
//  Localizable.swift
//  MiniSteamingApp
//
//  Created by KudzaisheMhou on 04/07/2022.
//

import Foundation

// MARK: - Strings
internal enum L10n {
    internal static let events = L10n.tr("Localizable", "events.tab.title")
    internal static let schedule = L10n.tr("Localizable", "schedule.tab.title")
    internal static let today = L10n.tr("Localizable", "today")
    internal static let yesterday = L10n.tr("Localizable", "yesterday")
    internal static let tommorow = L10n.tr("Localizable", "tommorow")
    
    internal static func inDayTime(_ p1: String) -> String {
      return L10n.tr("Localizable", "in.days.time", p1)
    }
}

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: nil, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
