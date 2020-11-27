//
//  TransitionDemoUtil.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

///一些转场的特殊效果
class TransitionDemoUtil: NSObject {
    
    
    var transitionType: TransitionType?
    
    //交互转场
    var interactive = false
    let interactionTransition = UIPercentDrivenInteractiveTransition()
    
    
    ///点击弹出页面时的那个按钮的center
    var startPoint: CGPoint!
    
    
    
    var demo: Int = 0
    
    
}



extension TransitionDemoUtil: UIViewControllerAnimatedTransitioning {
    
    //控制转场动画执行时间
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        //return 1.5
        return 0.5
    }
    
    //执行动画的地方，最核心的方法。
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        switch demo {
        case 0:
            //小窗体demo
            transitionWindowDemo(transitionContext: transitionContext)
        case 1:
            //圆形遮罩，方式一
            bubble(transitionContext: transitionContext)
        case 2:
            //圆形遮罩，方式二
            cicleMask(transitionContext: transitionContext)
        default:
            break
        }
        
    }
    
    //如果实现了，会在转场动画结束后调用，可以执行一些收尾工作。
    func animationEnded(_ transitionCompleted: Bool) {
        
    }

}



///自定义模态转场动画时使用
extension TransitionDemoUtil: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.presentation)
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.transitionType = .modal(.dismissal)
        return self
    }
    
    /*
     注意⚠️:  ???
     实现了这个方法后，点击按钮dismiss异常？
     所以不能直接return interactionTransition，确认时用手势控制的交互转场时在返回
     直接点击返回按钮的返回，这里应该return nil
     */
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactive ? interactionTransition : nil
    }
}



/// 自定义navigation转场动画时使用
extension TransitionDemoUtil: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
}



