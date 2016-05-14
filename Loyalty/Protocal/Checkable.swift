//
//  Checkable.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation

protocol Checkable {
    var isChecked: Bool? { get }
    func updateCheckView(view:UIView)
    func updateButton(button:UIButton)
}

extension Checkable {
    func updateCheckView(view:UIView){
        guard let checked = self.isChecked else { return }
        view.hidden = !checked
    }
    
    func updateButton(button:UIButton){
        guard let checked = self.isChecked else { return }
        button.selected = checked
    }
}