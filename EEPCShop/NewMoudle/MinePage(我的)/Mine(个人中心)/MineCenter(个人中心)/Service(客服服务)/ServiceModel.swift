//
//  ServiceModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServiceModel: SNSwiftyJSONAble {
    var id :String
    var uid :String
    var content :String
    var reply :String
    var status :String
    var add_time :String


    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.uid = jsonData["uid"].stringValue
        self.content = jsonData["content"].stringValue
        self.reply = jsonData["reply"].stringValue
        self.status = jsonData["status"].stringValue
        self.add_time = jsonData["add_time"].stringValue

    }
}
