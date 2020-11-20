//
//  TransitionDemoUtil+Window.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

extension TransitionDemoUtil {
    
    //MARK:  ------------  小窗口效果  ------------
    
    //带暗色调背景的小窗口效果， 定制 presentedView 的尺寸
    func transitionWindowDemo(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        //设置暗背景视图(也可以创建一个dimmingView，设置背景大小后，insert到containerView的最底层)
        containerView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
        
        
        //动画执行时间
        let duration = self.transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        
        if toVC.isBeingPresented {
            let toW: CGFloat = 100
            let toH: CGFloat = 200
            //添加到容器
            containerView.addSubview(toView)
            toView.center = containerView.center
            toView.bounds = CGRect(x: 0, y: 0, width: 1, height: toH)
            
            //暗色背景
            let dimmingView = UIView()
            containerView.insertSubview(dimmingView, belowSubview: toView)
            dimmingView.backgroundColor = UIColor.red.withAlphaComponent(0.3)
            dimmingView.center = containerView.center
            dimmingView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
            
            
            /*
            containerView.addSubview(toView)
            toView.center = containerView.center
            toView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
            toView.transform = CGAffineTransform(scaleX: 0.1, y: 1)
            UIView.animate(withDuration: duration, animations: {
                toView.transform = .identity
            }) { (finished) in
                //考虑到转场中途可能取消的情况，转场结束后，恢复视图状态。(通知是否完成转场)
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
            }*/
            
            
            
            UIView.animate(withDuration: duration, animations: {
                toView.bounds = CGRect(x: 0, y: 0, width: toW, height: toH)
                dimmingView.bounds = containerView.bounds
            }) { (finished) in
                let wasCancelled = transitionContext.transitionWasCancelled
                //通知完成转场
                transitionContext.completeTransition(!wasCancelled)
            }
        }
        
        //Dismissal 转场中不要将 toView 添加到 containerView
        if fromVC.isBeingDismissed {
            let fromH = fromView.frame.height
            UIView.animate(withDuration: duration, animations: {
                fromView.bounds = CGRect(x: 0, y: 0, width: 1, height: fromH)
            }) { (finished) in
                let wasCancelled = transitionContext.transitionWasCancelled
                transitionContext.completeTransition(!wasCancelled)
            }
        }
    }
    
    
    
    
    
    
  
    
    
    
}
