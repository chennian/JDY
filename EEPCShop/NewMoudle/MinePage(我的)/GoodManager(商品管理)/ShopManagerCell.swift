//
//  ShopManagerCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/8/30.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ShopManagerCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para:Int)->())?

    
    let dot = UIView().then{
        $0.backgroundColor = Color(0x2A3457)
        $0.layer.cornerRadius = fit(9)
    }
    
    let shopInfoLable = UILabel().then{
        $0.textColor = Color(0x2A3457)
        $0.text = "店铺信息"
        $0.font = BoldFont(32)
    }
    
    
    let shopPhoneLabel = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "商家电话"
        $0.font = Font(32)
    }
    
    let shopPhoneField = UITextField().then{
        $0.placeholder = "请输入商家电话"
        $0.textColor = Color(0x262626)
        $0.font = Font(32)
        $0.textAlignment = .right
    }
    
    let shopLabel = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "商家标签"
        $0.font = Font(32)
    }
    
    let shopLableField = UITextField().then{
        $0.placeholder = "请输入商家标签"
        $0.textColor = Color(0x262626)
        $0.font = Font(32)
        $0.textAlignment = .right
    }
    
    let shopDesLabel = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "商家描述"
        $0.font = Font(32)
    }
    
    let shopDesText = SLTextView().then{
        $0.backgroundColor = Color(0xF2F2F2)
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请输入商家描述"
        $0.placeholderColor = Color(0xC7C7CC)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0xd8dade).cgColor
        $0.layer.cornerRadius = fit(6)
    }
    
    let shopDetailLabel = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "商家描述"
        $0.font = Font(32)
    }
    
    let shopMainImage = UIButton().then{
        $0.backgroundColor = Color(0xffffff)
        $0.tag = 10
        $0.contentMode = .scaleAspectFill
        $0.setImage(UIImage(named: "picture"), for: .normal)
        $0.layer.cornerRadius = fit(10)
    }
    
    let shopMainLable = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "店铺主图"
        $0.font = Font(32)
    }
    
    let shopDetailImage = UIButton().then{
        $0.backgroundColor = Color(0xffffff)
        $0.tag = 20
        $0.contentMode = .scaleAspectFill
        $0.setImage(UIImage(named: "picture"), for: .normal)
        $0.layer.cornerRadius = fit(10)
    }
    
    let shopImgLable = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.text = "店铺详情图"
        $0.font = Font(32)
    }   
    
    let submitButton = UIButton().then{
        $0.backgroundColor = Color(0x2777ff)
        $0.layer.cornerRadius = fit(49)
        $0.setTitle("提交", for:.normal)
        $0.setTitleColor(UIColor.white, for:.normal)
        $0.titleLabel?.font = Font(32)
        $0.tag = 30
    }
    
    let line1 = UIView().then(){
        $0.backgroundColor = Color(0xD3DBEA)
    }
    
    let line2 = UIView().then(){
        $0.backgroundColor = Color(0xD3DBEA)
    }
    
    func bindEvent(){
        submitButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        shopMainImage.addTarget(self, action: #selector(click), for: .touchUpInside)
        shopDetailImage.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    @objc func click(sender:UIButton){
        guard let action = clickEvent else {
            return
        }
        action(sender.tag)
    }
    
    
    override func setupView() {
        self.addSubviews(views: [dot,shopInfoLable,shopPhoneLabel,shopPhoneField,shopLabel,shopLableField,shopDesLabel,shopDesText,line1,line2,shopMainLable,shopMainImage,shopImgLable,shopDetailImage,submitButton])
        
        bindEvent()
        
        line1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.top.equalToSuperview().snOffset(180)
            make.height.snEqualTo(1)
        }
        
        line2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.top.equalTo(line1.snp.bottom).snOffset(99)
            make.height.snEqualTo(1)
        }
        
        dot.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.left.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(18)
        }
        
        shopInfoLable.snp.makeConstraints { (make) in
            make.left.equalTo(dot.snp.right).snOffset(20)
            make.centerY.equalTo(dot.snp.centerY)
        }

        shopPhoneLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(38)
            make.bottom.equalTo(line1.snp.top).snOffset(-34)
        }
        
        shopPhoneField.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-40)
            make.centerY.equalTo(shopPhoneLabel.snp.centerY)
            make.left.equalTo(shopPhoneLabel.snp.right).snOffset(100)
        }
        shopLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(38)
            make.bottom.equalTo(line2.snp.top).snOffset(-34)
        }
        
        shopLableField.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-40)
            make.centerY.equalTo(shopLabel.snp.centerY)
            make.left.equalTo(shopLabel.snp.right).snOffset(100)
        }
        
        shopDesLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(38)
            make.top.equalTo(line2.snp.bottom).snOffset(35)
        }
        
        shopDesText.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(shopDesLabel.snp.bottom).snOffset(20)
            make.height.snEqualTo(230)
        }
        
        shopMainLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(shopDesText.snp.bottom).snOffset(20)
        }
        
        shopMainImage.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
            make.top.equalTo(shopMainLable.snp.bottom).snOffset(20)
            make.width.height.snEqualTo(238)
        }
        
        shopImgLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(shopMainImage.snp.bottom).snOffset(20)
        }
        
        shopDetailImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(shopImgLable.snp.bottom).snOffset(20)
            make.height.snEqualTo(238)
            
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(shopDetailImage.snp.bottom).snOffset(50)
            make.height.snEqualTo(98)
        }
    }
    
}
