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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.registerButton.setDisableStyle()
        self.verifyButton.setDisableStyle()
        self.updateRegisterButtonState()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - ButtonAction
extension RegisterViewController {
    @IBAction func onPrivacyButtonClicked(sender: AnyObject) {
    }
    
    @IBAction func onRegisterButtonClicked(sender: AnyObject) {
        UserInfoManager.sharedManager.verifySMSCode(self.phoneTextField.text!, code: self.codeTextField.text!) { (result, errorMsg) -> Void in
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
        UserInfoManager.sharedManager.requestSMSCode(self.phoneTextField.text!) { (result, errorMsg) -> Void in
            if (result) {
                
            } else {
                log.info(errorMsg)
            }
        }
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
        self.verifyButton.enabled = self.phoneTextField.text?.length > 0
    }
}
