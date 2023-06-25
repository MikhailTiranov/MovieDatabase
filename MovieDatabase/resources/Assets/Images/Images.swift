//
//  Images.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

// MARK: - UIImage
extension UIImage {
  static var person: UIImage {
    UIImage(systemName: "person.crop.circle")!
  }
  
  static var magnifyingglass: UIImage {
    UIImage(systemName: "magnifyingglass")!
  }
  
  static var imageError: UIImage {
    UIImage(systemName: "eye.slash.circle")!
  }
  
  static var profile: UIImage {
    UIImage(named: "profile")!
  }
  
  static var phone: UIImage {
    UIImage(systemName: "phone")!
  }
  
  static var envelope: UIImage {
    UIImage(systemName: "envelope")!
  }
  
  static var xmark: UIImage {
    UIImage(systemName: "xmark")!
  }
}
