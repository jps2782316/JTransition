//
//  ChatsViewController.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit


class ChatsViewController: UIViewController {
    
    //转场动画
    private let transitionUtil = TransitionUtil()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func modalTransitionClicked(_ sender: Any) {
        let vc = ModalTransitionViewController()
        //设置转场代理(必须在跳转前设置)
        //与容器 VC 的转场的代理由容器 VC 自身的代理提供不同，Modal 转场的代理由 presentedVC 提供
        vc.transitioningDelegate = transitionUtil
        /*
        .FullScreen 的时候，presentingView 的移除和添加由 UIKit 负责，在 presentation 转场结束后被移除，dismissal 转场结束时重新回到原来的位置；
        .Custom 的时候，presentingView 依然由 UIKit 负责，但 presentation 转场结束后不会被移除。
        */
        vc.modalPresentationStyle = .custom
        //animated: 一定要给true，不然不会出现转场动画
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func naviTransitionClicked(_ sender: Any) {
        let vc = NaviTransitionViewController()
        vc.hidesBottomBarWhenPushed = true
        //设置转场代理
        self.navigationController?.delegate = transitionUtil
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
