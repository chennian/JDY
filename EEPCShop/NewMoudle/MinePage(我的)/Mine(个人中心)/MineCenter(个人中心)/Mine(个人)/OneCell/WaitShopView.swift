//
//  WaitShopView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/21.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class WaitShopView: SNBaseView {

    var clickEventPara:((_ para:Int)->())?

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
    
    override func bindEvent() {
        
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        inviteUserView.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        couponUserView.addGestureRecognizer(tapB)
        
        let tapC = UITapGestureRecognizer.init(target: self, action: #selector(tapActionC))
        applyShopView.addGestureRecognizer(tapC)
        
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        inviteShopView.addGestureRecognizer(tapD)
    }
    
    override func setupView() {
        self.addSubviews(views: [inviteUserView,couponUserView,applyShopView,inviteShopView])
        
        inviteUserView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        couponUserView.snp.makeConstraints { (make) in
            make.left.equalTo(inviteUserView.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        applyShopView.snp.makeConstraints { (make) in
            make.left.equalTo(couponUserView.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
        inviteShopView.snp.makeConstraints { (make) in
            make.left.equalTo(applyShopView.snp.right)
            make.top.equalToSuperview()
            make.width.equalTo(ScreenW/4)
            make.height.snEqualTo(120)
        }
        
    }

}
