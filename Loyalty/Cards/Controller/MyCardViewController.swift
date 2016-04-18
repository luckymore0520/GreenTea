//
//  MyCardViewController.swift
//  Loyalty
//
//  Created by WangKun on 16/4/16.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import UIKit
import Koloda

class MyCardViewController: UIViewController {

    @IBOutlet weak var kolodaView: KolodaView!
    @IBOutlet weak var currentNumLabel: UILabel!

    var cardDataSource = CardDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentNumLabel.text = "\(self.kolodaView.currentCardIndex + 1)/\(self.kolodaView.countOfCards)"
        kolodaView.dataSource = cardDataSource
        kolodaView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyCardViewController:KolodaViewDelegate {
    func koloda(koloda: KolodaView, didShowCardAtIndex index: UInt) {
        self.currentNumLabel.text = "\(koloda.currentCardIndex + 1)/\(koloda.countOfCards)"
    }
    
    func kolodaDidRunOutOfCards(koloda: KolodaView) {
        koloda.resetCurrentCardIndex()
    }
}
