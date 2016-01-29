//
//  RegisterViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/29.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var verifyButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!

    var timer:NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.setDisableStyle()
        self.verifyButton.setDisableStyle()
        self.updateRegisterButtonState()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if UserInfoManager.sharedManager.shouldContinueCountDown() {
            self.phoneTextField.text = UserInfoManager.sharedManager.savedPhoneNumber
            self.startTimer()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.timer?.invalidate()
        self.timer = nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - VerifyCodeTimer
extension RegisterViewController {
    private func startTimer() {
        UserInfoManager.sharedManager.savedPhoneNumber = self.phoneTextField.text
        self.verifyButton.enabled = false
        self.verifyButton.titleLabel?.text = "\(UserInfoManager.sharedManager.verifyRemainTime)s"
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: "update", userInfo: nil, repeats: true)
    }
    
    func update() {
        let remainTime = UserInfoManager.sharedManager.countDown()
        if remainTime <= 0 {
            self.timer?.invalidate()
            self.timer = nil
            self.verifyButton.enabled = true
            self.verifyButton.titleLabel?.text = "验证码"
        } else {
            self.verifyButton.titleLabel?.text = "\(UserInfoManager.sharedManager.verifyRemainTime)s"
        }
    }
}

// MARK: - ButtonAction
extension RegisterViewController {
    @IBAction func onPrivacyButtonClicked(sender: AnyObject) {
        
    }
    
    @IBAction func onRegisterButtonClicked(sender: AnyObject) {
       UserInfoManager.sharedManager.register(phoneTextField.text!, password: passwordTextField.text!, code: codeTextField.text!) { (result, errorMsg) -> Void in
            if (result) {

            } else {
                log.info(errorMsg)
            }
        }
    }
    
    @IBAction func onCheckBoxClicked(sender: UIButton) {
        sender.selected = !sender.selected
        self.updateRegisterButtonState()
    }
    
    @IBAction func onVerifyButtonClicked(sender: UIButton) {
//        UserInfoManager.sharedManager.requestSMSCode(self.phoneTextField.text!) { (result, errorMsg) -> Void in
//            if (result) {
//                
//            } else {
//                log.info(errorMsg)
//            }
//        }
        self.startTimer()
    }
}

// MARK: - TextFieldAction
extension RegisterViewController {
    @IBAction func onTextFieldContentChanged(sender: AnyObject) {
        self.updateRegisterButtonState()
    }
    
}

// MARK: - Private
extension RegisterViewController {
    private func updateRegisterButtonState() {
        self.registerButton.enabled = self.phoneTextField.text?.length > 0 && self.codeTextField.text?.length > 0 && self.codeTextField.text?.length > 0 && self.checkButton.selected
        self.verifyButton.enabled = self.phoneTextField.text?.length > 0 && self.timer == nil
    }
}
