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
    
    convenience init(contentString:String){
        self.init(nibName: "QRCodeViewController", bundle: nil)
        self.contentString = contentString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.qrImageView.image = UIImage.createQRForString(self.contentString)
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
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
    @IBAction func onExchangeSucceedButtonClicked(sender: AnyObject) {
        
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
