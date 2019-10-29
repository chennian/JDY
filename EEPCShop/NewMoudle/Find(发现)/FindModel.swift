//
//  FindModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/12.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

class FindModel: SNSwiftyJSONAble {
    
    var id :String
    var cat :String
    var top :String
    var title :String
    var img :String
    var hratio :Float

    var detail_img :String
    var content :String
    var addtime :String

    required init?(jsonData: JSON) {
        
        self.id = jsonData["id"].stringValue
        self.cat = jsonData["cat"].stringValue
        self.top = jsonData["top"].stringValue
        self.title = jsonData["title"].stringValue
        self.img = jsonData["img"].stringValue
        self.hratio = jsonData["hratio"].floatValue
        self.detail_img = jsonData["detail_img"].stringValue
        self.content = jsonData["content"].stringValue
        self.addtime = jsonData["addtime"].stringValue
    }

}
