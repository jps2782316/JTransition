//
//  ContactsViewController.swift
//  Transition
//
//  Created by jps on 2020/11/16.
//  Copyright © 2020 jps. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController {
    
    let demoUtil = TransitionDemoUtil()
    
    @IBOutlet weak var circelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    @IBAction func demo1Clicked(_ sender: Any) {
        let vc = TransitionDetailViewController()
        demoUtil.demo = 0
        vc.transitioningDelegate = demoUtil
        vc.modalPresentationStyle = .custom
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func demo2Clicked(_ sender: UIButton) {
        let vc = Demo2ViewController()
        let center = sender.superview?.convert(sender.center, to: self.view)
        demoUtil.startPoint = center
        demoUtil.demo = 1
        vc.transitioningDelegate = demoUtil
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func demo3Clicked(_ sender: UIButton) {
        let vc = Demo2ViewController()
        let center = sender.superview?.convert(sender.center, to: self.view)
        demoUtil.startPoint = center
        demoUtil.demo = 2
        vc.transitioningDelegate = demoUtil
        vc.modalPresentationStyle = .custom
        vc.modalPresentationCapturesStatusBarAppearance = true
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func demo4Clikced(_ sender: Any) {
    }
    
    @IBAction func demo5Clikced(_ sender: Any) {
    }
    
    
    @IBAction func circleBtnClick(_ sender: Any) {
        
    }
    
    

}
