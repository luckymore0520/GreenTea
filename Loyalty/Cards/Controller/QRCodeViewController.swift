//
//  QRCodeViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/5/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {
    var contentString:String?
    @IBOutlet weak var qrImageView: UIImageView!
    var isExchanged:Bool = false
    var timer:NSTimer?
    
    
    convenience init(contentString:String){
        self.init(nibName: "QRCodeViewController", bundle: nil)
        self.contentString = contentString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.qrImageView.image = UIImage.createQRForString(self.contentString)
        self.view.backgroundColor = UIColor.clearColor()
        self.timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(QRCodeViewController.testIsExchanged), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testIsExchanged(){
        if isExchanged { return }
        guard let contentString = self.contentString else { return }
        Card.queryCardWithId(contentString) { (card) in
            if card == nil {
                UserInfoManager.sharedManager.currentUser?.exchangeCard(contentString)
                NSNotificationCenter.defaultCenter().postNotificationName("RELOADCARDS", object: nil)
                self.isExchanged = true
                self.timer?.invalidate()
                self.timer = nil
                let alertController = UIAlertController(title: "兑换成功", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "关闭", style: .Default, handler: { (alert) in
                    dispatch_async(dispatch_get_main_queue(), {
                        self.onCloseButtonClicked("")
                    });
                }))
                self.presentViewController(alertController, animated: true, completion: nil)            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onExchangeSucceedButtonClicked(sender: AnyObject) {
        self.testIsExchanged()
    }

    @IBAction func onCloseButtonClicked(sender: AnyObject) {
        if nil != self.parentViewController {
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
        } else {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
}
