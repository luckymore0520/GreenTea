//
//  UserSettingViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/2/1.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class UserSettingViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
     /// Header
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var cardCountLabel: UILabel!
    @IBOutlet weak var collectionCountLabel: UILabel!
     /// ViewModel
    var userViewModel:UserInfoViewModel?
    
    
    var tableViewModel:UserSettingTableModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.avatarImageView.layer.borderColor = UIColor.whiteColor().CGColor
        self.tableViewModel = UserSettingTableModel(tableView: self.tableView)
        self.userViewModel = UserInfoViewModel(user: UserInfoManager.sharedManager.currentUser)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.fillUserInfo()
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillUserInfo(){
        self.userViewModel?.updateTitleLabel(self.nicknameLabel)
        self.userViewModel?.updateImageView(self.avatarImageView)
    }
}


extension UserSettingViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.clearColor()
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if let settingCellAction = self.tableViewModel?.settingCellArray[indexPath.section][indexPath.row] {
            switch settingCellAction {
            case .BecomeBusiness:
                let shopCreationViewController = ShopCreationViewController()
                shopCreationViewController.hidesBottomBarWhenPushed = true
                self.navigationController?.pushViewController(shopCreationViewController, animated: true)
            case .Logout:
                self.tryLogout()
            default:
                break
            }
        }
        
    }
}


extension UserSettingViewController {
    private func tryLogout(){
        let alertController = UIAlertController(title: "登出", message: "你确定要退出登录吗？", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Destructive, handler: { (action) -> Void in
            UserInfoManager.sharedManager.logout()
            self.tabBarController?.selectedIndex = 0
        }))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}
