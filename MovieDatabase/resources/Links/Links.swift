//
//  Links.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import Foundation

final class Links {
  static let supportEmail = "trikotai@hotmail.com"
  static let mobileNumberURL = URL(string: "tel://\(mobileNumber.filter { !$0.isWhitespace })")!
  static let mobileNumber: String = "+361 64 3510 659"
}
