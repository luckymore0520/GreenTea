//
//  CardView.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class CardView: UIView {

    @IBOutlet weak var loyaltyCoinCollectionView: UICollectionView!
    var coinDataSource:LoyaltyCoinDataSource?
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    
    func renderView(){
        
        self.collectionViewFlowLayout.itemSize = CGSizeMake(self.loyaltyCoinCollectionView.frame.width / 4.0 , 50)
        self.collectionViewFlowLayout.minimumInteritemSpacing = 0
        self.collectionViewFlowLayout.minimumLineSpacing = 20
        self.coinDataSource = LoyaltyCoinDataSource(collectionView: loyaltyCoinCollectionView)
    }

}
