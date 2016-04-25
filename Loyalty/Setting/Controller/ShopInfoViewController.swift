//
//  ShopInfoViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/24.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ShopInfoViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var shop:Shop?
    var shopInfoDataSource:ShopInfoDataSource?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        guard let shop = self.shop else { return }
        self.shopInfoDataSource = ShopInfoDataSource(shop: shop, tableView: tableView)
        self.title = shop.isMine() ? "我的店铺" : shop.shopName
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
 
    
    static func jumpToShopViewController(shop:Shop?, fromViewController:UINavigationController?){
        guard let shop = shop else { return }
        if shop.isKindOfClass(Shop.classForCoder()) {
            let shopViewController = ShopInfoViewController(nibName: "ShopInfoViewController", bundle: nil)
            shopViewController.shop = shop
            fromViewController?.pushViewController(shopViewController, animated: true)
        }
    }
}

extension ShopInfoViewController:UITableViewDelegate {
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
