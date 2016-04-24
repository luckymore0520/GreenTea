//
//  ShopCreationViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/20.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Eureka



class ShopCreationViewController: FormViewController {
    let shopNameKey = "shopName"
    let phoneNumberKey = "phoneNumber"
    let locationNameKey = "location"
    let detailKey = "detail"
    let photoKey = "photo"
    
    var shopLocation:CLLocationCoordinate2D?
    var shopAddress:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "创建店铺"
        self.initTableView()
        self.setRightButton("保存", selector: #selector(ShopCreationViewController.save))
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func save(){
        let values = self.form.values()
        guard let shopName = values[shopNameKey] as? String else {
            HUDHelper.showText("请填写店铺名称")
            return
        }
        guard let phoneNumber = values[phoneNumberKey] as? String else {
            HUDHelper.showText("请填写联系方式")
            return
        }
        guard let detail = values[detailKey] as? String else {
            HUDHelper.showText("请填写商店描述")
            return
        }
        guard let photo = values[photoKey] as? UIImage else {
            HUDHelper.showText("请上传店铺照片")
            return
        }
        guard let shopAddress = self.shopAddress else {
            HUDHelper.showText("请选择店铺地址")
            return
        }
        HUDHelper.showLoading()
        LeanCloudHelper.uploadImage(photo) { (file, errorMsg) in
            guard let file = file else {
                HUDHelper.removeLoading()
                HUDHelper.showText(errorMsg)
                return
            }
            let shop = Shop(shopName: shopName, location: CGPointMake(CGFloat(self.shopLocation?.latitude ?? 0), CGFloat(self.shopLocation?.longitude ?? 0)), locationName: shopAddress, phoneNumber: phoneNumber, description: detail, avatar: file)
            shop.saveInBackgroundWithBlock({ (success, error) in
                HUDHelper.removeLoading()
                if success {
                    let user =  UserInfoManager.sharedManager.currentUser
                    user?.userTypeString = UserType.Business.rawValue
                    user?.shop = shop
                    user?.saveInBackgroundAndChange()
                    self.navigationController?.popViewControllerAnimated(true)
                } else {
                    let errorMsg = NSError.errorMsg(error)
                    HUDHelper.showText(errorMsg)
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
            <<< TextRow(shopNameKey) {
                row in
                row.title = "店铺名称"
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .None
                    row.textFieldPercentage = inputPercent
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textField.placeholder = "请输入店铺名称"
                }.cellUpdate {
                    cell, row in
                    cell.textField.font = UIFont.systemFontOfSize(14)
                    cell.textField.textAlignment = .Right
            }
            <<< PhoneRow(phoneNumberKey) {
                row in
                row.title = "电话号码"
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .None
                    row.textFieldPercentage = inputPercent
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.textField.placeholder = "请输入电话号码"
                }.cellUpdate {
                    cell, row in
                    cell.textField.font = UIFont.systemFontOfSize(14)
                    cell.textField.textAlignment = .Right
            }
            <<< LabelRow(locationNameKey) {
                row in
                row.title = "店铺地址"
                }.cellSetup {
                    cell, row in
                    cell.selectionStyle = .Default
                    cell.textLabel?.font = UIFont.systemFontOfSize(15)
                    cell.tintColor = UIColor.globalTitleBrownColor()
                    cell.accessoryType = .DisclosureIndicator
                    cell.detailTextLabel?.font = UIFont.systemFontOfSize(14)
            }.onCellSelection({ (cell, row) in
                let locationPickerViewController = LocationPickerViewController(nibName: "LocationPickerViewController", bundle: nil)
                locationPickerViewController.pickCompletion = {
                    [unowned self]
                    location,address in
                    self.shopLocation = location
                    self.shopAddress = address
                    row.value = address
                }
                self.navigationController?.pushViewController(locationPickerViewController, animated: true)
            })
            <<< ImageRow(photoKey) {
                row in
                row.title = "店铺照片"
                
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
