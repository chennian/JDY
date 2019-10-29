//
//  ThreeCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ThreeCell: SNBaseTableViewCell {
    var clickEvent:((_ para:Int)->())?
    
    var clickBtnEvent:(()->())?

    
    var model:ShopMsgModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            self.shopHeadView.img.kf.setImage(with: URL(string: httpUrl + cellModel.main_img))
            self.shopHeadView.address.text = "地址:" + cellModel.province + cellModel.city + cellModel.area +  cellModel.address_detail
            self.shopHeadView.shopName.text =  cellModel.shop_name
            self.shopHeadView.contributeLabel.text = "贡献值:" + "\(cellModel.contributePoint)"
            self.shopHeadView.levelButton.setTitle(" \(cellModel.level)级", for: .normal)

        }
    }
    
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let shopHeadView = ShopHeadView().then{
//        $0.backgroundColor = Color(0x005eb7)
        $0.backgroundColor = ColorRGB(red: 81.0, green: 130.0, blue: 255.0)
    }
    let shopfuncView = WaitShopView().then{
//        $0.backgroundColor = Color(0x005eb7)
        $0.backgroundColor = ColorRGB(red: 81.0, green: 130.0, blue: 255.0)
        $0.applyShopView.lblTitle.text = "重新提交"
    }
    let statusButton = UIButton().then{
        $0.backgroundColor = Color(0xf26c4f)
        $0.setTitle("店铺资料审核失败,请重新提交", for: .normal)
    }
    let toolView = UserToolView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let rmdToolView = RmdToolView().then{
        $0.backgroundColor = Color(0xffffff)
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
    @objc func btnAction(){
        guard let action = self.clickBtnEvent else {
            return
        }
        action()
    }
    
    
    func bindEvent(){
        
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        rmdImageView.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        rmdUserBanner.addGestureRecognizer(tapB)
        
        statusButton.addTarget(self, action: #selector(btnAction), for: .touchUpInside)

    }
    
    
    override func setupView() {
        hidLine()
        self.contentView.addSubview(self.baseView)
        self.contentView.addSubview(rmdImageView)
        self.contentView.addSubview(rmdToolView)
        self.contentView.addSubview(rmdUserBanner)

        
        self.baseView.addSubview(self.shopHeadView)
        self.baseView.addSubview(self.statusButton)
        self.baseView.addSubview(self.toolView)
        self.baseView.addSubview(self.shopfuncView)

        bindEvent()
        self.baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(1150 + 160)
        }
        
        
        shopHeadView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(300)
        }
        shopfuncView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(shopHeadView.snp.bottom)
            make.height.snEqualTo(160)
        }
        
        
        statusButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(shopfuncView.snp.bottom)
            make.height.snEqualTo(120)
        }
        
        rmdUserBanner.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(statusButton.snp.bottom)
            make.height.snEqualTo(140)
        }
        
        toolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(rmdUserBanner.snp.bottom)
            make.height.snEqualTo(240)
        }
        
        rmdToolView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(toolView.snp.bottom)
            make.height.snEqualTo(240)
            
        }
        
        rmdImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(150)
            make.top.equalTo(rmdToolView.snp.bottom)
        }
        

    }
}
