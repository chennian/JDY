//
//  ShopMsgModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

enum MineType{
    case zeroCell
    case oneCell
    case twoCell
    case threeCell
    case fourCell
    case banner


}

class ShopMsgModel: SNSwiftyJSONAble {
    var id : String
    var shop_id : String
    var shop_name : String
    var user_discount : String
    var discount : String
    var discount_id : String
    var eepc_ratio : String
    var usdt_ratio : String
    
    
    var cat_name : String
    var license_no:String
    var legal_person:String
    var legal_id:String
    var license_img:String
    var legal_id_back:String
    var legal_id_front:String

    
    var bank_province :String
    var bank_city:String
    var apliy_receiev_code:String
    var wexin_receive_code:String
    var bank_no:String
    var bank_name:String
    var bank_type:String
    var bank_branch:String
    var open_bank_no:String
    var open_bank_name:String
    var open_bank_type:String
    var open_bank_branch:String

    var province : String
    var city : String
    var area : String
    var address_detail : String
    var lng : String
    var lat : String
    var main_img : String
    var phone :String
    var cat : String
    var lable : String
    
    var detail_img :String
    var describtion :String
    
    var base:String = ""
    var bouns:String = ""
    
    
    var contributePoint:String
    var todayreceive:String
    var rectProfit:String
    var rmdProfit:String
    var parentPhone:String
    var rcm_type:String
    var level:String


    var balance:String = ""


    
    required init?(jsonData: JSON) {
        self.id = jsonData["id"].stringValue
        self.shop_id = jsonData["shop_id"].stringValue
        self.shop_name = jsonData["shop_name"].stringValue
        self.license_no = jsonData["license_no"].stringValue
        self.legal_person = jsonData["legal_person"].stringValue
        self.legal_id = jsonData["legal_id"].stringValue
        self.license_img = jsonData["license_img"].stringValue
        self.province = jsonData["province"].stringValue
        self.city = jsonData["city"].stringValue
        self.area = jsonData["area"].stringValue
        self.address_detail = jsonData["address_detail"].stringValue
        self.lng = jsonData["lng"].stringValue
        self.lat = jsonData["lat"].stringValue
        self.main_img = jsonData["main_img"].stringValue
        self.phone = jsonData["phone"].stringValue
        self.cat = jsonData["cat"].stringValue
        self.cat_name  = jsonData["name"].stringValue
        self.lable = jsonData["lable"].stringValue
        
        self.bank_province = jsonData["bank_province"].stringValue
        self.bank_city = jsonData["bank_city"].stringValue
        self.apliy_receiev_code = jsonData["apliy_receiev_code"].stringValue
        self.wexin_receive_code = jsonData["wexin_receive_code"].stringValue
        self.bank_no = jsonData["bank_no"].stringValue
        self.bank_name = jsonData["bank_name"].stringValue
        self.bank_type = jsonData["bank_type"].stringValue
        self.bank_branch = jsonData["bank_branch"].stringValue
        self.open_bank_no = jsonData["open_bank_no"].stringValue
        self.open_bank_name = jsonData["open_bank_name"].stringValue
        self.open_bank_type = jsonData["open_bank_type"].stringValue
        self.open_bank_branch = jsonData["open_bank_branch"].stringValue
        self.legal_id_back = jsonData["legal_id_back"].stringValue
        self.legal_id_front = jsonData["legal_id_front"].stringValue

        self.user_discount = jsonData["user_discount"].stringValue
        self.discount = jsonData["discount"].stringValue
        self.discount_id = jsonData["discount_id"].stringValue

        self.eepc_ratio = jsonData["eepc_ratio"].stringValue
        self.usdt_ratio = jsonData["usdt_ratio"].stringValue
        
        
        self.detail_img = jsonData["detail_img"].stringValue
        self.describtion = jsonData["description"].stringValue
        
        self.contributePoint = jsonData["contributePoint"].stringValue
        self.todayreceive = jsonData["todayreceive"].stringValue
        self.rectProfit = jsonData["rectProfit"].stringValue
        self.rmdProfit = jsonData["rmdProfit"].stringValue
        self.parentPhone = jsonData["parentPhone"].stringValue
        self.rcm_type = jsonData["rcm_type"].stringValue
        self.level = jsonData["level"].stringValue


        
    }
    
}
