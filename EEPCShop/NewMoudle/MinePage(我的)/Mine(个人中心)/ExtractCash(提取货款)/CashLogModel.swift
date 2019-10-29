//
//  CashLogModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/27.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

import SwiftyJSON

class CashLogModel:SNSwiftyJSONAble{
    
    var id : String
    var uid : String
    var num: String
    var type: String
    var status: String
    var add_time : String
    
    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.uid = jsonData["uid"].stringValue
        self.num = jsonData["num"].stringValue
        self.type = jsonData["type"].stringValue
        self.status = jsonData["status"].stringValue
        self.add_time = jsonData["add_time"].stringValue
        
    }
    
}
