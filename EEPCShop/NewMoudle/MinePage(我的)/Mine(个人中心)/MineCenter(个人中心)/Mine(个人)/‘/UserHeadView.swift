//
//  UserHeadView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class UserHeadView: SNBaseView {

    var clickEvent:(()->())?
    var clickEvent2:(()->())?
    var clickEventPara:((_ para:Int)->())?

    let img = UIImageView().then{
        $0.image  = UIImage(named: "me_img")
        $0.backgroundColor = .clear
    }
    
    let phone = UILabel().then{
        $0.text = ""
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let contributeButton = UIButton().then{
        $0.setImage(UIImage(named: "exp"), for: .normal)
        $0.isHidden = true
    }
    
    let contributeLable = UILabel().then{
        $0.text = ""
        $0.font = Font(30)
        $0.textColor = Color(0xffffff)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }

    let baseRmdView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let baseBalanceView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }

    
    let settingButton = UIButton().then{
        $0.setImage(UIImage(named: "setting"), for: .normal)
    }
    
    let serviceButton = UIButton().then{
        $0.setImage(UIImage(named: "serviceIcon"), for: .normal)
    }
    
    
    let inviteUserView = MyBaseView().then{
        $0.imgViewIcon.image = UIImage(named: "icon11")
        $0.lblTitle.textColor = Color(0xffffff)
        $0.lblTitle.text = "邀请好友"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let couponUserView = MyBaseView().then{
        $0.imgViewIcon.image = UIImage(named: "icon22")
        $0.lblTitle.textColor = Color(0xffffff)
        $0.lblTitle.text = "优惠券"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        
    }
    
    let applyShopView = MyBaseView().then{
        $0.imgViewIcon.image = UIImage(named: "icon33")
        $0.lblTitle.textColor = Color(0xffffff)
        $0.lblTitle.text = "申请商家"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let inviteShopView = MyBaseView().then{
        $0.imgViewIcon.image = UIImage(named: "icon44")
        $0.lblTitle.textColor = Color(0xffffff)
        $0.lblTitle.text = "邀请商家"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        
    }
    
    let MyRmd = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
        $0.text = "详情账单"
    }
    
    
    let rmdLable = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "分润"
    }
    
    let rmdProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(32)
        $0.text = "￥0.00"
    }
    
    let MyBalance = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
        $0.text = "我的资产"
    }
    
    let balanceLabel = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "余额"
    }
    
    let balanceProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = Font(32)
        $0.text = "￥0.00"
    }
    
    @objc func tapAction(){
        guard let action = self.clickEvent else {
            return
        }
        action()
    }
    @objc func tapAction2(){
        guard let action = self.clickEvent2 else {
            return
        }
        action()
    }
    
    @objc func tapActionA(){
        guard let action = self.clickEventPara else {
            return
        }
        action(1)
    }
    @objc func tapActionB(){
        guard let action = self.clickEventPara else {
            return
        }
        action(2)
    }
    
    
    @objc func tapActionC(){
        guard let action = self.clickEventPara else {
            return
        }
        action(3)
    }
    
    @objc func tapActionD(){
        guard let action = self.clickEventPara else {
            return
        }
        action(4)
    }
    
    @objc func tapActionE(){
        guard let action = self.clickEventPara else {
            return
        }
        action(5)
    }
    
    @objc func tapActionF(){
        guard let action = self.clickEventPara else {
            return
        }
        action(6)
    }
    
    

    
    override func bindEvent(){
        
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        baseRmdView.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        baseBalanceView.addGestureRecognizer(tapB)
        
        let tapC = UITapGestureRecognizer.init(target: self, action: #selector(tapActionC))
        inviteUserView.addGestureRecognizer(tapC)
        
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        couponUserView.addGestureRecognizer(tapD)
        
        let tapE = UITapGestureRecognizer.init(target: self, action: #selector(tapActionE))
        applyShopView.addGestureRecognizer(tapE)
        
        let tapF = UITapGestureRecognizer.init(target: self, action: #selector(tapActionF))
        inviteShopView.addGestureRecognizer(tapF)
        
        
    }
    
    override func setupView() {
        self.addSubviews(views: [img,phone,contributeLable,baseView,settingButton,serviceButton,inviteUserView,couponUserView,applyShopView,inviteShopView])
        baseView.addSubviews(views: [baseRmdView,baseBalanceView])
        baseRmdView.addSubviews(views: [MyRmd,rmdLable,rmdProfit])
        baseBalanceView.addSubviews(views: [MyBalance,balanceLabel,balanceProfit])
        
        settingButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        serviceButton.addTarget(self, action: #selector(tapAction2), for: .touchUpInside)

        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30 + 48)
            make.height.width.snEqualTo(140)
        }
        
        phone.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(17)
            make.centerY.equalTo(img.snp.centerY).snOffset(-25)
        }

        contributeLable.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(17)
            make.centerY.equalTo(img.snp.centerY).snOffset(25)
        }
        
        inviteUserView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(img.snp.bottom).snOffset(20)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        couponUserView.snp.makeConstraints { (make) in
            make.left.equalTo(inviteUserView.snp.right)
            make.top.equalTo(img.snp.bottom).snOffset(20)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        applyShopView.snp.makeConstraints { (make) in
            make.left.equalTo(couponUserView.snp.right)
            make.top.equalTo(img.snp.bottom).snOffset(20)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        inviteShopView.snp.makeConstraints { (make) in
            make.left.equalTo(applyShopView.snp.right)
            make.top.equalTo(img.snp.bottom).snOffset(20)
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.snEqualTo(180)
        }
        
        baseBalanceView.snp.makeConstraints { (make) in
            make.left.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo((ScreenW - 40)/2)
        }
        
        baseRmdView.snp.makeConstraints { (make) in
            make.left.equalTo(baseBalanceView.snp.right)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        MyRmd.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(10)
            make.centerX.equalToSuperview()
        }
        
        rmdLable.snp.makeConstraints { (make) in
            make.top.equalTo(MyRmd.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
        }
        rmdProfit.snp.makeConstraints { (make) in
            make.top.equalTo(rmdLable.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
        }
        
        MyBalance.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(10)
            make.centerX.equalToSuperview()
        }
        
        balanceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(MyBalance.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
        }
        balanceProfit.snp.makeConstraints { (make) in
            make.top.equalTo(balanceLabel.snp.bottom).snOffset(30)
            make.centerX.equalToSuperview()
        }
        serviceButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(img.snp.centerY)
        }
        
        settingButton.snp.makeConstraints { (make) in
            make.right.equalTo(serviceButton.snp.left).snOffset(-50)
            make.centerY.equalTo(img.snp.centerY)
        }
    }
}

