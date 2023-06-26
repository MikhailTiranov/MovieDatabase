//
//  DetailViewTemplateLabel.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 25.06.2023.
//

import UIKit

class DetailViewTemplateLabel: UIView {
  
  // MARK: - Public (Properties)
  var title: String? {
    willSet { titleLabel.text = newValue }
  }
  
  var subtitle: String? {
    willSet { subtitleLabel.text = newValue }
  }
  
  // MARK: - Private (Properties)
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.text = title
    label.alpha = 0.5
    label.textAlignment = .right
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13.0, weight: .semibold)
    label.textColor = .accent
    return label
  }()
  
  private lazy var subtitleLabel: UILabel = {
    let label = UILabel()
    label.text = subtitle
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 13.0, weight: .semibold)
    label.textColor = .primaryText
    return label
  }()
  
  // MARK: - Init
  init(with title: String? = nil, subtitle: String? = nil) {
    self.title = title
    self.subtitle = subtitle
    super.init(frame: CGRect.zero)
    setupView()
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    
    setupSubviews()
    setupLayout()
  }
  
  private func setupSubviews() {
    addSubview(titleLabel)
    addSubview(subtitleLabel)
  }
  
  private func setupLayout() {
    NSLayoutConstraint.activate(
      [
        titleLabel.topAnchor.constraint(equalTo: topAnchor),
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
        titleLabel.widthAnchor.constraint(equalToConstant: 100.0),
        titleLabel.trailingAnchor.constraint(equalTo: subtitleLabel.leadingAnchor, constant: -16.0),
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        subtitleLabel.topAnchor.constraint(equalTo: topAnchor),
        subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
      ]
    )
  }
}
