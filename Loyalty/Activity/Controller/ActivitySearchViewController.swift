//
//  ActivitySearchViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/5/22.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Cartography



class ActivitySearchViewController: UIViewController {
    var searchBar:UISearchBar?
    var activityListViewController:ActivityListViewController?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSerach()
        // Do any additional setup after loading the view.
    }

    func initSerach(){
        self.searchBar = UISearchBar()
        self.searchBar?.delegate = self
        self.searchBar?.showsCancelButton = true
        self.navigationItem.titleView = self.searchBar
        let storyboard = UIStoryboard(name: "ActivityStoryboard", bundle: nil)
        let activityViewController = storyboard.instantiateViewControllerWithIdentifier(String(ActivityListViewController.classForCoder())) as! ActivityListViewController
        activityViewController.keyword = ""
        self.view.addSubview(activityViewController.view)
        self.addChildViewController(activityViewController)
        constrain(activityViewController.view,self.view) {
            view,parentView in
            view.top == parentView.top
            view.left == parentView.left
            view.right == parentView.right
            view.bottom == parentView.bottom
        }

        self.activityListViewController = activityViewController
    }
    
       override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
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

extension ActivitySearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    // MARK: - UISearchBar Delegate
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.activityListViewController?.keyword = searchText
    }
}



