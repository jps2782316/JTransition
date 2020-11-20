//
//  TransitionMaskAnimation.swift
//  Transition
//
//  Created by jps on 2020/11/20.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

class TransitionMaskAnimation: NSObject {
    
    var duration: TimeInterval = 2
    
    weak var layer: CALayer?
    
    
    var completion: ((_ finished: Bool) -> Void)?
    
    
    init(layer: CALayer, center: CGPoint, startRadius: CGFloat, endRadius: CGFloat) {
        super.init()
        self.layer = layer
        
        let f1 = CGRect(x: center.x, y: center.y, width: startRadius, height: startRadius)
        let startRect = f1.insetBy(dx: -startRadius, dy: -startRadius)
        let startPath = UIBezierPath(ovalIn: startRect)
        
        //创建一个 CAShapeLayer 来负责展示圆形遮盖
        let f2 = CGRect(x: center.x, y: center.y, width: endRadius, height: endRadius)
        let endRect = f2.insetBy(dx: -endRadius, dy: -endRadius)
        let endPath = UIBezierPath(ovalIn: endRect)
        //用 CAShapeLayer 作为 mask
        let maskLayer = CAShapeLayer()
        maskLayer.path = endPath.cgPath
        layer.mask = maskLayer
        
        //对 CAShapeLayer 的 path 属性进行动画
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.delegate = self
        maskLayerAnimation.fromValue = startPath.cgPath
        maskLayerAnimation.toValue = endPath.cgPath
        maskLayerAnimation.duration = duration
        //maskLayerAnimation.timingFunction = CAMediaTimingFunction(name: .easeOut)
        maskLayer.add(maskLayerAnimation, forKey: "path")
    }
    
}



extension TransitionMaskAnimation: CAAnimationDelegate {
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        //清除 fromVC 的 mask,这里一定要清除,否则会影响响应者链
        self.layer?.mask = nil
        self.layer = nil
        
        //self.animation.delegate = nil
        
        completion?(flag)
    }
    
}
