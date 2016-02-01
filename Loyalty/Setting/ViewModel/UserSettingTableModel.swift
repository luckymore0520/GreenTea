//
//  UserSettingTableModel.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

enum SettingCellType:String {
    case ChangePassword = "修改密码"
    case BecomeBusiness = "成为商家"
    case ShareApp = "分享应用"
    case ReviewUs = "评价我们"
    case FeedBack = "意见反馈"
    case Privacy = "用户条款"
    case Logout = "退出登录"
}

class UserSettingTableModel:NSObject {
    var settingCellArray:[Array<SettingCellType>]!
    weak var tableView:UITableView?
    init(tableView:UITableView){
        super.init()
        if let user = UserInfoManager.sharedManager.currentUser() {
            if user.userType == UserType.Custume {
                self.settingCellArray = [[SettingCellType.ChangePassword,.BecomeBusiness],[.ShareApp,.ReviewUs,.FeedBack,.Privacy],[.Logout]]
            } else {
                self.settingCellArray = [[SettingCellType.ChangePassword,.BecomeBusiness],[.ShareApp,.ReviewUs,.FeedBack,.Privacy],[.Logout]]
            }
        } else {
            settingCellArray = []
        }
        self.tableView = tableView
        self.tableView?.dataSource = self
    }
}

extension UserSettingTableModel:UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.settingCellArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.settingCellArray[section].count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(indexPath: indexPath) as UserSettingTableViewCell;
        let viewModel = UserSettingCellViewModel(type: self.settingCellArray[indexPath.section][indexPath.row])
        cell.configureCell(viewModel)
        return cell
    }
}

