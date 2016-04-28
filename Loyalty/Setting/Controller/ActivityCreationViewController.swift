//
//  ActivityCreationViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Eureka
import ActionSheetPicker_3_0

class ActivityCreationViewController: FormViewController,ViewControllerPresentable {
    let activityNameKey = "activityName"
    let activityTypeKey = "activityType"
    let loyaltyCoinMaxCountKey = "loyaltyCoinMaxCount"
    let detailKey = "detail"
    let photoKey = "photo"
    let startDateKey = "startDate"
    let endDateKey = "endDate"
    var shop:Shop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "编辑活动"
        self.initTableView()
        self.configureNavigationItem()
        self.setRightButton("保存", selector: #selector(ActivityCreationViewController.save))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func save(){
        let values = self.form.values()
        guard let shop = self.shop else { return }
        guard let shopName = values[activityNameKey] as? String else {
            HUDHelper.showText("请填写活动名称名称")
            return
        }
        guard let detail = values[detailKey] as? String else {
            HUDHelper.showText("请填写活动描述")
            return
        }
        guard let photo = values[photoKey] as? UIImage else {
            HUDHelper.showText("请上传活动照片")
            return
        }
        let startTime = values[startDateKey] as! NSDate
        let endTime = values[endDateKey] as! NSDate
        let loyaltyMaxCount = (values[loyaltyCoinMaxCountKey] as? String)?.toInt() ?? 0
        let activityType = values[activityTypeKey] as! String
        HUDHelper.showLoading()
        LeanCloudHelper.uploadImage(photo) { (file, errorMsg) in
            guard let file = file else {
                HUDHelper.removeLoading()
                HUDHelper.showText(errorMsg)
                return
            }
            let activity = Activity(shop: shop, name: shopName, startTime: startTime, endTime: endTime, description: detail, avatar: file, activityType: activityType, loyaltyCoinMaxCount: loyaltyMaxCount)
            activity.saveInBackgroundWithBlock({ (success, error) in
                HUDHelper.removeLoading()
                if success {
                    shop.addNewActivity(activity)
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    HUDHelper.showText(NSError.errorMsg(error))
                }
            })
            
        }
 
    }
    
    
    func initTableView(){
        self.tableView?.separatorStyle = .SingleLine
        self.tableView?.backgroundColor = UIColor.globalViewColor()
        self.tableView?.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        let inputPercent: CGFloat = 0.7
        self.form
            +++ Section("基本信息")
            <<< TextRow(activityNameKey) {
                row in
                row.title = "活动名称"
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .None
                    row.textFieldPercentage = inputPercent
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textField.placeholder = "请输入活动名称"
                }.cellUpdate {
                    cell, row in
                    cell.textField.font = UIFont.systemFontOfSize(14)
                    cell.textField.textAlignment = .Right
            }
            <<< LabelRow(activityTypeKey) {
                row in
                row.title = "活动类型"
                row.value = ActivityType.Loyalty.rawValue
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.accessoryType = .DisclosureIndicator
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                }.onCellSelection({ (cell, row) in
                    let activityTypeArray = [ActivityType.Loyalty.rawValue,ActivityType.Promotion.rawValue]
                    ActionSheetTool.showActionSheet("请选择活动类别", selectionArray: activityTypeArray, initialSelection: 0, displayLabel:cell.detailTextLabel, selectionHandler: {
                        (selection) -> () in
                        row.value = activityTypeArray[selection]
                        }, origin: cell)
                })
            <<< LabelRow(loyaltyCoinMaxCountKey) {
                row in
                row.title = "集点点数"
                row.value = "8"
                row.hidden = .Function([activityTypeKey], {
                    [unowned self]
                    form -> Bool in
                    let row: RowOf<String>! = form.rowByTag(self.activityTypeKey)
                    return row.value != ActivityType.Loyalty.rawValue
                })
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.accessoryType = .DisclosureIndicator
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
                }.onCellSelection({ (cell, row) in
                    let coinNumber = ["4","6","8","10"]
                    ActionSheetTool.showActionSheet("请选择集点点数", selectionArray: coinNumber, initialSelection: 0, displayLabel:cell.detailTextLabel, selectionHandler: {
                        (selection) -> () in
                        row.value = coinNumber[selection]
                        }, origin: cell)
                })
            <<< ImageRow(photoKey) {
                row in
                row.title = "活动照片"
                
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textLabel?.textAlignment = .Right
                    cell.height = {
                        return 70
                    }
            }
            +++ Section("活动时间")
            <<< DateRow(startDateKey) {
                row in
                row.title = "开始时间"
                row.value = NSDate()
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textLabel?.textAlignment = .Right
                }
            <<< DateRow(endDateKey) {
                row in
                row.title = "结束时间"
                row.value = NSDate()
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textLabel?.textAlignment = .Right
            }
            +++ Section("店铺详情")
            <<< TextAreaRow(detailKey) {
                row in
                row.title = nil
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .None
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                }.cellUpdate({ (cell, row) in
                    cell.textView.font = UIFont.systemFontOfSize(14)
                    cell.textView.textColor = UIColor.globalGrayColor()
                })
    }

}
