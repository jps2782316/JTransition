//
//  TransitionDetailViewController.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/10.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class TransitionDetailViewController: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var imgBtn: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.yellow.withAlphaComponent(0.7)
        
        imgBtn.alpha = 0
        backBtn.alpha = 0
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        /*
        let backWidthConstraint = backBtn.constraints.filter { (constraint) -> Bool in
            constraint.identifier == "Width"
        }.first
        backWidthConstraint?.constant = view.frame.width / 2.0
        */
        
        imgBtn.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        UIView.animate(withDuration: 0.3, animations: {
            self.imgBtn.transform = .identity
            self.imgBtn.alpha = 1
            self.backBtn.alpha = 1
            //约束动画
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    
    
    @IBAction func backBtnClicked(_ sender: Any) {
        if let navi = self.navigationController {
            navi.popViewController(animated: true)
        }else {
            let rotation = CGAffineTransform(rotationAngle: 3 * .pi)
            rotation.scaledBy(x: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 0.4, animations: {
                self.imgBtn.transform = rotation
                self.imgBtn.alpha = 0
                self.backBtn.alpha = 0
            }, completion: { _ in
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    

}
