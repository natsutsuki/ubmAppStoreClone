//
//  ArticleView+Dismiss.swift
//  AppStore
//
//  Created by c.c on 2019/6/12.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

/// ArticleView出场动画
class ArticleViewDismissTransitioning: NSObject, UIViewControllerAnimatedTransitioning {
    
    let transitionDuration: Double = 0.5
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        let fromView = transitionContext.view(forKey: .from)!
        let toVC = transitionContext.viewController(forKey: .to) as! ViewController
        
        /* 算出缩放和移动量 */
        let targetFrame = toVC.selectedCellFrameInWindow()
        let duration = transitionDuration(using: transitionContext)
        
        toVC.hideSelectedCell()
        
        /* 图层准备完毕，开始动画 */
        UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIView.AnimationOptions.curveLinear, animations: {
            for case let view in transitionContext.containerView.subviews {
                if view != fromView {
                    view.alpha = 0
                }
            }
            
            fromView.frame = targetFrame
            fromView.layer.cornerRadius = 20
            
        }) { (_) in
            toVC.unHideSelectedCell()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
