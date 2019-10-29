//
//  ExtractCashController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/19.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class ExtractCashController: SNBaseViewController {
    
    fileprivate let payTypePiker = CustomPiker.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216),type:.payType)
    
    var model:ShopMsgModel?
    var payType :String?
    
    var new:String = ""
    
    let bannarInfo = UIView().then{
        $0.backgroundColor = Color(0xf03c62)
        $0.layer.cornerRadius = fit(0x20)
    }
    
    
    let bankSetting = UIButton().then{
        $0.setImage(UIImage(named: "setting"), for: .normal)
    }
    
    let totalLable = UILabel().then{
        $0.text = "0.00"
        $0.font = Font(76)
        $0.textColor = Color(0xffffff)
    }
    
    let des = UILabel().then{
        $0.text = "总货款(￥)"
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let cashNotice = UILabel().then{
        $0.textColor = Color(0xb3bac3)
        $0.text = "温馨提示：提现前请先点击齿轮设置提款方式"
        $0.font = Font(26)
        $0.isHidden = true
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    let notice = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.text = "温馨提示：提现前请先点击齿轮设置提款方式"
//        $0.text = "温馨提示：每次提现金额不能小于100"
        $0.font = Font(26)
    }
    
    let ViewOne = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(10)
        $0.layer.borderColor = Color(0xd2d2d2).cgColor
        $0.layer.borderWidth = fit(1)
    }
    
    let extractLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.text = "提款"
        $0.font = Font(32)
    }
    
    let moneyField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder =  "请输入提款金额"
        $0.font = Font(32)
        $0.textAlignment = .left
    }
    
    
    let ViewTwo = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(10)
        $0.layer.borderColor = Color(0xd2d2d2).cgColor
        $0.layer.borderWidth = fit(1)
    }
    let extractTo = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.text = "提款到"
        $0.font = Font(32)
    }
    let extractToField = UITextField().then{
        $0.borderStyle = .none
        $0.placeholder =  "请选择提款方式"
        $0.font = Font(32)
        $0.textAlignment = .left
//        $0.isUserInteractionEnabled = false
    }
    
    let accessoryImageView = UIImageView().then {
        $0.image = Image("dropdown")
        $0.isUserInteractionEnabled = false

    }
    

    let conrfirm = UIButton().then{
        $0.setTitle("确认", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(32)
        $0.backgroundColor = Color(0x3660fb)
        $0.layer.cornerRadius = fit(49)
    }
    
    var rightBtn = UIButton().then{
        $0.setTitle("提现记录", for: .normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
        $0.titleLabel?.font = Font(32)
    }
    
    override func loadData() {
        let url = httpUrl + "/main/userMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                DispatchQueue.main.async {
                    //装数据
                    self.totalLable.text = jsonData["data"]["money"].stringValue
                    
                    let is_shop = jsonData["data"]["is_shop"].stringValue
                    XKeyChain.set(is_shop, key: ISSHOP)
                    self.loadShopMsg(is_shop)
                    
                }
            }else if jsonData["code"].intValue == 1006 {
         let vc = LoginViewController()
         vc.modalPresentationStyle = .fullScreen
         self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    
    
    func loadShopMsg(_ is_shop:String) {
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                self.model = ShopMsgModel.init(jsonData: jsonData["data"])
                if self.model?.legal_id_front == "" || (self.model?.legal_id_front.isEmpty)!{
                    self.new = "1"
                }else{
                    self.new = "0"
                }
                
                SZHUDDismiss()
            }else if jsonData["code"].intValue == 1006 {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                SZHUDDismiss()
                
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)

                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    
    @objc func confirmAction(){
        
        if  moneyField.text! == "" {
            SZHUD("请输入提现金额", type: .info, callBack: nil)
            return
        }
        
        if  Float(moneyField.text!)!  < 0.0 {
            SZHUD("提现金额不能小于0", type: .info, callBack: nil)
            return
        }
        
        if  extractToField.text! == "" {
            SZHUD("请选择到账方式", type: .info, callBack: nil)
            return
        }
        
        let url = httpUrl + "/main/extractMoney"
        let para:[String:String] = ["num":moneyField.text!,"type":self.payType!]
                             
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                
                DispatchQueue.main.async {
                    self.totalLable.text = jsonData["data"].stringValue
                }
                self.navigationController?.popViewController(animated: true)
            }else{
                if !jsonData["msg"].stringValue.isEmpty{
                    SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                }else{
                    SZHUD("请求错误" , type: .error, callBack: nil)
                }
            }
            
        }
    }
    @objc func enterCashLog(){
        self.navigationController?.pushViewController(CashLogController(), animated: true)
    }
    
    @objc func applyFinance(){
        if self.new == "1"{
            self.navigationController?.pushViewController(MyInfoStepTwoController(), animated: true)
        }else{
            self.navigationController?.pushViewController(UpdateBankViewController(), animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    
    override func setupView() {
        
        self.title = "提取货款"
        

        self.view.backgroundColor = Color(0xf5f5f5)
        
        self.view.addSubview(bannarInfo)
        bannarInfo.addSubviews(views: [bankSetting,totalLable,des,cashNotice])
        
        self.view.addSubview(baseView)
        
        baseView.addSubviews(views: [notice,ViewOne,ViewTwo,conrfirm])
        
        ViewOne.addSubviews(views: [extractLable,moneyField])
        ViewTwo.addSubviews(views: [extractTo,extractToField,accessoryImageView])
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        self.rightBtn.addTarget(self, action: #selector(enterCashLog), for: .touchUpInside)
        self.bankSetting.addTarget(self, action: #selector(applyFinance), for: .touchUpInside)


        
        extractToField.inputView = self.payTypePiker
        payTypePiker.selectValue = {[unowned self] (name,id) in
            self.extractToField.text = name
            self.payType = id
        }
        
        conrfirm.addTarget(self, action: #selector(confirmAction), for: .touchUpInside)
        
        
        bannarInfo.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(20)
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(422)
        }
        
        bankSetting.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.width.height.snEqualTo(50)
        }
        
        totalLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(143)
            make.centerX.equalToSuperview()
        }
        
        des.snp.makeConstraints { (make) in
            make.top.equalTo(totalLable.snp.bottom).snOffset(35)
            make.centerX.equalToSuperview()
        }
        cashNotice.snp.makeConstraints { (make) in
            make.top.equalTo(des.snp.bottom).snOffset(35)
            make.centerX.equalToSuperview()
        }
        
        baseView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannarInfo.snp.bottom).snOffset(76)
        }
        
        notice.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(82)
            make.left.equalToSuperview().snOffset(92)
        }
        
        ViewOne.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(92)
            make.right.equalToSuperview().snOffset(-92)
            make.top.equalTo(notice.snp.bottom).snOffset(27)
            make.height.snEqualTo(122)
        }
        
        accessoryImageView.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-28)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(18)
            make.height.snEqualTo(14)
        }
        extractLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(27)
            make.centerY.equalToSuperview()
        }
        moneyField.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.snEqualTo(290)
            make.centerY.equalTo(extractLable.snp.centerY)
        }
        
        ViewTwo.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(92)
            make.right.equalToSuperview().snOffset(-92)
            make.top.equalTo(ViewOne.snp.bottom).snOffset(27)
            make.height.snEqualTo(122)
        }
        
        extractTo.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(27)
            make.centerY.equalToSuperview()
        }
        
        extractToField.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.width.snEqualTo(290)
            make.centerY.equalTo(extractTo.snp.centerY)
        }
        
        conrfirm.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(89)
            make.right.equalToSuperview().snOffset(-89)
            make.bottom.equalToSuperview().snOffset(-75)
            make.height.snEqualTo(98)
        }
    }

}
