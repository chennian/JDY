//
//  InfoView.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class ShopHeadView: SNBaseView {
    
    var clickEvent:(()->())?
    var clickEvent2:(()->())?

    
    let img = UIImageView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.layer.cornerRadius = fit(75)
        $0.layer.masksToBounds = true
    }
    
    let shopName = UILabel().then{
        $0.text = "店名"
        $0.font = Font(26)
        $0.textColor = Color(0xffffff)
    }
    
    let address = UILabel().then{
        $0.text = "地址"
        $0.font = Font(22)
        $0.textColor = Color(0xffffff)
    }
    
    let levelButton = UIButton().then{
        $0.setTitle(" 1级", for: .normal)
        $0.setImage(UIImage(named: "garde"), for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(22)
    }
    
    let contributeButton = UIButton().then{
        $0.setImage(UIImage(named: "exp"), for: .normal)
        $0.isHidden = true
    }
    let contributeLabel = UILabel().then{
        $0.text = ""
        $0.font = Font(22)
        $0.textColor = Color(0xffffff)
    }
    
    let settingButton = UIButton().then{
        $0.setImage(UIImage(named: "setting"), for: .normal)
    }
    
    let serviceButton = UIButton().then{
        $0.setImage(UIImage(named: "serviceIcon"), for: .normal)
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
    
    override func setupView() {
        
        
        self.addSubviews(views: [img,shopName,address ,levelButton,contributeLabel,settingButton,serviceButton])
        
        settingButton.addTarget(self, action: #selector(tapAction), for: .touchUpInside)
        serviceButton.addTarget(self, action: #selector(tapAction2), for: .touchUpInside)

        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(110)
            make.height.width.snEqualTo(150)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.top).snOffset(30)
            make.left.equalTo(img.snp.right).snOffset(10)
        }
        
    
        
        levelButton.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(0)
            make.top.equalTo(shopName.snp.bottom).snOffset(10)
            make.width.snEqualTo(100)
            make.height.snEqualTo(40)
        }
        
    
    
        contributeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(levelButton.snp.right).snOffset(10)
            make.centerY.equalTo(levelButton.snp.centerY)
        }
        
        address.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(10)
            make.top.equalTo(levelButton.snp.bottom).snOffset(10)
            make.right.equalToSuperview().snOffset(-30)
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

