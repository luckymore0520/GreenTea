//
//  OneRowEditInfoViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class OneRowEditInfoViewController: UIViewController {
    @IBOutlet weak var editAreaView: UIView!
    @IBOutlet weak var editTypeLabel: UILabel!
    @IBOutlet weak var editContentTextField: UITextField!
    var completionHandler:((content:String)->Void)?
    
    var typeName:String?
    var defaultContent:String?
    
    func setup(){
        self.editTypeLabel.text = typeName ?? ""
        self.editContentTextField.text = defaultContent ?? ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.translucent = false
        self.editAreaView.layer.borderColor = UIColor.globalGrayColor().CGColor
        self.editAreaView.layer.borderWidth = 0.5
        self.setRightButton("保存", selector: #selector(OneRowEditInfoViewController.onSaveButtonClicked))
        self.setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func onSaveButtonClicked(){
        guard let completionHandler = self.completionHandler else { return }
        if self.editContentTextField.text?.length < 0 {
            HUDHelper.showText("内容不能为空")
        } else {
            completionHandler(content: self.editContentTextField.text!)
        }
    }
    
    static func jumpTo(navigationController:UINavigationController?,titleName:String,typeName:String,defaultContent:String?,completionHandler:(content:String)->Void) {
        let oneRowEditViewController = OneRowEditInfoViewController(nibName: "OneRowEditInfoViewController", bundle: nil)
        oneRowEditViewController.completionHandler = completionHandler
        oneRowEditViewController.defaultContent = defaultContent
        oneRowEditViewController.typeName = typeName
        oneRowEditViewController.title = titleName
        navigationController?.pushViewController(oneRowEditViewController, animated: true)
    }
}
