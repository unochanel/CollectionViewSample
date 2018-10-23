//
//  UIViewController+Animation.swift
//  SampleCollectionVIew
//
//  Created by 宇野 凌平 on 2018/10/23.
//  Copyright © 2018年 宇野 凌平. All rights reserved.
//

import UIKit

fileprivate let scaleSmall = CGAffineTransform(scaleX: 0.9, y: 0.9)
fileprivate let scaleLarge = CGAffineTransform(scaleX: 1.0, y: 1.0)

public class OverlayTransitionPresent: NSObject, UIViewControllerAnimatedTransitioning {
    
    private let animationDuration: TimeInterval = 0.3
    private let animationSpringDumping: CGFloat = 0.7
    private let initialSpringVelocity:  CGFloat = 0.7
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let popupVC = transitionContext.viewController(forKey: .to) as? CreateTagViewController else { return }
        let containerView = transitionContext.containerView
        containerView.insertSubview(popupVC.view, aboveSubview: fromVC.view)
        
        popupVC.mainView.frame = containerView.bounds
        
        popupVC.mainView.transform = scaleLarge
        popupVC.mainView.alpha = 0
        popupVC.background.alpha = 0
        
        UIView.animate(withDuration: animationDuration, animations: {
            popupVC.mainView.transform = scaleSmall
            popupVC.mainView.alpha = 1
            popupVC.background.alpha = 0.6
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

public class OverlayTransitionDismiss: NSObject, UIViewControllerAnimatedTransitioning {

    private let animationDuration: TimeInterval = 0.2
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let popupVC = transitionContext.viewController(forKey: .from) as? CreateTagViewController else {
            return
        }
        
        UIView.animate(withDuration: animationDuration, animations: {
            popupVC.mainView.alpha = 0
            popupVC.background.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}

