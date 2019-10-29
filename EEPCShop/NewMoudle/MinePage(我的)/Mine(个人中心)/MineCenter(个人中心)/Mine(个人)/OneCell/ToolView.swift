//
//  ToolView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ToolView: SNBaseView {
    
    var clickEvent:((_ para:Int)->())?
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let infoLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "必备工具"
    }
    
    let couponView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }

    let serviceView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let couponButton = UIButton().then{
        $0.setImage(UIImage(named: "ticket"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let couponLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "优惠券"
    }
  
    let serviceButton = UIButton().then{
        $0.setImage(UIImage(named: "service1"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let serviceLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "客服服务"
    }
    
    @objc func tapActionA(){
        guard let action = self.clickEvent else {
            return
        }
        action(1)
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

        
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        serviceView.addGestureRecognizer(tapD)
        
    }
    
    override func setupView() {
        self.addSubviews(views: [baseView])
        baseView.addSubviews(views: [infoLable,couponView,serviceView])
        
        couponView.addSubviews(views: [couponButton,couponLable])
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
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(180)
        }
        
      
        serviceView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(180)
        }
        
        couponButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(60)
        }
        couponLable.snp.makeConstraints { (make) in
            make.top.equalTo(couponButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        

        
        serviceButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(60)
        }
        serviceLable.snp.makeConstraints { (make) in
            make.top.equalTo(serviceButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
