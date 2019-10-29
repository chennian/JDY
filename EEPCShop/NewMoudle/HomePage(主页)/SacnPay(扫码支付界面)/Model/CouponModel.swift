//
//  CouponModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/13.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
class CouponModel:  SNSwiftyJSONAble {
    var status : String
    var id : String
    var bonus : String
    var base : String

    required init?(jsonData: JSON) {
        self.status = jsonData["status"].stringValue
        self.id = jsonData["id"].stringValue
        self.bonus = jsonData["bonus"].stringValue
        self.base = jsonData["base"].stringValue
    }
    
}
class UserCouponModel:  SNSwiftyJSONAble {
    var id : String
    var uid : String
    var availdate : String
    var couponId : String
    var used : String
    var bonus : String
    var base : String
    var type : String

    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.uid = jsonData["uid"].stringValue
        self.availdate = jsonData["availdate"].stringValue
        self.couponId = jsonData["couponId"].stringValue
        self.used = jsonData["used"].stringValue
        self.bonus = jsonData["bonus"].stringValue
        self.base = jsonData["base"].stringValue
        self.type = jsonData["type"].stringValue

    }
    
}
