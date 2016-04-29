//
//  ActivityDetailViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController,HasHiddenNavigation {

    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var toolBar: ActivityToolBar!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var starButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var activityDetailDataSource:ActivityDetailDataSource?
    var activity:Activity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItems()
        if let activity = self.activity {
            self.activityDetailDataSource = ActivityDetailDataSource(tableView: self.tableView, activity: activity)
            self.activityDetailDataSource?.render(self.activityImageView, starButton: self.starButton)
            activity.queryShopInfo({ (shop) in
                self.activityDetailDataSource = ActivityDetailDataSource(tableView: self.tableView, activity: activity)
                self.tableView.reloadData()
            })
            self.updateLikeButton()
            self.toolBar.activityType = activity.activityType ?? .Loyalty
        }
        self.tableView.tableHeaderView?.frame = self.targetImageViewFrame
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
    
    func updateLikeButton(){
        guard let activity = self.activity else { return }
        activity.queryIsLikedBySelf({ (like) in
            self.starButton.selected = like != nil
        })
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
}


extension ActivityDetailViewController:UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.activityDetailDataSource?.heightForRowAtIndexPath(indexPath) ?? 0
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, shouldHighlightRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return self.activityDetailDataSource?.isAbleToSelected(indexPath) ?? true
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.activityDetailDataSource?.heightForHeader(section) ?? 0
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.activityDetailDataSource?.viewForHeader(tableView, section: section)
    }
}

// MARK: - Action
extension ActivityDetailViewController {
    @IBAction func onStarButtonClicked(sender: AnyObject) {
        guard let activity = self.activity else { return }
        activity.queryIsLikedBySelf({ (like) in
            if let like = like {
                like.deleteInBackgroundWithBlock({ (deleted, error) in
                    if deleted {
                        activity.like = nil
                        activity.likeCount -= 1
                        activity.saveInBackground()
                    }
                    self.updateLikeButton()
                })
            } else {
                Like.like(activity, completionHandler: { (like) in
                    activity.like = like
                    self.updateLikeButton()
                })
             }
        })
    }
}

// For Animation
extension ActivityDetailViewController:ImageTransitionTargetViewController {
    var targetImageView:UIImageView {
        get {
            return self.activityImageView
        }
    }
    
    var targetImageViewFrame: CGRect {
        get {
            return CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.width * 8 / 15)
        }
    }
    
    var targetView:UIView {
        get {
            return self.view
        }
    }
}
