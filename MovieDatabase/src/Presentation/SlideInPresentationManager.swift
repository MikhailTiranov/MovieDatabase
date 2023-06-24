//
//  SlideInPresentationManager.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//


import UIKit

class SlideInPresentationManager: NSObject {
  var direction = PresentationDirection.left
}

extension SlideInPresentationManager: UIViewControllerTransitioningDelegate {
  func presentationController(
    forPresented presented: UIViewController,
    presenting: UIViewController?,
    source: UIViewController
  ) -> UIPresentationController? {
    SlideInPresentationController(
      presentedViewController: presented,
      presenting: presenting,
      direction: direction
    )
  }
  
  func animationController(
    forPresented presented: UIViewController,
    presenting: UIViewController,
    source: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    SlideInPresentationAnimator(direction: direction, isPresentation: true)
  }
  
  func animationController(
    forDismissed dismissed: UIViewController
  ) -> UIViewControllerAnimatedTransitioning? {
    SlideInPresentationAnimator(direction: direction, isPresentation: false)
  }
}
