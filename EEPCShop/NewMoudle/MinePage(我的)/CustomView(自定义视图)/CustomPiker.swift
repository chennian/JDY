//
//  bankCardPiker.swift
//  XHXMerchant
//
//  Created by Mac Pro on 2018/4/15.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import RxSwift
import SwiftyJSON
import Alamofire

enum PikerType{
    case shopCat
    case shopDiscount
    case payType
    case rmdType
    case couponType
}

class CustomPiker:UIView {
    
    var selectValue:((_ name:String,_ id:String)->())?

    let disposeBag = DisposeBag()
    
    var id:[String] = []
    
    var name:[String] = []
    
    var jsonArr:JSON = []


    fileprivate lazy var bankPiker: UIPickerView! = { [unowned self] in
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
        picker.delegate = self
        picker.dataSource = self
        picker.backgroundColor = UIColor.white
        return picker
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bankPiker)
    }
    
    //商家分类
    func loadShopCatData(){
        let url = httpUrl + "/common/shopCat"
        Alamofire.request(url, method: .post, parameters:nil, headers:nil).responseJSON { [unowned self](res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                CNLog(jsonData["data"])
                //登录成功数据解析
                self.jsonArr = jsonData["data"]

                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.name.append(subJson["name"].string!)
                    self.id.append(subJson["id"].string!)
                }
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
    //商家折扣
    func loadShopDiscountData(){
        let url = httpUrl + "/common/shopDiscount"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                CNLog(jsonData["data"])
                //登录成功数据解析
                self.jsonArr = jsonData["data"]
                
                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.name.append(subJson["name"].string!)
                    self.id.append(subJson["id"].string!)
                }
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
    
    //商家提现方式
    func loadPayTypeData(){
        let url = httpUrl + "/common/payType"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                CNLog(jsonData["data"])
                //登录成功数据解析
                self.jsonArr = jsonData["data"]
                
                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.name.append(subJson["name"].string!)
                    self.id.append(subJson["id"].string!)
                }
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
    
    //推荐人类型
    func loadRmdTypeData(){
        let url = httpUrl + "/common/rmdType"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                CNLog(jsonData["data"])
                //登录成功数据解析
                self.jsonArr = jsonData["data"]
                
                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.name.append(subJson["name"].string!)
                    self.id.append(subJson["id"].string!)
                }
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
    
    //用户优惠券
    func getUserCoupon(){
        let url = httpUrl + "/main/getUserCoupon"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                CNLog(jsonData["data"])
                //登录成功数据解析
                self.jsonArr = jsonData["data"]
                
                for (_,subJson):(String,JSON) in self.jsonArr {
                    self.name.append("满" + subJson["base"].string! + "减" + subJson["bonus"].string!)
                    self.id.append(subJson["id"].string!)
                }
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
 
    init(frame: CGRect,type:PikerType) {
        super.init(frame: frame)
        switch type {
        case .shopCat:
            loadShopCatData()
        case .shopDiscount:
            loadShopDiscountData()
        case .payType:
            loadPayTypeData()
        case .rmdType:
            loadRmdTypeData()

        case .couponType:
            getUserCoupon()
        }
        addSubview(bankPiker)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
extension CustomPiker:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return  1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return name.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return name[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let selectVal = selectValue else {
            return
        }
        selectVal(self.name[row],self.id[row])
    }
    
    
}
