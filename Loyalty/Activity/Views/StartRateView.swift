//
//  StartRateView.swift
//  Loyalty
//
//  Created by WangKun on 16/3/31.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit

let defaultStarNum = 5
let selectedStarImageName = "star"
let unselectedStarImageName = "starUnselected"

class StartRateView: UIView {
    var numberOfStars:Int = defaultStarNum
    var allowInCompleteStar: Bool = true
    var unselectedStarView: UIView?
    var selectedStarView: UIView?
    var percentOfStar:CGFloat = 1.0 {
        didSet {
            self.setNeedsLayout()
        }
    }
    var changable:Bool = false
    
    
    required init(frame:CGRect, numberOfStars:Int = defaultStarNum){
        super.init(frame: frame)
        self.numberOfStars = numberOfStars
        self.buildUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder:coder)
        self.buildUI()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.selectedStarView?.frame = CGRectMake(0, 0, self.bounds.size.width * self.percentOfStar, self.bounds.size.height)
    }
 }

// MARK: - UI
extension StartRateView {
    private func buildUI(){
        self.selectedStarView = self.buildStartView(selectedStarImageName)
        self.unselectedStarView = self.buildStartView(unselectedStarImageName)
        self.addSubview(self.unselectedStarView!)
        self.addSubview(self.selectedStarView!)
        self.addGesture()
    }
    
    private func buildStartView(imageName:String) -> UIView{
        let starView = UIView(frame: self.bounds)
        starView.clipsToBounds = true
        starView.backgroundColor = UIColor.clearColor()
        let width = self.bounds.size.width / CGFloat(self.numberOfStars)
        let height = self.bounds.size.height
        for i in 0..<self.numberOfStars {
            let starImageView = UIImageView(image: UIImage(named: imageName))
            starImageView.frame = CGRectMake(CGFloat(i) * width, 0, width, height)
            starView.addSubview(starImageView)
        }
        return starView
    }
}

// MARK: - Action
extension StartRateView {
    private func addGesture(){
        if self.changable {
            let gesture = UITapGestureRecognizer(target: self, action: "onRateViewTapped:")
            gesture.numberOfTapsRequired = 1
            self.addGestureRecognizer(gesture)
        }
    }
    
    func onRateViewTapped(gesture:UITapGestureRecognizer){
        let tapPoint = gesture.locationInView(self)
        let xOffset = tapPoint.x
        let actualStarScore = xOffset / self.bounds.size.width * CGFloat(self.numberOfStars)
        let showStarScore = self.allowInCompleteStar ? actualStarScore : ceil(actualStarScore)
        var percentOfStar = showStarScore / CGFloat(self.numberOfStars)
        if percentOfStar < 0 {
            percentOfStar = 0
        } else if percentOfStar > 1 {
            percentOfStar = 1
        }
        self.percentOfStar = percentOfStar
    }
}