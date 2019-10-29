//
//  goodModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/3.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class GoodModel: SNSwiftyJSONAble {
    var id :String
    var good_main_pic:String
    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.good_main_pic = jsonData["good_main_pic"].stringValue
    }
}

