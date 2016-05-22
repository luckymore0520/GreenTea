//
//  MyCardViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Koloda

class MyCardViewController: UIViewController {

    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var currentNumLabel: UILabel!

    var cardDataSource = CardDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        kolodaView.dataSource = cardDataSource
        kolodaView.delegate = self
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MyCardViewController.reloadData), name: "RELOADCARDS", object: nil)
        // Do any additional setup after loading the view.
    }
    
    deinit{
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        self.reloadData()
    }
    
    func reloadData(){
        self.cardDataSource.reloadData()
        self.kolodaView.resetCurrentCardIndex()
        if self.kolodaView.countOfCards > 0 {
            self.currentNumLabel.text = "\(self.kolodaView.currentCardIndex + 1)/\(self.kolodaView.countOfCards)"
        } else {
            self.currentNumLabel.text = ""
        }

    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.kolodaView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSelectedActivity(activityId:String) {
        if self.cardDataSource.moveToCardActivity(activityId) {
            self.kolodaView.resetCurrentCardIndex()
        }

    }
}

extension MyCardViewController {
    @IBAction func onDeleteButtonClicked(sender: AnyObject) {
        let alertController = UIAlertController(title: "你确定要删除这张集点卡吗？", message: nil, preferredStyle: .Alert)
        alertController.addAction(UIAlertAction(title: "确定", style: .Default, handler: { (action) in
            let card = self.cardDataSource.cardList[self.kolodaView.currentCardIndex]
            UserInfoManager.sharedManager.currentUser?.exchangeCard(card.objectId)
            card.delete()
            self.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: nil))
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func onShareButtonClicked(sender: AnyObject) {
        let cardView = kolodaView.viewForCardAtIndex(kolodaView.currentCardIndex) as? CardView
        let card = self.cardDataSource.cardList[kolodaView.currentCardIndex]
        var activityItems:[AnyObject] = ["我在\"\(card.activity.name)\"活动中已经集齐了\(card.currentCount)个点！"]
        if let image = cardView?.imageView.image {
            activityItems.append(image)
        }
        let activityShareController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        self.presentViewController(activityShareController, animated: true, completion: nil)
    }
}

extension MyCardViewController:KolodaViewDelegate {
    func koloda(koloda: KolodaView, didShowCardAtIndex index: UInt) {
        self.currentNumLabel.text = "\(koloda.currentCardIndex + 1)/\(koloda.countOfCards)"
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
    }
}
