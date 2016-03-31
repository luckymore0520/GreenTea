//
//  ActivityDetailViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var activityDetailViewModel:ActivityDetailViewModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.activityDetailViewModel = ActivityDetailViewModel(tableView: self.tableView, activity: Activity())
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}

