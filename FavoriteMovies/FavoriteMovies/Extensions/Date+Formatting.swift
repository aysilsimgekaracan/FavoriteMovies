//
//  Date+Extension.swift
//  FavoriteMovies
//
//  Created by Ayşıl Simge Karacan on 16.01.2026.
//

import Foundation

extension Date {
  /// Formats the date using the user's locale in a numeric day-month-year style.
  ///
  /// - Parameter locale: Locale to use. Defaults to `.current`.
  /// - Returns: A localized numeric date string (order depends on locale).
  func localizedDayMonthYear(locale: Locale = .current) -> String {
    formatted(
      Date.FormatStyle()
        .locale(locale)
        .year(.defaultDigits)
        .month(.twoDigits)
        .day(.twoDigits)
    )
  }
}
