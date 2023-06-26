//
//  ProfileView.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 25.06.2023.
//

import UIKit

class ProfileView: UIStackView {
  
  // MARK: - Public (Properties)
  weak var delegate: ProfileViewDelegate?
  
  // MARK: - Private (Properties)
  private let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Mikhail Tiranov"
    label.font = .systemFont(ofSize: 23.0, weight: .semibold)
    label.textColor = .textHighligted
    return label
  }()
  
  private let birthLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Male | Born 16.11.1993"
    label.font = .systemFont(ofSize: 13.0, weight: .bold)
    label.textColor = .primaryText
    return label
  }()
  
  private let avatar: UIImageView = {
    let view = UIImageView()
    let size = 170.0
    view.translatesAutoresizingMaskIntoConstraints = false
    view.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true
    view.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
    view.image = .profile
    view.contentMode = .scaleAspectFill
    view.layer.cornerRadius = size / 2
    view.clipsToBounds = true
    view.layer.borderWidth = 5.0
    view.layer.borderColor = UIColor.backgroundAccent.cgColor
    return view
  }()
  
  private let phoneLabel: UILabel = {
    let label = UILabel()
    label.text = Links.mobileNumber
    label.font = .systemFont(ofSize: 15.0, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .primaryText
    return label
  }()
  
  private let emailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = Links.supportEmail
    label.font = .systemFont(ofSize: 15.0, weight: .bold)
    label.textColor = .primaryText
    return label
  }()
  
  private let phoneButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    button.widthAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    button.tintColor = .textHighligted
    button.layer.cornerRadius = buttonHeight / 2
    button.backgroundColor = .backgroundAccent
    button.setImage(.phone, for: .normal)
    return button
  }()
  
  private let mailButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.heightAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    button.widthAnchor.constraint(equalToConstant: buttonHeight).isActive = true
    button.tintColor = .textHighligted
    button.layer.cornerRadius = buttonHeight / 2
    button.backgroundColor = .backgroundAccent
    button.setImage(.envelope, for: .normal)
    return button
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
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Private (Interface)
  private func setupView() {
    translatesAutoresizingMaskIntoConstraints = false
    axis = .vertical
    alignment = .center
    spacing = .zero
    
    setupSubviews()
    setupButtons()
  }
  
  private func setupSubviews() {
    addArrangedSubview(nameLabel)
    addArrangedSubview(birthLabel)
    setCustomSpacing(12.0, after: birthLabel)
    addArrangedSubview(avatar)
    setCustomSpacing(17.0, after: avatar)
    addArrangedSubview(phoneLabel)
    setCustomSpacing(6.0, after: avatar)
    addArrangedSubview(emailLabel)
    setCustomSpacing(16.0, after: emailLabel)
    
    let buttonsStackView = UIStackView(arrangedSubviews: [phoneButton, mailButton])
    buttonsStackView.spacing = 30.0
    addArrangedSubview(buttonsStackView)
  }
  
  private func setupButtons() {
    phoneButton.addTarget(
      self,
      action: #selector(tapPhoneButton),
      for: .touchUpInside
    )
    
    mailButton.addTarget(
      self,
      action: #selector(tapEmailButton),
      for: .touchUpInside
    )
  }
  
  @objc private func tapPhoneButton() {
    delegate?.phoneButtonWasTapped()
  }
  
  @objc private func tapEmailButton() {
    delegate?.emailButtonWasTapped()
  }
}

extension ProfileView {
  private static let buttonHeight = 60.0
  private static let imageHeight = 170.0
}
