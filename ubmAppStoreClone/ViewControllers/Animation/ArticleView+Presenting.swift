//
//  ArticleView+Presenting.swift
//  AppStore
//
//  Created by c.c on 2019/6/12.
//  Copyright © 2019 RayWenderlich.com. All rights reserved.
//

import UIKit

/// ArticleView入场动画
class ArticleViewPresentingTransitioning: NSObject, UIViewControllerAnimatedTransitioning
{
    let transitionDuration: Double = 0.8
    var blurEffectView: UIVisualEffectView!
    var dimmingView: UIView!
    
    override init() {
        super.init()
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        dimmingView = UIView()
        dimmingView.backgroundColor = .black
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return transitionDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let fromVC = transitionContext.viewController(forKey: .from) as! ViewController
        let toVC = transitionContext.viewController(forKey: .to)!
        let finalFrame = transitionContext.finalFrame(for: toVC)
        let toView = transitionContext.view(forKey: .to)!
        
        /* 清空containerView */
        let containerView = transitionContext.containerView
        containerView.subviews.forEach{ $0.removeFromSuperview() }
        
        /* 添加背景装饰图层到 containerView */
        blurEffectView.frame = containerView.frame
        blurEffectView.alpha = 0
        containerView.addSubview(blurEffectView)
        
        dimmingView.frame = containerView.frame
        dimmingView.alpha = 0
        containerView.addSubview(dimmingView)
        
        /* 添加toView */
        toView.clipsToBounds = true
        toView.layer.cornerRadius = 20
        toView.frame = fromVC.selectedCellFrameInWindow()
        
        containerView.addSubview(toView)
        
        fromVC.hideSelectedCell()
        
        /* 图层准备完毕 开始动画 */
        let springTiming = UISpringTimingParameters(dampingRatio: 0.75, initialVelocity: CGVector(dx: 0, dy: 4))
        let animator = UIViewPropertyAnimator(duration: transitionDuration, timingParameters: springTiming)
        
        animator.addAnimations {
            toView.frame = finalFrame
            toView.layer.cornerRadius = 0
            
            self.blurEffectView.alpha = 1
            self.dimmingView.alpha = 0.1
            
            containerView.layoutIfNeeded()
        }
        
        animator.addCompletion { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        animator.startAnimation()
    }
    
}
