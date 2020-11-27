//
//  TransitionType.swift
//  页面跳转显示
//
//  Created by jps on 2020/11/13.
//  Copyright © 2020 jps. All rights reserved.
//

import Foundation
import UIKit

///转场类型
enum TransitionType {
    //导航栏
    case navigation(_ operation: UINavigationController.Operation)
    //tabBar切换
    case tabBar(_ direction: TabBarOperationDirection)
    //模态跳转
    case modal(_ operation: ModalOperation)
}

enum TabBarOperationDirection {
    case left
    case right
}

enum ModalOperation {
    case presentation
    case dismissal
}




