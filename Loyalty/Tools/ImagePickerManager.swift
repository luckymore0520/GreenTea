//
//  ImagePickerManager.swift
//  MiCourse
//
//  Created by luck-mac on 15/12/6.
//  Copyright © 2015年 KeJian. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerDelegate {
    func receiveImageArray(imageArray:Array<UIImage>)
}

private let sharedInstance = ImagePickerManager()
class ImagePickerManager: NSObject{
    var targetViewController:UIViewController?
    var delegate:ImagePickerDelegate?
    var withEditing:Bool
    class var sharedManager : ImagePickerManager {
        return sharedInstance
    }
    
    override init() {
        self.withEditing = false
        super.init()
    }
    
    func showCameraPicker(targetVC:UIViewController, delegate:ImagePickerDelegate,withEditing:Bool) {
        self.targetViewController = targetVC
        self.delegate = delegate
        self.withEditing = withEditing
        let actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从相册选择")
        actionSheet.showInView(targetViewController!.view)
    }
    
}

extension ImagePickerManager:UIActionSheetDelegate {
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if buttonIndex == 0 {
            return;
        } else {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = self.withEditing
            imagePicker.sourceType = buttonIndex == 1 ? UIImagePickerControllerSourceType.Camera : UIImagePickerControllerSourceType.SavedPhotosAlbum
            self.targetViewController!.presentViewController(imagePicker, animated: true, completion: nil)
            
        }
    }
}

extension ImagePickerManager:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.imagePickerControllerDidCancel(picker)
        self.delegate!.receiveImageArray([image])
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.targetViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}