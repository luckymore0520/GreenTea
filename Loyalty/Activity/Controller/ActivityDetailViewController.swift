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
        self.configureToolBar()
        if let activity = self.activity {
            self.activityDetailDataSource = ActivityDetailDataSource(tableView: self.tableView, activity: activity)
            self.activityDetailDataSource?.render(self.activityImageView, starButton: self.starButton)
            activity.queryShopInfo({ (shop) in
                self.activityDetailDataSource = ActivityDetailDataSource(tableView: self.tableView, activity: activity)
                self.tableView.reloadData()
            })
            self.updateLikeButton()
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
    
    func configureToolBar(){
        guard let activity = self.activity else { return }
        guard let activityType = activity.activityType else { return }
        let guideHandler = {
            self.navi()
        }
        let collectHandler = {
            self.collect()
        }
        let getCodeHandler = {
            self.getCode()
        }
        let exChangeHandler = {
            
        }
        switch activityType {
        case .Promotion:
            if activity.isMine {
                self.toolBar.hidden = true
            } else {
                self.toolBar.updateView(imageArray: ["导航"], titleArray: ["导航"], clickHandlers: [guideHandler])
            }
            break
        case .Loyalty:
            if activity.isMine {
                self.toolBar.updateView(imageArray: ["集点","兑换"], titleArray: ["集点","兑换"], clickHandlers: [getCodeHandler,exChangeHandler])
            } else {
                self.toolBar.updateView(imageArray: ["导航","集点"], titleArray: ["导航","集点"], clickHandlers: [guideHandler,collectHandler])
            }
            break
        }
    }
}

// MARK: - ToolBar
extension ActivityDetailViewController {
    
    func getCode(){
        guard let activity = self.activity else { return }
        if activity.isMine {
            HUDHelper.showLoading()
            Coin.requestNewCoin(activity, completionHandler: { (code, errorMsg) in
                HUDHelper.removeLoading()
                guard let code = code else {
                    HUDHelper.showAlert(errorMsg)
                    return }
                HUDHelper.showAlert("您的集点码为:\n\(code)")
            })
        }
    }
    
    func navi(){
        guard let activity = self.activity else { return }
        guard let location = activity.shopInfo?.location else { return }
        guard let locationName = activity.shopInfo?.locationName else { return }
        AMapTool.naviToPOI(locationName, latitute: location.latitude, longitute: location.longitude)
    }
    
    func collect(){
        guard let activity = self.activity else { return }
        guard let user = UserInfoManager.sharedManager.currentUser else {
            HUDHelper.showText("登录后才能进行集点操作")
            return
        }
        if user.hasOwnedCard(activity) {
            showCard(activity.objectId)
        } else {
            let alertView = UIAlertController(title: "您还没有领取该集点卡，是否现在领取？", message: nil, preferredStyle: .Alert)
            alertView.addAction(UIAlertAction(title: "领取", style: UIAlertActionStyle.Default, handler: { (action) in
                HUDHelper.showLoading()
                Card.obtainNewCard(activity, completionHandler: { (card, errorMsg) in
                    HUDHelper.removeLoading()
                    if card != nil {
                        showCard(activity.objectId)
                    } else {
                        HUDHelper.showText(errorMsg)
                    }
                })
            }))
            alertView.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
            self.presentViewController(alertView, animated: false, completion: nil)
        }
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

// MARK: - Action
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
