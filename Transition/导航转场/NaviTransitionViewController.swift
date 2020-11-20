//
//  NaviTransitionViewController.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class NaviTransitionViewController: UIViewController {
    
//    private var transitionDelegate: TransitionUtil {
//        return self.navigationController?.delegate as! TransitionUtil
//    }
    
    var transitionDelegate: TransitionUtil!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red

        let verticalPan = UIPanGestureRecognizer()
        verticalPan.addTarget(self, action: #selector(verticalPanHandle(_:)))
        self.view.addGestureRecognizer(verticalPan)
    }
    
    
    
    ///滑动pop
    @objc func verticalPanHandle(_ pan: UIPanGestureRecognizer) {
        let translationX = pan.translation(in: view).x
        let absX = abs(translationX)
        let progress = absX / view.frame.width
        
        switch pan.state {
        case .began:
            //必须在转场开始前获取代理，一旦转场开始，VC 将脱离控制器栈，此后 self.navigationController 返回的是 nil。
            transitionDelegate = (self.navigationController?.delegate as! TransitionUtil)
            transitionDelegate.interactive = true
            //如果转场代理提供了交互控制器，它将从这时候开始接管转场过程。
            self.navigationController?.popViewController(animated: true)
            
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
    

}
