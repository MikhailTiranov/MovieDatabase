//
//  ProfileViewController.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 25.06.2023.
//

import UIKit
import MessageUI

final class ProfileViewController: UIViewController {
  
  // MARK: - ViewController
  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    setupLayout()
  }
  
  private func setupView() {
    view.backgroundColor = .background
  }
  
  private func setupLayout() {
    let profileView = ProfileView()
    profileView.delegate = self
    
    profileView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(profileView)
    view.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
    view.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
  }
}

extension ProfileViewController: ProfileViewDelegate {
  func phoneButtonWasTapped() {
    if UIApplication.shared.canOpenURL(Links.mobileNumberURL) {
      UIApplication.shared.open(Links.mobileNumberURL)
    } else {
      print("Impossible to make a phone Call")
    }
  }
  
  func emailButtonWasTapped() {
    guard
      MFMailComposeViewController.canSendMail()
    else {
      print(#line, #function, "Can not send e-mail")
      return
    }
    
    let mailComposer = MFMailComposeViewController()
    mailComposer.modalPresentationCapturesStatusBarAppearance = true
    mailComposer.modalPresentationStyle = .overFullScreen
    mailComposer.modalTransitionStyle = .crossDissolve
    mailComposer.mailComposeDelegate = self
    
    mailComposer.setToRecipients([Links.supportEmail])
    mailComposer.setSubject("Result of app testing")
    mailComposer.setMessageBody("Your result is", isHTML: false)
    
    present(mailComposer, animated: true)
  }
}

extension ProfileViewController: MFMailComposeViewControllerDelegate {
  func mailComposeController(
    _ controller: MFMailComposeViewController,
    didFinishWith result: MFMailComposeResult,
    error: Error?
  ) {
    dismiss(animated: true)
  }
}
