//
//  LoginViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/1/28.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loginButton.setDisableStyle()
        self.setRightButton("注册", selector: Selector("onRegisterButtonClicked"))
        self.setLeftButton("取消", selector: Selector("onCancelButtonClicked"))
        self.updateLoginButtonState()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - TextFieldAction
extension LoginViewController {
    @IBAction func onTextFieldContentChanged(sender: AnyObject) {
        self.updateLoginButtonState()
    }
}

// MARK: - Private
extension LoginViewController {
    private func updateLoginButtonState() {
        self.loginButton.enabled = self.phoneTextField.text?.length > 0 && self.passwordTextField.text?.length > 0
    }
}



// MARK: - Selector
extension LoginViewController {
    @IBAction func onLoginButtonClicked(sender: AnyObject) {
        if let phoneNum = self.phoneTextField.text, password = self.passwordTextField.text {
            UserInfoManager.sharedManager.login(phoneNum, password: password) { (result, errorMsg) -> Void in
                if (result) {
                    self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    log.info(errorMsg)
                }
            }
        }
    }
    
    func onRegisterButtonClicked() {
        self.performSegueWithIdentifier(String(RegisterViewController.classForCoder()), sender: nil)
    }
    
    func onCancelButtonClicked() {
        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
