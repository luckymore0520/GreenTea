//
//  HasHiddenComponent.Swift
//  Loyalty
//
//  Created by WangKun on 16/4/26.
//  Copyright © 2016年 WangKun. All rights reserved.
//

import Foundation
import UIKit

protocol HasHiddenComponent {
    var shouldHidden:Bool { get }
    func updateHiddableViews(views:[UIView])
}

extension HasHiddenComponent {
    func updateHiddableViews(views:[UIView]) {
        for view in views {
            view.hidden = self.shouldHidden
        }
    }
}