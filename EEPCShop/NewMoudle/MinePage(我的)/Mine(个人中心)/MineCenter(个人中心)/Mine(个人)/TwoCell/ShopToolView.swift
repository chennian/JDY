//
//  ShopToolView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/14.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ShopToolView: SNBaseView {
    
    
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
    
    let shopManagerView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let serviceView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let videoView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let couponButton = UIButton().then{
        $0.setImage(UIImage(named: "iconi"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let couponLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "优惠券"
    }
    
    let shopManagerButton = UIButton().then{
        $0.setImage(UIImage(named: "icona"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let shopManagerLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "大圣商城"
    }
    
    let serviceButton = UIButton().then{
        $0.setImage(UIImage(named: "iconj"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let serviceLable = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
        $0.text = "店铺管理"
    }
    
    let videoButton = UIButton().then{
        $0.setImage(UIImage(named: "iconk"), for: .normal)
        $0.isUserInteractionEnabled = false
    }
    let videoLable = UILabel().then{
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
        shopManagerView.addGestureRecognizer(tapB)
        
        let tapC = UITapGestureRecognizer.init(target: self, action: #selector(tapActionC))
        serviceView.addGestureRecognizer(tapC)
        
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        videoView.addGestureRecognizer(tapD)
        
    }
    
    override func setupView() {
        self.addSubviews(views: [baseView])
        baseView.addSubviews(views: [infoLable,couponView,shopManagerView,serviceView,videoView])
        
        couponView.addSubviews(views: [couponButton,couponLable])
        shopManagerView.addSubviews(views: [shopManagerButton,shopManagerLable])
        serviceView.addSubviews(views: [serviceButton,serviceLable])
        videoView.addSubviews(views: [videoButton,videoLable])
        
        
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
        shopManagerView.snp.makeConstraints { (make) in
            make.top.equalTo(infoLable.snp.bottom)
            make.left.equalTo(couponView.snp.right)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        serviceView.snp.makeConstraints { (make) in
            make.left.equalTo(shopManagerView.snp.right)
            make.top.equalTo(infoLable.snp.bottom)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(180)
        }
        
        videoView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
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
        
        
        videoButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(90)
        }
        videoLable.snp.makeConstraints { (make) in
            make.top.equalTo(videoButton.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
}
