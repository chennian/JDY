//
//  BusinessLogModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/19.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

enum BusinessLogType{
    case titleType
    case businessLogType(model:BusinessLogModel)
}

class BusinessLogModel:SNSwiftyJSONAble{
    
    var shop_id : String
    var uid : String
    var num: String
    var real_receive: String
    var add_time : String

    
    required init?(jsonData: JSON) {
        self.shop_id = jsonData["shop_id"].stringValue
        self.uid = jsonData["uid"].stringValue
        self.num = jsonData["num"].stringValue
        self.real_receive = jsonData["real_receive"].stringValue
        self.add_time = jsonData["add_time"].stringValue
     
    }
    
}
