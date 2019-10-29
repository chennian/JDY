//
//  WebPhoneViewController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/12.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WebPhoneViewController: SNBaseViewController {
    
    
    let phoneField = UITextField().then{
        $0.backgroundColor = Color(0xffffff)
        $0.textColor = Color(0x262626)
        $0.font = BoldFont(64)
        $0.borderStyle = .none
        $0.textAlignment = .center
        $0.text = ""
        $0.isEnabled = false
    }
    
    
    let zero = PhoneView().then{
        $0.number.text = "0"
        $0.des.text = "+"
    }
    
    let one = PhoneView().then{
        $0.number.text = "1"
        $0.des.text = ""
    }
    
    let two = PhoneView().then{
        $0.number.text = "2"
        $0.des.text = "ABC"
    }
    
    let three = PhoneView().then{
        $0.number.text = "3"
        $0.des.text = "DEF"
    }
    
    let four = PhoneView().then{
        $0.number.text = "4"
        $0.des.text = "GHI"
    }
    
    let five = PhoneView().then{
        $0.number.text = "5"
        $0.des.text = "JKL"
    }
    
    
    let six = PhoneView().then{
        $0.number.text = "6"
        $0.des.text = "MNO"
    }
    
    let seven = PhoneView().then{
        $0.number.text = "7"
        $0.des.text = "PQRS"
    }
    
    let eight = PhoneView().then{
        $0.number.text = "8"
        $0.des.text = "TUV"
    }
    
    let night = PhoneView().then{
        $0.number.text = "9"
        $0.des.text = "WXYZ"
    }
    
    let copyButton = UIButton().then{
        $0.setImage(UIImage(named: "copy"), for: .normal)
    }
    
    let delete = UIButton().then{
        $0.setImage(UIImage(named: "delete"), for: .normal)
    }
    

    let callButton = UIButton().then{
        $0.setImage(UIImage(named: "phone"), for: .normal)
    }
    
    override func bindEvent() {
        zero.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "0"
        }
        one.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "1"
        }
        
        two.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "2"
        }
        three.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "3"
        }
        four.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "4"
        }
        
        five.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "5"
        }
        
        six.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "6"
        }
        seven.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "7"
        }
        
        eight.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "8"
        }
        
        night.clickEvent = {
            self.phoneField.text = self.phoneField.text! + "9"
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @objc func callAction(){
    
        if (self.phoneField.text?.isEmpty)! {
            SZHUD("请输入呼叫电话", type: .info, callBack: nil)
            return
        }
        
 

        let url = httpUrl + "/main/callPhone"
        let para:[String:String] = ["to":self.phoneField.text!]
        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1{
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)

                let vc = CallUIViewController()
                vc.phoneNum = self.phoneField.text
                self.navigationController?.pushViewController(vc, animated: true)
                
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
    
    @objc func deleteAction(){
        
        let count = self.phoneField.text?.count
        let text = self.phoneField.text!
        
        if count! > 0 {
            self.phoneField.text! =  String(text.prefix(count! - 1))
        }
    }
    
    @objc func copyAction(){
        let pasteboard = UIPasteboard.general
        pasteboard.string = self.phoneField.text!
        SZHUD("复制成功", type: .success, callBack: nil)
    }
    
    override func setupView() {
        self.view.backgroundColor = Color(0xffffff)
        
        self.view.addSubview(phoneField)
        self.view.addSubview(zero)
        self.view.addSubview(one)
        self.view.addSubview(two)
        self.view.addSubview(three)
        self.view.addSubview(four)
        self.view.addSubview(five)
        self.view.addSubview(six)
        self.view.addSubview(seven)
        self.view.addSubview(eight)
        self.view.addSubview(night)
        
    
        self.view.addSubview(copyButton)
        self.view.addSubview(delete)
        self.view.addSubview(callButton)
        
        callButton.addTarget(self, action: #selector(callAction), for: .touchUpInside)
        copyButton.addTarget(self, action: #selector(copyAction), for: .touchUpInside)
        
        delete.addTarget(self, action: #selector(deleteAction), for: .touchUpInside)
        
        phoneField.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(300)
        }
        
        one.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(phoneField.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        two.snp.makeConstraints { (make) in
            make.left.equalTo(one.snp.right)
            make.top.equalTo(phoneField.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        three.snp.makeConstraints { (make) in
            make.left.equalTo(two.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(phoneField.snp.bottom)
            make.height.equalTo(fit(160))
        }
        
        
        four.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(one.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        five.snp.makeConstraints { (make) in
            make.left.equalTo(four.snp.right)
            make.top.equalTo(two.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        six.snp.makeConstraints { (make) in
            make.left.equalTo(five.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(three.snp.bottom)
            make.height.equalTo(fit(160))
        }
        
        seven.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(four.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        eight.snp.makeConstraints { (make) in
            make.left.equalTo(seven.snp.right)
            make.top.equalTo(five.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        night.snp.makeConstraints { (make) in
            make.left.equalTo(eight.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(six.snp.bottom)
            make.height.equalTo(fit(160))
        }
        
        
        copyButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(seven.snp.bottom)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        zero.snp.makeConstraints { (make) in
            make.top.equalTo(eight.snp.bottom)
            make.centerX.equalTo(eight.snp.centerX)
            make.width.equalTo(ScreenW/3)
            make.height.equalTo(fit(160))
        }
        
        delete.snp.makeConstraints { (make) in
            make.left.equalTo(zero.snp.right)
            make.right.equalToSuperview()
            make.top.equalTo(night.snp.bottom)
            make.height.equalTo(fit(160))
        }
        
        
        callButton.snp.makeConstraints { (make) in
            make.top.equalTo(zero.snp.bottom).snOffset(25)
//            make.bottom.equalToSuperview().snOffset(-25)
            make.centerX.equalToSuperview()
            make.width.snEqualTo(120)
            make.height.snEqualTo(120)
        }
        
        
        
    }

}
