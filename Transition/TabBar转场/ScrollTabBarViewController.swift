//
//  ScrollTabBarViewController.swift
//  Transition
//
//  Created by jps on 2020/11/13.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class ScrollTabBarViewController: UITabBarController {
    
    //滑动手势
    private var panGesture = UIPanGestureRecognizer()
    
    //转场动画
    private let transitionUtil = TransitionUtil()
    
    private var vcCount: Int {
        guard let vcs = self.viewControllers else { return 0 }
        return vcs.count
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = transitionUtil
        self.tabBar.tintColor = .green
        
        panGesture.addTarget(self, action: #selector(panHandle(_:)))
        self.view.addGestureRecognizer(panGesture)
        
        
    }
    
    
    
    
    
    
    
    
    
    
    @objc func panHandle(_ pan: UIPanGestureRecognizer) {
        let translationX = panGesture.translation(in: view).x
        let absX = abs(translationX)
        let progress = absX / view.frame.width
        
        switch panGesture.state {
        case .began:
            transitionUtil.interactive = true
            //速度
            let velocityX = panGesture.velocity(in: view).x
            if velocityX < 0 {
                if selectedIndex < vcCount - 1 {
                    selectedIndex += 1
                }
            }else {
                if selectedIndex > 0 {
                    selectedIndex -= 1
                }
            }
            
        case .changed:
            //更新转场进度，进度数值范围为0.0~1.0。
            transitionUtil.interactionTransition.update(progress)
            
        case .cancelled, .ended:
            /*
             这里有个小问题，转场结束或是取消时有很大几率出现动画不正常的问题.
             解决手段是修改交互控制器的 completionSpeed 为1以下的数值，这个属性用来控制动画速度，我猜测是内部实现在边界判断上有问题。
             这里其修改为0.99，既解决了 Bug 同时尽可能贴近原来的动画设定.
             */
            if progress > 0.3 {
                transitionUtil.interactionTransition.completionSpeed = 0.99
                //.finish()方法被调用后，转场动画从当前的状态将继续进行直到动画结束，转场完成
                transitionUtil.interactionTransition.finish()
            }else {
                //转场取消后，UITabBarController 自动恢复了 selectedIndex 的值，不需要我们手动恢复。
                transitionUtil.interactionTransition.completionSpeed = 0.99
                //.cancel()被调用后，转场动画从当前的状态回拨到初始状态，转场取消。
                transitionUtil.interactionTransition.cancel()
            }
            //无论转场的结果如何，恢复为非交互状态。
            transitionUtil.interactive = false
            
        default:
            break
        }
    }
    
    
    
    
    

}
