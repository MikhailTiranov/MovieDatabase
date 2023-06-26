//
//  Movie.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

struct Movie: Codable {
  
  // MARK: - Public (Properties)
  let title: String
  let releaseDate: String?
  let voteAverage: Double
  let runtime: Int?
  let genres: [Genre]?
  let overview: String
  let backdropPath: String?
  let posterPath: String?
  
  var date: Date? {
    DateFormatter.fullDateFormatter.date(from: releaseDate ?? "")
  }
}

extension Movie: MovieCellRepresentable {
  var attributedReview: NSAttributedString {
    let textString = "★ \(String(format:"%.1f", voteAverage))"
    let range = (textString as NSString).range(of: "★")
    let attributedString = NSMutableAttributedString(string: textString)
    
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor.accent,
      range: range
    )
    
    return attributedString
  }
  
  var duration: String {
    guard let runtime else { return "" }
    let hours = String(runtime / 60)
    let minutes = String(runtime % 60)
    let correctTime = "\(hours)h\(minutes)min"
    return correctTime
  }
  
  var genreAndYear: String {
    guard let date else { return "" }
    let year = DateFormatter.yearDateFormatter.string(from: date)
    guard let genres else { return year }
    
    return genres
      .prefix(2)
      .map { $0.name }
      .joined(separator: ", ")
    + " · "
    + year
  }
}

extension Movie: MovieDetailRepresentable {
  var minutesDuration: String {
    if let runtime {
      return String(runtime) + "m"
    } else {
      return ""
    }
  }

  var starsReview: String {
    var textString = ""
    var halfRate = voteAverage / 2
    
    for _ in 1...5 {
      textString.append(halfRate >= 0.5 ? "★ " : "☆ ")
      halfRate -= 1
    }
    
    return textString
  }

  var allGenres: String {
    if let genres {
      return genres
        .map { $0.name }
        .joined(separator: ", ")
    } else {
      return "-"
    }
  }
    
  var fullReleaseDate: String {
    guard let date else { return "-" }
    return DateFormatter.describingDateFormatter.string(from: date)
  }
}

extension Movie {
  struct Genre: Codable {
    let name: String
  }
}

extension Movie {
  static var mockMovies: [String] {
    [
      "tt0111161",
      "tt0109830",
      "tt1375666",
      "tt0468569",
      "tt0068646",
      "tt0137523",
      "tt0102926",
      "tt0133093",
      "tt0172495",
      "tt1853728",
      "tt0268978",
      "tt1675434",
      "tt0099685",
      "tt0482571",
      "tt0088763",
      "tt0407887",
      "tt0208092",
      "tt0120689",
      "tt0993846",
      "tt0167404",
      "tt1130884",
      "tt0758758",
      "tt6966692",
      "tt0816692",
      "tt0078748",
      "tt0110912",
      "tt0332452",
      "tt0110357",
      "tt0066921",
      "tt2267998"
    ]
  }
}
