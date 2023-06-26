//
//  SlideInPresentationAnimator.swift
//  MovieDatabase
//
//  Created by Mihail Tiranov on 23.06.2023.
//

import UIKit

final class SlideInPresentationAnimator: NSObject {
  
  // MARK: - Public (Properties)
  let direction: PresentationDirection
  let isPresentation: Bool
  
  // MARK: - Init
  init(
    direction: PresentationDirection,
    isPresentation: Bool
  ) {
    self.direction = direction
    self.isPresentation = isPresentation
    super.init()
  }
}

extension SlideInPresentationAnimator: UIViewControllerAnimatedTransitioning {
  func transitionDuration(
    using transitionContext: UIViewControllerContextTransitioning?
  ) -> TimeInterval { 0.3 }
  
  func animateTransition(
    using transitionContext: UIViewControllerContextTransitioning
  ) {
    let key: UITransitionContextViewControllerKey = isPresentation ? .to : .from
    
    let controller = transitionContext.viewController(forKey: key)!
    
    let presentedFrame = transitionContext.finalFrame(for: controller)
    var dismissedFrame = presentedFrame
    
    switch direction {
    case .left:
      dismissedFrame.origin.x = -presentedFrame.width
    case .right:
      dismissedFrame.origin.x = transitionContext.containerView.frame.size.width
    }
    
    let initialFrame = isPresentation ? dismissedFrame : presentedFrame
    let finalFrame = isPresentation ? presentedFrame : dismissedFrame
    
    let animationDuration = transitionDuration(using: transitionContext)
    
    controller.view.frame = initialFrame
    
    func makeAnimationTransition(
      for key: UITransitionContextViewControllerKey,
      index: CGFloat
    ) {
      UIView.animate(
        withDuration: animationDuration,
        animations: {
          let transtionValue = index * UIScreen.main.bounds.width * 0.8
          transitionContext.viewController(forKey: key)!.view.frame.origin.x = transtionValue
          
          let statusBarTag = 38482
          let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
          
          if let statusBar = keyWindow?.viewWithTag(statusBarTag) {
            statusBar.frame.origin.x = index * UIScreen.main.bounds.width * 0.8
          }
          
          controller.view.frame = finalFrame
        }
      ) { transitionContext.completeTransition($0) }
    }
    
    if isPresentation {
      transitionContext.containerView.addSubview(controller.view)
      
      makeAnimationTransition(
        for: UITransitionContextViewControllerKey.from,
        index: direction.rawValue
      )
    } else {
      makeAnimationTransition(
        for: UITransitionContextViewControllerKey.to,
        index: 0
      )
    }
  }
}
