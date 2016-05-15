//
//  CardView.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loyaltyCoinCollectionView: UICollectionView!
    var coinDataSource:LoyaltyCoinDataSource?
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    var card:Card?
    
    func renderView(card:Card){
        self.collectionViewFlowLayout.itemSize = CGSizeMake(self.loyaltyCoinCollectionView.frame.width / 4.0 , 50)
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionViewFlowLayout.minimumLineSpacing = 20
        let cardViewModel = CardViewModel(card: card)
        self.coinDataSource = LoyaltyCoinDataSource(collectionView: loyaltyCoinCollectionView,ratioPresentable: cardViewModel)
        cardViewModel.updateImageView(self.imageView)
        cardViewModel.updateTitleLabel(self.nameLabel)
        cardViewModel.updateDetailLabel(self.detailLabel)
        cardViewModel.updateLocationLabel(self.locationLabel)
        self.card = card
    }
    
    func reloadCollectionView(){
        guard let card = self.card else { return }
        let cardViewModel = CardViewModel(card: card)
        self.coinDataSource = LoyaltyCoinDataSource(collectionView: loyaltyCoinCollectionView,ratioPresentable: cardViewModel)
        self.loyaltyCoinCollectionView.reloadData()
    }

    @IBAction func onCollectionViewTapped(sender: AnyObject) {
        log.info("集点")
        if self.card?.isFull ?? true {
            return
        }
        let alertController = UIAlertController(title: "请输入集点码", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler { (textField) in
            textField.borderStyle = UITextBorderStyle.None
            textField.keyboardType = UIKeyboardType.NumberPad
            textField.font = UIFont.systemFontOfSize(30)
            textField.textAlignment = NSTextAlignment.Center
        }
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.Default, handler: { (action) in
            guard let code = alertController.textFields?[0].text else { return }
            HUDHelper.showLoading()
            self.card?.collect(code, completionHandler: { (success) in
                HUDHelper.removeLoading()
                if success {
                    log.info("集点成功")
                    self.reloadCollectionView()
                } else {
                    HUDHelper.showText("集点码无效，请重新输入")
                }
            })
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil))
        self.viewController()?.presentViewController(alertController, animated: true, completion: nil)
    }
    
}


