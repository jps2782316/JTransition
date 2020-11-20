//
//  Demo2ViewController.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class Demo2ViewController: UIViewController {

    @IBOutlet weak var closeBtn: UIButton!
    
    
    private var transitionDelegate: TransitionDemoUtil {
        return self.transitioningDelegate as! TransitionDemoUtil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //closeBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 4)
        
        let pan = UIPanGestureRecognizer()
        pan.addTarget(self, action: #selector(verticalPanHandle(_:)))
        self.view.addGestureRecognizer(pan)
        
    }


    @IBAction func closeBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        transitionDelegate.interactionTransition.finish()
    }
    
    
    
    
    ///竖直滑动dismiss
    @objc func verticalPanHandle(_ pan: UIPanGestureRecognizer) {
        //注意⚠️: 不能用pan.translation(in: view).y，不然算出来的值不对
        let translationY = pan.translation(in: view.superview).y
        let absY = abs(translationY)
        //注意⚠️: 不能用frame去取height，不然无法控制转场进度
        //let progress = absY / view.frame.height
        let progress = absY / view.bounds.height
        
        print("absY: \(absY), height: \(view.bounds.height), progress: \(progress)")
        
        switch pan.state {
        case .began:
            transitionDelegate.interactive = true
            //如果转场代理提供了交互控制器，它将从这时候开始接管转场过程。
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
            break
        }
    }
    
    
    
}
