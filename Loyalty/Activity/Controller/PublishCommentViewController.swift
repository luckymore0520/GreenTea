//
//  PublishCommentViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/5/21.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class PublishCommentViewController: UIViewController,ViewControllerPresentable {
    
    @IBOutlet weak var startViewHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var starRateView: StartRateView!
    @IBOutlet weak var textView: UITextView!
    var completionHandler:((content:String,rate:Int)->Void)?
    var withRate:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "发布评论"
        self.starRateView.changable = true
        self.startViewHeightConstant.constant = withRate ? 35 : 0
        self.starRateView.hidden = !withRate
        self.textView.layer.borderColor = UIColor.globalGrayColor().CGColor
        self.textView.layer.borderWidth = 1.0
        self.configureNavigationItem()
        self.setRightButton("发布", selector: #selector(PublishCommentViewController.publish))
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func startPublish(viewController:UIViewController?,withRate:Bool = true, completionHandler:(content:String,rate:Int)->Void) {
        let publishViewController = PublishCommentViewController(nibName: "PublishCommentViewController", bundle: nil)
        publishViewController.withRate = withRate
        publishViewController.completionHandler = completionHandler
        let navigationController = UINavigationController(rootViewController: publishViewController)
        viewController?.presentViewController(navigationController, animated: true, completion: nil)
    }
    
    func publish(){
        self.dismissViewControllerAnimated(true) { 
            if let completionHandler = self.completionHandler {
                completionHandler(content: self.textView.text, rate:self.withRate ? self.starRateView.currentStar() : 0)
            }
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

}
