//
//  BindingModel.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/23.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON

enum BindType {
    case bankType(_ model:BindingModel)
    case alipayType(_ model:BindingModel)
    case wexinType(_ model:BindingModel)
    case openBankType(_ model:BindingModel)

}

class BindingModel: SNSwiftyJSONAble {

    var bank_no : String//银行卡号码
    var bank_name : String//银行卡所属人
    var bank_type : String//开卡银行
    var bank_branch  : String//银行支行
    var bank_province : String// 银行所在省
    var bank_city : String //银行所在市
    
    var open_bank_no : String//银行卡号码
    var open_bank_name : String//银行卡所属人
    var open_bank_type : String//开卡银行
    var open_bank_branch  : String//银行支行
    
    
    var apliy_receiev_code : String//支付宝收款码
    var wexin_receive_code : String//微信收款码
    
    required init?(jsonData: JSON) {
        self.bank_no = jsonData["bank_no"].stringValue
        self.bank_name = jsonData["bank_name"].stringValue
        self.bank_type = jsonData["bank_type"].stringValue
        self.bank_branch = jsonData["bank_branch"].stringValue
        
        self.open_bank_no = jsonData["open_bank_no"].stringValue
        self.open_bank_name = jsonData["open_bank_name"].stringValue
        self.open_bank_type = jsonData["open_bank_type"].stringValue
        self.open_bank_branch = jsonData["open_bank_branch"].stringValue
        
        self.bank_province = jsonData["bank_province"].stringValue
        self.bank_city = jsonData["bank_city"].stringValue
        self.apliy_receiev_code = jsonData["apliy_receiev_code"].stringValue
        self.wexin_receive_code = jsonData["wexin_receive_code"].stringValue

    }
}
