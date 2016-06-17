//
//  LoyaltyCoinDataSource.swift
//  Loyalty
//
//  Created by WangKun on 16/4/18.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

class LoyaltyCoinDataSource: NSObject,RatioPresentable {
    var currentCount: Int
    var totalCount: Int
    init(collectionView:UICollectionView,ratioPresentable:RatioPresentable) {
        self.currentCount = ratioPresentable.currentCount
        self.totalCount = ratioPresentable.totalCount
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
        return self.totalCount
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(indexPath: indexPath) as MoneyCollectionViewCell
        cell.updateLabelState(indexPath.row + 1, isCollected: indexPath.row <= self.currentCount - 1)
        return cell
    }
}