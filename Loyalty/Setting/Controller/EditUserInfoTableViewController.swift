//
//  EditUserInfoTableViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class EditUserInfoTableViewController: UITableViewController,ViewControllerPresentable {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItem()
        self.fillUserInfo()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    func fillUserInfo(){
        guard let user = UserInfoManager.sharedManager.currentUser else { return }
        self.nicknameLabel.text = user.nickName
        self.genderLabel.text = user.sex
        self.birthdayLabel.text = user.birthday
        self.cityLabel.text = user.currentCity
        self.phoneNumLabel.text = user.username
        self.avatarImageView.setImageWithUrlString(user.avatar?.url)
    }

}

extension EditUserInfoTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EditUserInfoTableViewCell
        let user = UserInfoManager.sharedManager.currentUser
        guard let cellType = cell.cellType else { return }
        switch cellType {
        case .Gender:
            let sexArray = ["男","女"]
            let initialSelection = UserInfoManager.sharedManager.currentUser?.sex == "女" ? 1 : 0
            ActionSheetTool.showActionSheet("请选择性别", selectionArray: sexArray, initialSelection: initialSelection, displayLabel:self.genderLabel, selectionHandler: {
                (selection) -> () in
                user?.sex = sexArray[selection]
                user?.saveInBackgroundAndChange()
                }, origin: cell)
        case .Birthday:
            let datePicker = ActionSheetDatePicker(title: "请选择生日", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
                [unowned self]
                picker, value, index in
                let date = value as! NSDate
                self.birthdayLabel.text = "\(date.year)-\(date.month)-\(date.days)"
                user?.birthday = self.birthdayLabel.text
                user?.saveInBackgroundAndChange()
                return
                }, cancelBlock: { ActionStringCancelBlock in return }, origin:self.view)
            datePicker.showActionSheetPicker()
            break;
        case .City:
            let cityViewController = CityViewController()
            cityViewController.delegate = self
            let navigationController = UINavigationController(rootViewController: cityViewController)
            cityViewController.setLeftButton("取消", selector: #selector(CityViewController.cancelSelect))
            self.presentViewController(navigationController, animated: true, completion: nil)
            break;
        case .Avatar:
            ImagePickerManager.sharedManager.showCameraPicker(self, delegate: self, withEditing: true)
            break;
        case .Nickname:
            OneRowEditInfoViewController.jumpTo(self.navigationController, titleName: "编辑昵称", typeName: "昵称", defaultContent: user?.nickName, completionHandler: {
                [unowned self]
                (content) in
                self.nicknameLabel.text = content
                user?.nickName = content
                user?.saveInBackgroundAndChange()
                self.navigationController?.popViewControllerAnimated(true)
            })
        default:break
        }
    }
}

extension EditUserInfoTableViewController:ImagePickerDelegate {
    func receiveImageArray(imageArray: Array<UIImage>) {
        if let image = imageArray.first {
            self.avatarImageView.image = image
            HUDHelper.showLoading()
            LeanCloudHelper.uploadImage(image, completionHandler: { (file, errorMsg) in
                HUDHelper.removeLoading()
                if let file = file {
                    let user = UserInfoManager.sharedManager.currentUser
                    user?.avatar = file
                    user?.saveInBackgroundAndChange()
                } else {
                    HUDHelper.showText(errorMsg)
                }
            })
        }
    }
}

extension EditUserInfoTableViewController:CityViewControllerDelegate {
    func selectCity(city: String) {
        self.cityLabel.text = city
        let user = UserInfoManager.sharedManager.currentUser
        user?.currentCity = self.cityLabel.text
        user?.saveInBackgroundAndChange()
    }
}
