//
//  TransitionDemoUtil+Bubble.swift
//  Transition
//
//  Created by jps on 2020/11/17.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

///圆形转场动画
extension TransitionDemoUtil {
    
    //MARK:  ------------  视图+缩放  ------------
    
    func bubble(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        
        //动画执行时间
        let duration = self.transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        let originalCenter = toView.center
        let originalSize = toView.frame.size
        
        //半径
        let radius = self.getRadius(startPoint: startPoint, originalSize: originalSize)
        
        switch transitionType {
        case .modal(let operation):
            if operation == .presentation {
                let bubble = UIView()
                bubble.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
                bubble.layer.cornerRadius = bubble.frame.size.height / 2
                bubble.center = startPoint
                bubble.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                bubble.backgroundColor = .yellow
                containerView.addSubview(bubble)
                
                toView.center = startPoint
                toView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                toView.alpha = 0
                containerView.addSubview(toView)
                                
                UIView.animate(withDuration: duration) {
                    bubble.transform = .identity
                    toView.transform = .identity
                    toView.alpha = 1
                    toView.center = originalCenter
                } completion: { (isFinished) in
                    transitionContext.completeTransition(true)
                    bubble.isHidden = true
                    if toVC.modalPresentationStyle == .custom {
                        toVC.endAppearanceTransition()
                    }
                    fromVC.endAppearanceTransition()
                }
            }else {
                if fromVC.modalPresentationStyle == .custom {
                    fromVC.beginAppearanceTransition(false, animated: true)
                }
                toVC.beginAppearanceTransition(true, animated: true)
                
                let bubble = UIView()
                bubble.frame = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
                bubble.layer.cornerRadius = bubble.frame.size.height / 2
                bubble.backgroundColor = .yellow
                bubble.center = startPoint
                bubble.isHidden = false
                containerView.insertSubview(bubble, at: 0)
                
                UIView.animate(withDuration: duration) {
                    bubble.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    fromView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
                    fromView.center = self.startPoint
                    fromView.alpha = 0
                } completion: { (isFinished) in
                    transitionContext.completeTransition(true)
                    fromView.removeFromSuperview()
                    bubble.removeFromSuperview()
                    if fromVC.modalPresentationStyle == .custom {
                        fromVC.endAppearanceTransition()
                    }
                    toVC.endAppearanceTransition()
                }
            }
            
        default:
            break
        }
        

    }
    
    
    ///获得半径 (不明白的自己画个图，看一下哪一条应该是半径)
    private func getRadius(startPoint: CGPoint, originalSize: CGSize) -> CGFloat {
        let horizontal = max(startPoint.x, originalSize.width - startPoint.x)
        let vertical = fmax(startPoint.y, originalSize.height - startPoint.y)
        //勾股定理计算半径
        let radius = sqrt(horizontal*horizontal + vertical*vertical)
        return radius
    }
    
    
    
    
    //MARK:  ------------  UIBezierPath + CAShapeLayer + maskLayer  ------------
    
    
    
    //https://www.jianshu.com/p/3c925a1609f8
    func cicleMask(transitionContext: UIViewControllerContextTransitioning) {
        //获得容器视图（转场动画发生的地方）
        let containerView = transitionContext.containerView
        
        //动画执行时间
        let duration = self.transitionDuration(using: transitionContext)
        
        //fromVC (即将消失的视图)
        let fromVC = transitionContext.viewController(forKey: .from)!
        let fromView = fromVC.view!
        //toVC (即将出现的视图)
        let toVC = transitionContext.viewController(forKey: .to)!
        let toView = toVC.view!
        let originalSize = toView.frame.size
        
        //半径
        let radius = self.getRadius(startPoint: startPoint, originalSize: originalSize)
        
        var maskAnim: TransitionMaskAnimation
        switch transitionType {
        case .modal(let operation):
            if operation == .presentation {
                containerView.addSubview(toView)
                maskAnim = TransitionMaskAnimation(layer: toView.layer, center: startPoint, startRadius: 0, endRadius: radius)
            }else {
                maskAnim = TransitionMaskAnimation(layer: fromView.layer, center: startPoint, startRadius: radius, endRadius: 0)
            }
            maskAnim.completion = { finished in
                transitionContext.completeTransition(true)
            }
        default:
            break
        }
    }
    
    
    
    
}



