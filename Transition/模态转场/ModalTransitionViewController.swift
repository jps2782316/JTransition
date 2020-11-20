//
//  ModalTransitionViewController.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class ModalTransitionViewController: UIViewController {
    
    
    
    /*
     这里必须用转场进来时的代理，不能再重新创建一个，不然无法控制转场进度
     */
    //private var transitionDelegate = TransitionUtil()
    private var transitionDelegate: TransitionUtil {
        return self.transitioningDelegate as! TransitionUtil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        
        let verticalPan = UIPanGestureRecognizer()
        verticalPan.addTarget(self, action: #selector(verticalPanHandle(_:)))
        self.view.addGestureRecognizer(verticalPan)
        
        let screenEdgePan = UIScreenEdgePanGestureRecognizer()
        screenEdgePan.edges = .left
        screenEdgePan.addTarget(self, action: #selector(screenEdgePanHandle(_:)))
        self.view.addGestureRecognizer(screenEdgePan)
    }
    
    
    
    
    //MARK:  ------------  滑动返回  ------------
    
    ///竖直滑动dismiss
    @objc func verticalPanHandle(_ pan: UIPanGestureRecognizer) {
        let translationY = pan.translation(in: view).y
        let absY = abs(translationY)
        let progress = absY / view.frame.height
        
        switch pan.state {
        case .began:
            transitionDelegate.interactive = true
            //如果转场代理提供了交互控制器，它将从这时候开始接管转场过程。
            self.dismiss(animated: true, completion: nil)
            
        case .changed:
            transitionDelegate.interactionTransition.update(progress)
            
        case .cancelled, .ended:
            if progress > 0.3 {
                transitionDelegate.interactionTransition.completionSpeed = 0.99
                transitionDelegate.interactionTransition.finish()
            }else {
                transitionDelegate.interactionTransition.completionSpeed = 0.99
                transitionDelegate.interactionTransition.cancel()
            }
            transitionDelegate.interactive = false
            
        default:
            break
        }
    }
    
    
    
    
    ///边缘滑动dismiss
    @objc func screenEdgePanHandle(_ pan: UIScreenEdgePanGestureRecognizer) {
        let translationX = pan.translation(in: view).x
        let absX = abs(translationX)
        let progress = absX / view.frame.width
        
        switch pan.state {
        case .began:
            transitionDelegate.interactive = true
            self.dismiss(animated: true, completion: nil)
            
        case .changed:
            transitionDelegate.interactionTransition.update(progress)
            
        case .cancelled, .ended:
            if progress > 0.3 {
                transitionDelegate.interactionTransition.finish()
            }else {
                transitionDelegate.interactionTransition.cancel()
            }
            transitionDelegate.interactive = false
            
        default:
            transitionDelegate.interactive = false
        }
    }
    

}
