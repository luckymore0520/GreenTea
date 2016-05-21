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
    @IBOutlet weak var createActivityButton: UIButton!
    var shopInfoDataSource:ShopInfoDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.automaticallyAdjustsScrollViewInsets = false
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
            self.createActivityButton.hidden = false
            self.setRightButton("", imageName: "编辑_白", selector: #selector(ShopInfoViewController.onEditButtonClicked))
        } else {
            self.setRightButton("", imageName: "打电话", selector: #selector(ShopInfoViewController.onCallButtonClicked))
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    @IBAction func onCreateActivityButtonClicked(sender: AnyObject) {
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
