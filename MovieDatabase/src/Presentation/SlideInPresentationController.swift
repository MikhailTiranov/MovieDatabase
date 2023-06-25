//
//  SlideInPresentationController.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

class SlideInPresentationController: UIPresentationController {
  
  // MARK: - Private (Properties)
  private var dimmingView: UIView!
  private var direction: PresentationDirection
  
  // MARK: - UIPresentationController
  override var frameOfPresentedViewInContainerView: CGRect {
    var frame: CGRect = .zero
    frame.size = size(
      forChildContentContainer: presentedViewController,
      withParentContainerSize: containerView!.bounds.size
    )
    
    switch direction {
    case .right:
      frame.origin.x = containerView!.frame.width * 0.2
    case .center:
      frame.size.width = UIScreen.main.bounds.width * 0.91
      frame.size.height = UIScreen.main.bounds.height * 0.94
    case .left:
      frame.origin = .zero
    }
    
    return frame
  }
  
  // MARK: - Init
  init(
    presentedViewController: UIViewController,
    presenting presentingViewController: UIViewController?,
    direction: PresentationDirection
  ) {
    self.direction = direction
    
    super.init(
      presentedViewController: presentedViewController,
      presenting: presentingViewController
    )
    
    setupDimmingView()
  }
  
  // MARK: - UIPresentationController
  override func presentationTransitionWillBegin() {
    containerView?.insertSubview(dimmingView, at: 0)

    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "V:|[dimmingView]|",
        metrics: nil,
        views: ["dimmingView": dimmingView!]
      )
    )
    
    NSLayoutConstraint.activate(
      NSLayoutConstraint.constraints(
        withVisualFormat: "H:|[dimmingView]|",
        metrics: nil,
        views: ["dimmingView": dimmingView!]
      )
    )
    
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate { _ in
        self.dimmingView.alpha = 1.0
      }
    } else {
      dimmingView.alpha = 1.0
    }
  }
  
  override func dismissalTransitionWillBegin() {
    if let coordinator = presentedViewController.transitionCoordinator {
      coordinator.animate { _ in
        self.dimmingView.alpha = .zero
      }
    } else {
      dimmingView.alpha = .zero
    }
  }
  
  override func containerViewWillLayoutSubviews() {
    presentedView?.frame = frameOfPresentedViewInContainerView
    
    if direction == .center {
      presentedView?.center = CGPoint(
        x: UIScreen.main.bounds.width / 2,
        y: UIScreen.main.bounds.height / 2
      )
    }
  }
  
  override func size(
    forChildContentContainer container: UIContentContainer,
    withParentContainerSize parentSize: CGSize
  ) -> CGSize {
    CGSize(
      width: parentSize.width * (direction == .center ? 1.0 : 0.8),
      height: parentSize.height
    )
  }
}

private extension SlideInPresentationController {
  func setupDimmingView() {
    dimmingView = UIView()
    dimmingView.translatesAutoresizingMaskIntoConstraints = false
    dimmingView.backgroundColor = .dimming
    dimmingView.alpha = .zero
    
    let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
    dimmingView.addGestureRecognizer(recognizer)
  }
  
  
  @objc func handleTap(recognizer: UITapGestureRecognizer) {
    presentingViewController.dismiss(animated: direction != .center)
  }
}
