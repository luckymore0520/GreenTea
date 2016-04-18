//
//  LoyaltyCoinDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class LoyaltyCoinDataSource: NSObject {
    init(collectionView:UICollectionView) {
        super.init()
        collectionView.dataSource = self
        collectionView.registerReusableCell(MoneyCollectionViewCell.self)
    }
}



extension LoyaltyCoinDataSource:UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MoneyCollectionViewCell
        cell.updateLabelState(indexPath.row + 1)
        return cell
    }
}