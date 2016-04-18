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
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension EditUserInfoTableViewController {
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! EditUserInfoTableViewCell
        guard let cellType = cell.cellType else { return }
        switch cellType {
        case .Gender:
            let sexArray = ["男","女"]
            let initialSelection = UserInfoManager.sharedManager.currentUser?.gender?.rawValue == "女" ? 1 : 0
            self.showActionSheet("请选择性别", selectionArray: sexArray, initialSelection: initialSelection, displayLabel:self.genderLabel, selectionHandler: { (selection) -> () in
                let user = UserInfoManager.sharedManager.currentUser
                user?.gender = Gender(rawValue: sexArray[selection])
                user?.saveInBackground()
                }, origin: cell)
        case .Birthday:
            let datePicker = ActionSheetDatePicker(title: "请选择生日", datePickerMode: UIDatePickerMode.Date, selectedDate: NSDate(), doneBlock: {
                picker, value, index in
                let date = value as! NSDate
                self.birthdayLabel.text = "\(date.year)-\(date.month)-\(date.days)"
                let user = UserInfoManager.sharedManager.currentUser
                user?.myBirthday = self.birthdayLabel.text
                user?.saveInBackground()
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
        default:break
        }
    }
    
    func showActionSheet(title:String!,selectionArray:[String],initialSelection:Int,displayLabel:UILabel, selectionHandler:(selection:Int)->(), origin: UIView){
        ActionSheetMultipleStringPicker.showPickerWithTitle(title, rows: [selectionArray], initialSelection: [initialSelection]
            , doneBlock: { picker, values, indexes in
                let result = values as! Array<Int>
                selectionHandler(selection: result[0])
                displayLabel.text = selectionArray[result[0]]
            }, cancelBlock: { ActionMultipleStringCancelBlock in return }, origin: origin)
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
                    user?.saveInBackground()
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
        user?.city = self.cityLabel.text
        user?.saveInBackground()
    }
}
