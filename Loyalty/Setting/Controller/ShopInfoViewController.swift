//
//  ShopInfoViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ShopInfoViewController: UIViewController {

    @IBOutlet weak var shopImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    var shop:Shop?
    var shopInfoDataSource:ShopInfoDataSource?
    @IBOutlet weak var toolBar: ActivityToolBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        self.reloadComments()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        guard let shop = self.shop else { return }
        self.shopInfoDataSource = ShopInfoDataSource(shop: shop, tableView: tableView)
        self.shopInfoDataSource?.render(self.shopImageView)
        self.title = shop.isMine() ? "我的店铺" : shop.shopName
        if shop.isMine() {
            self.toolBar.updateView(imageArray: ["发布活动"], titleArray: ["发布活动"], clickHandlers: [{
                    self.onCreateActivityButtonClicked()
                }])
            self.setRightButton("", imageName: "编辑_白", selector: #selector(ShopInfoViewController.onEditButtonClicked))
        } else {
            self.toolBar.updateView(imageArray: ["发布活动"], titleArray: ["评价"], clickHandlers: [{
                self.onPublishCommentButtonClicked()
                }])
            self.setRightButton("", imageName: "打电话", selector: #selector(ShopInfoViewController.onCallButtonClicked))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadComments(){
        guard let shop = self.shop else { return }
        Comment.queryComment(shop.objectId) { (comment) in
            shop.comments = comment ?? []
            self.reloadDate()
        }
    }
    
    func reloadDate(){
        guard let shop = self.shop else { return }
        self.shopInfoDataSource = ShopInfoDataSource(shop: shop, tableView: tableView)
        self.tableView.reloadData()
    }
    
    func onCallButtonClicked(){
        guard let phoneNumber = self.shop?.phoneNumber else { return }
        let callCommentString = "tel://\(phoneNumber)"
        if let url = NSURL(string: callCommentString) {
            UIApplication.sharedApplication().openURL(url)
        }
    }
 
    func onEditButtonClicked(){
        guard let shop = self.shop else { return }
        if shop.isMine() {
            
        }
    }
    
    static func jumpToShopViewController(shop:Shop?, fromViewController:UINavigationController?){
        guard let shop = shop else { return }
        if shop.isKindOfClass(Shop.classForCoder()) {
            let shopViewController = ShopInfoViewController(nibName: "ShopInfoViewController", bundle: nil)
            shopViewController.shop = shop
            shopViewController.hidesBottomBarWhenPushed = true
            fromViewController?.pushViewController(shopViewController, animated: true)
        }
    }
    
    func onPublishCommentButtonClicked(replyId:String? = nil, replyName:String? = nil) {
        PublishCommentViewController.startPublish(self, withRate: replyName == nil) { (content, rate) in
            guard let shop = self.shop else { return}
            HUDHelper.showLoading()
            Comment.publishComment(shop, rate:rate, replyId: replyId, replyName: replyName, content: content, completionHandler: { (success, errorMsg) in
                HUDHelper.removeLoading()
                if success {
                    HUDHelper.showText("发布成功")
                    self.reloadComments()
                } else {
                    HUDHelper.showText(errorMsg)
                }
            })
        }
    }
    
    func onCreateActivityButtonClicked() {
        let activityCreationViewController = ActivityCreationViewController()
        activityCreationViewController.shop = self.shop
        let navigationViewController = UINavigationController(rootViewController: activityCreationViewController)
        self.presentViewController(navigationViewController, animated: true, completion: nil)
    }
}

extension ShopInfoViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let object = self.shopInfoDataSource?.objectForRowAtIndexPath(indexPath)
        if let activity = object as? Activity {
            ActivityDetailViewController.jumpTo(activity, navigationController: self.navigationController)
        } else if let rowType = object as? ShopInfoRowType {
            switch rowType {
            case .LocationInfo:
                guard let shop = self.shop else { return }
                AMapTool.naviToPOI(shop.locationName, latitute: shop.location.latitude, longitute: shop.location.longitude)
            default:
                break
            }
        } else if let comment = object as? Comment {
            self.onPublishCommentButtonClicked(comment.userId,replyName:comment.userNickname)
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.shopInfoDataSource?.heightForHeader(section) ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.shopInfoDataSource?.viewForHeader(tableView, section: section)
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.shopInfoDataSource?.heightForRowAtIndexPath(indexPath) ?? 0
    }
}
