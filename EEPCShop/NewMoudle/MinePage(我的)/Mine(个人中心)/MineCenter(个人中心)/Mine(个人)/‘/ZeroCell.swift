//
//  ZeroCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ZeroCell: SNBaseTableViewCell {
    
    
    var clickEvent:((_ para:Int)->())?


    var model:UserModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            
            userHeadView.phone.text = cellModel.phone
            userHeadView.contributeLable.text = "贡献值:" + cellModel.contribute_point

            userHeadView.balanceProfit.text = cellModel.money + " 元"
            userHeadView.rmdProfit.text = cellModel.rmdProfit + " 元"
        }
    }
    
    
    let userbaseView =  UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let userHeadView = UserHeadView().then{
//        $0.backgroundColor = Color(0x005eb7)
        $0.backgroundColor = ColorRGB(red: 81.0, green: 130.0, blue: 255.0)
    }
    
    
    let userToolView = UserToolView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let rmdToolView = RmdToolView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    let rmdImageView = UIImageView().then{
        $0.image = UIImage(named: "my")
        $0.isUserInteractionEnabled = true
    }

    let rmdUserBanner = UIImageView().then{
        $0.image = UIImage(named: "rmdUser")
        $0.isUserInteractionEnabled = true
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
    
    func bindEvent(){
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        rmdImageView.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        rmdUserBanner.addGestureRecognizer(tapB)
    }
    
    override func setupView() {
        hidLine()
        
        self.contentView.backgroundColor = Color(0xffffff)
        self.contentView.addSubview(self.userbaseView)
        self.contentView.addSubview(rmdImageView)
        self.contentView.addSubview(rmdUserBanner)


        self.userbaseView.addSubview(self.userHeadView)
        self.userbaseView.addSubview(self.userToolView)
        self.userbaseView.addSubview(self.rmdToolView)

        bindEvent()
        self.userbaseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(1125  + 100)
        }
        
        userHeadView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(300 + 170 + 60 + 48)
            
        }
        
        rmdUserBanner.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(150)
            make.top.equalTo(userHeadView.snp.bottom).snOffset(20)
        }

        
        userToolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(rmdUserBanner.snp.bottom)
            make.height.snEqualTo(260)
        }
        
  
        
        rmdToolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(userToolView.snp.bottom)
            make.height.snEqualTo(260)
        }
        
        rmdImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(150)
            make.top.equalTo(rmdToolView.snp.bottom).snOffset(20)
        }
    
    }
}
