//
//  Notes.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation

/*
https://www.cnblogs.com/hualuoshuijia/p/9945604.html

iOS 视图控制器转场详解. 唐巧的博客
https://blog.devtang.com/2016/03/13/iOS-transition-guide/
 
 动效拆解工厂：Mask 动画
 https://www.jianshu.com/p/3c925a1609f8
*/



/*
 //系统自带的有四种动画:
 public enum UIModalTransitionStyle : Int {
     
     case coverVertical // 默认 底部滑入

     case flipHorizontal //水平翻转

     case crossDissolve //渐隐

     @available(iOS 3.2, *)
     case partialCurl //翻页
 }
 */

/*
 尽管三大转场代理协议的方法不尽相同，但它们返回的动画控制器遵守的是同一个协议(UIViewControllerAnimatedTransitioning)
 
 */

/*
 转场类型: (前两种都属于容器VC转场，而modal不是)
 UINavigationController转场: push、pop
 UITabBarController转场: Tab切换
 Modal转场: presentation、dismissal
 
 
 转场本质:
 转场过程中，作为容器的父 VC 维护着多个子 VC，但在视图结构上，只保留一个子 VC 的视图，所以转场的本质是下一场景(子VC)的视图替换当前场景(子 VC)的视图以及相应的控制器(子 VC)的替换，表现为当前视图消失和下一视图出现，基于此进行动画，动画的方式非常多，所以限制最终呈现的效果就只有你的想象力了
 转场动画的本质是是对即将消失的当前视图和即将出现的下一屏幕的内容进行动画
 
 转场结果:
 非交互转场: 完成
 交互式转场: 完成、取消
 */


/*
 A控制器present出B控制器，此时transitionContext取到的fromVC为A
 B控制器dismiss回A控制器，此时transitionContext的fromVC为B
 */


/*
 对于交互式转场，交互手段只是表现形式，本质是驱动转场进程。
 
 交互转场的限制:
 如果希望转场中的动画能完美地被交互控制
 如果你希望制作多阶段动画，在某个动画结束后再执行另外一段动画，可以通过 UIView Block Animation 的 completion 闭包来实现动画链，或者是通过设定动画执行的延迟时间使得不同动画错分开来，但是交互转场不支持这两种形式。UIView 的 keyFrame Animation API 可以帮助你，通过在动画过程的不同时间节点添加关键帧动画就可以实现多阶段动画。我实现过一个这样的多阶段转场动画
 */
