//
//  QRScannerViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/5/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import AVFoundation

class QRScannerViewController: UIViewController,HasHiddenNavigation {

    @IBOutlet weak var scanOfflineConstraint: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var previewView: UIView!
    @IBOutlet weak var scanView: UIView!
    var captureSession:AVCaptureSession?
    var videoPreviewLayer:AVCaptureVideoPreviewLayer?
    var timer:NSTimer?
    var isHandling:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureNavigationItems()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.startScanningAnimation()
        self.captureSession?.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.stopScanningAnimation()
        self.captureSession?.stopRunning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if self.captureSession == nil {
            self.initQRView()
        }
    }

    
    func startScanningAnimation(){
        if self.timer == nil {
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(QRScannerViewController.updateScanningAnimation), userInfo: nil, repeats: true)
        }
    }
    
    func stopScanningAnimation(){
        self.timer?.invalidate()
        self.timer = nil
        self.scanView.layoutIfNeeded()
    }
    
    func updateScanningAnimation(){
        let offSet = self.scanOfflineConstraint.constant
        let height = self.scanView.frame.size.height - 5
        self.scanOfflineConstraint.constant = (offSet + 2) % height
        self.scanView.layoutIfNeeded()
    }
    
    func initQRView(){
        let captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        var input:AVCaptureDeviceInput?
        do{
            input = try
                AVCaptureDeviceInput(device: captureDevice)
        } catch let error as NSError {
            log.info("Could not create audio player: \(error)")
        }
        
        
        self.captureSession = AVCaptureSession()
        captureSession?.addInput(input)
        
        let captureMetaDataOutput = AVCaptureMetadataOutput()
        captureSession?.addOutput(captureMetaDataOutput)
    
        let dispatchQueue = dispatch_queue_create("myQueue", nil);
        captureMetaDataOutput.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        captureMetaDataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
        
        self.videoPreviewLayer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        self.videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.videoPreviewLayer?.frame = self.previewView.layer.bounds
        self.previewView.layer.addSublayer(self.videoPreviewLayer!)
        self.captureSession?.startRunning()
        

        let translucentBlackLayer = CALayer()
        translucentBlackLayer.position = CGPointMake(self.view.bounds.size.width / 2.0, self.view.bounds.size.height / 2.0 )
        translucentBlackLayer.bounds = self.view.bounds
        translucentBlackLayer.backgroundColor = UIColor.blackColor().CGColor
        translucentBlackLayer.opacity = 0.5
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.position = translucentBlackLayer.position
        maskLayer.bounds = translucentBlackLayer.bounds
        let path = UIBezierPath(rect: self.scanView.frame)
        path.appendPath(UIBezierPath(rect: maskLayer.bounds))
        maskLayer.path = path.CGPath
        maskLayer.fillRule = kCAFillRuleEvenOdd
        translucentBlackLayer.mask = maskLayer
        self.previewView.layer.addSublayer(translucentBlackLayer)
    }
}

extension QRScannerViewController:AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        
        if (isHandling) {
            return;
        }
        isHandling = true;
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaDataObject = metadataObjects[0]
            dispatch_async(dispatch_get_main_queue(), {
                log.info("处理结果")
                self.parseScanResult(metaDataObject.stringValue)
            });

        }
        
    }

    func parseScanResult(code:String?){
        log.info(code)
        guard let code = code else { return }
        Card.queryCardWithId(code) { (card) in
            if let card = card {
                if card.isFull {
                    self.captureSession?.stopRunning()
                    let alertController = UIAlertController(title: "兑换成功", message: "活动名称:\(card.activity.name)", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "兑换", style: .Default, handler: { (action) in
                       card.delete()
                       self.navigationController?.popViewControllerAnimated(true)
                    }));
                    alertController.addAction(UIAlertAction(title: "取消", style: .Cancel, handler: { (action) in
                        self.captureSession?.startRunning()
                    }))
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}
