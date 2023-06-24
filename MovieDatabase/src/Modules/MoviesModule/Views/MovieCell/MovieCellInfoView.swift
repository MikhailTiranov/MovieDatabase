//
//  MovieCellInfoView.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 24.06.2023.
//

import UIKit

class MovieCellInfoView: UIView {
  
  // MARK: - Public (Properties)
  var title: String {
    get { titleLabel.text ?? "" }
    set { titleLabel.text = newValue }
  }
  
  var genreAndYear: String {
    get { genreAndYearLabel.text ?? "" }
    set { genreAndYearLabel.text = newValue }
  }
  
  var time: String {
    get { timeLabel.text ?? "" }
    set { timeLabel.text = newValue }
  }
  
  var review: String {
    get { reviewLabel.text ?? "" }
    set { reviewLabel.text = newValue }
  }
  
  // MARK: - Private (Properties)
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16.0)
    label.textColor = .white
    return label
  }()
  
  private let genreAndYearLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13.0)
    label.textColor = .secondaryText
    return label
  }()
  
  private let timeLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 12.0)
    label.textColor = .white
    return label
  }()
  
  private let reviewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16.0)
    label.textColor = .white
    return label
  }()
  
  // MARK: - Init
  init() {
    super.init(frame: CGRect.zero)
    setupView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
  }
  
  // MARK: - Public (Interface)
  func configure(for movie: Movie) {
    titleLabel.text = movie.title
    genreAndYearLabel.text = "\(movie.genre) · \(movie.year)"
    timeLabel.text = makeTime(runtime: movie.runtime)
    
    let textString = "★ \(movie.imdbRating)"
    let range = (textString as NSString).range(of: "★")
    let attributedString = NSMutableAttributedString(string: textString)
    
    attributedString.addAttribute(
      .foregroundColor,
      value: UIColor.accent,
      range: range
    )
    
    reviewLabel.attributedText = attributedString
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    setupSubviews()
    setupLayout()
  }
  
  private func setupSubviews() {
    addSubview(titleLabel)
    addSubview(genreAndYearLabel)
    addSubview(timeLabel)
    addSubview(reviewLabel)
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate(
      [
        titleLabel.topAnchor.constraint(
          equalTo: topAnchor,
          constant: 8.0
        ),
        titleLabel.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: 8.0
        ),
        titleLabel.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -8.0
        ),
        titleLabel.bottomAnchor.constraint(
          equalTo: genreAndYearLabel.topAnchor,
          constant: -8.0
        ),
        
        genreAndYearLabel.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: 8.0
        ),
        genreAndYearLabel.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -8.0
        ),
        
        timeLabel.leadingAnchor.constraint(
          equalTo: leadingAnchor,
          constant: 8.0
        ),
        timeLabel.bottomAnchor.constraint(
          equalTo: bottomAnchor,
          constant: -8.0
        ),
        
        reviewLabel.trailingAnchor.constraint(
          equalTo: trailingAnchor,
          constant: -8.0
        ),
        reviewLabel.bottomAnchor.constraint(
          equalTo: bottomAnchor,
          constant: -8.0
        )
      ]
    )
  }
  
  func makeTime(runtime: String) -> String {
    let numbers = Int(runtime) ?? 0
    let hours = String(numbers / 60)
    let minutes = String(numbers % 60)
    let correctTime = "\(hours)h\(minutes)min"
    return correctTime
  }
}
