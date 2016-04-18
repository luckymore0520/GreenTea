//
//  UIView.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func traverseResponderChainForUIViewController() -> UIViewController?{
        let nextResponse = self.nextResponder()
        if let nextResponseViewController = nextResponse as? UIViewController {
            return nextResponseViewController
        }
        if let nextResponseView = nextResponse as? UIView {
            return nextResponseView.traverseResponderChainForUIViewController()
        }
        return nil
        
    }
    
    func viewController()->UIViewController? {
        return self.traverseResponderChainForUIViewController()
    }
}