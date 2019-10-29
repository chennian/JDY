//
//  RmdToolView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class RmdToolView: SNBaseView {
    
    var clickEvent:((_ para:Int)->())?

    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    let infoLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "推荐工具"
    }
    
    let couponView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let receiveCodeView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let shopManagerView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let serviceView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    
    let couponButton = UIButton().then{
        $0.setImage(UIImage(named: "icone"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let couponLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "火车票"
    }
    
    let receiveButton = UIButton().then{
        $0.setImage(UIImage(named: "iconf"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let receiveLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "电影"
    }
    let shopManagerButton = UIButton().then{
        $0.setImage(UIImage(named: "icong"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let shopManagerLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "飞机票"
    }
    
    let serviceButton = UIButton().then{
        $0.setImage(UIImage(named: "iconh"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let serviceLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "手机充值"
    }
    
    
    @objc func tapActionA(){
        guard let action = self.clickEvent else {
            return
        }
        action(1)
    }

    @objc func tapActionB(){
        guard let action = self.clickEvent else {
            return
        }
        action(2)
    }
    @objc func tapActionC(){
        guard let action = self.clickEvent else {
            return
        }
        action(3)
    }
    @objc func tapActionD(){
        guard let action = self.clickEvent else {
            return
        }
        action(4)
    }

    override func bindEvent(){
        
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        couponView.addGestureRecognizer(tapA)
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        receiveCodeView.addGestureRecognizer(tapB)
        let tapC = UITapGestureRecognizer.init(target: self, action: #selector(tapActionC))
        shopManagerView.addGestureRecognizer(tapC)
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        serviceView.addGestureRecognizer(tapD)
    }
    
    override func setupView() {
        self.addSubviews(views: [baseView])
        baseView.addSubviews(views: [infoLable,couponView,receiveCodeView,shopManagerView,serviceView])
        
        couponView.addSubviews(views: [couponButton,couponLable])
        receiveCodeView.addSubviews(views: [receiveButton,receiveLable])
        shopManagerView.addSubviews(views: [shopManagerButton,shopManagerLable])
        serviceView.addSubviews(views: [serviceButton,serviceLable])
    
        //        bindEvent()
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(240)
            make.centerY.equalToSuperview()
        }
        
        infoLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalToSuperview().snOffset(20)
        }
        
        couponView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        receiveCodeView.snp.makeConstraints { (make) in
            make.left.equalTo(couponView.snp.right)
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        shopManagerView.snp.makeConstraints { (make) in
            make.left.equalTo(receiveCodeView.snp.right)
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        serviceView.snp.makeConstraints { (make) in
            make.left.equalTo(shopManagerView.snp.right)
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        
        
        couponButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(90)
        }
        couponLable.snp.makeConstraints { (make) in
            make.top.equalTo(couponButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        receiveButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(90)
        }
        receiveLable.snp.makeConstraints { (make) in
            make.top.equalTo(receiveButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        shopManagerButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(90)
        }
        shopManagerLable.snp.makeConstraints { (make) in
            make.top.equalTo(shopManagerButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        serviceButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(90)
        }
        serviceLable.snp.makeConstraints { (make) in
            make.top.equalTo(serviceButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
    }
    
}
