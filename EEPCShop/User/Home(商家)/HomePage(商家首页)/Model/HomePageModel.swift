//
//  HomePageModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

enum homePageType{
    case bannerType
    case classType
    case mapType
    case merchantHeadType
    case merchantType
    case spaceType
}

class HomePageModel: SNSwiftyJSONAble {
    required init?(jsonData: JSON) {
        
    }
}
