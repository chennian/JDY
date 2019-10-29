//
//  MerchantCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MerchantCell: SNBaseTableViewCell {
    
    let baseView = UIView().then{
        $0.backgroundColor = ColorRGB(red: 254, green: 253, blue: 253)
        $0.layer.cornerRadius = fit(16)
    }
    
    let img = UIImageView().then{
       $0.contentMode = .scaleAspectFit
       $0.backgroundColor = .red
    }

    let name = UILabel().then{
        $0.font = BoldFont(32)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.text = "店家名称"
    }
    
    let des = UILabel().then{
        $0.font = Font(26)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.text = "折扣比例（￥:EEPC:USDT）"
    }
    
    let address = UILabel().then{
        $0.font = Font(26)
        $0.textColor = ColorRGB(red: 169, green: 174, blue: 190)
        $0.text = "深圳市龙华区民治街道嘉熙业广场"
    }
    
    override func setupView() {
        hidLine()

        self.contentView.backgroundColor = Color(0xf5f5f5)
        self.contentView.addSubview(baseView)
        baseView.addSubview(img)
        baseView.addSubview(name)
        baseView.addSubview(des)
        baseView.addSubview(address)
        
        baseView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.snEqualTo(206)
            make.width.snEqualTo(690)
        }
        
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(baseView.snp.centerY)
            make.left.equalTo(baseView.snp.left).snOffset(20)
            make.height.width.snEqualTo(168)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.top).snOffset(4)
            make.left.equalTo(img.snp.right).snOffset(24)
        }
        
        des.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).snOffset(22)
            make.left.equalTo(img.snp.right).snOffset(24)
        }
        
        address.snp.makeConstraints { (make) in
            make.bottom.equalTo(img.snp.bottom).snOffset(-6)
            make.left.equalTo(img.snp.right).snOffset(24)
        }
    }
}
