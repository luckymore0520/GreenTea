//
//  ActionSheetTool.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import ActionSheetPicker_3_0

class ActionSheetTool {
    static func showActionSheet(title:String!,selectionArray:[String],initialSelection:Int,displayLabel:UILabel?, selectionHandler:(selection:Int)->(), origin: UIView){
        ActionSheetMultipleStringPicker.showPickerWithTitle(title, rows: [selectionArray], initialSelection: [initialSelection]
            , doneBlock: { picker, values, indexes in
                let result = values as! Array<Int>
                selectionHandler(selection: result[0])
                displayLabel?.text = selectionArray[result[0]]
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: origin)
    }
}