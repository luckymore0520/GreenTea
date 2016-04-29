//
//  Checkable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

protocol Checkable {
    var isChecked: Bool { get }
    func updateCheckView(view:UIView)
    func updateButton(button:UIButton)
}

extension Checkable {
    func updateCheckView(view:UIView){
        view.hidden = !self.isChecked
    }
    
    func updateButton(button:UIButton){
        button.selected = self.isChecked
    }
}