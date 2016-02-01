//
//  HUDHelper.swift
//  MiCourse
//
//  Created by luck-mac on 15/12/10.
//  Copyright © 2015年 KeJian. All rights reserved.
//

import Foundation
import PKHUD

class HUDHelper {
    static func showLoading(){
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show()
    }
    
    static func removeLoading(){
        PKHUD.sharedHUD.hide()
    }
    
    static func showText(text:String!){
        PKHUD.sharedHUD.contentView = PKHUDTextView(text: text)
        PKHUD.sharedHUD.show()
    }
}