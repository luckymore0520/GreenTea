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
        self.automaticallyAdjustsScrollViewInsets = false
        guard let shop = self.shop else { return }
        self.shopInfoDataSource = ShopInfoDataSource(shop: shop, tableView: tableView)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    
    static func jumpToShopViewController(shop:Shop, fromViewController:UINavigationController?){
        let shopViewController = ShopInfoViewController(nibName: "ShopInfoViewController", bundle: nil)
        shopViewController.shop = shop
        fromViewController?.pushViewController(shopViewController, animated: true)
    }
}
