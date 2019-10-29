//
//  UserAuthModel.swift
//  seven
//
//  Created by Mac Pro on 2018/12/21.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class UserAuthModel: NSObject {
    var parentPhone:String = ""   //推荐人
    var shop_name:String = "" //商家名称
    var license_no:String = ""//营业执照号码
    var province:String = ""  //省
    var city:String = ""//市
    var area:String = ""//区
    var address:String = ""//详细地址
    var legal_person:String = ""//法人姓名
    var legal_id:String = ""//法人省身份证
    var cat:String = ""//商家分类
    var discount:String = ""//商家折扣
    var rmd_type:String = ""//推荐人类型
    var longiduteKey:String = ""//经度
    var latitudeKey:String = ""//纬度

    
    
    var bank_no:String = "" //银行卡号码
    var bank_name:String = "" //银行卡所属人
    var bank_type:String = "" //开卡银行
    var bank_branch:String = "" //银行支行
    
    
    var open_bank_no:String = "" //银行卡号码
    var open_bank_name:String = "" //银行卡所属人
    var open_bank_type:String = "" //开卡银行
    var open_bank_branch:String = "" //银行支行
    
    var bank_province:String = "" // 银行所在省
    var bank_city:String = "" //银行所在市
    var apliy_receiev_code:String = "" //支付宝收款码
    var wexin_receive_code:String = ""//微信收款码
    
    
    var main_img:String = "" //商家形象照片
    var license_img:String = "" //营业执照照片
    var legal_id_front:String = ""//法人正面照
    var legal_id_back:String = ""//法人反面照
}
