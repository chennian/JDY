//
//  TopGuildCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/30.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class TopGuideCell: SNBaseTableViewCell {
    let shopInfo = UILabel().then{
        $0.text = "商家信息"
        $0.textColor = Color(0xc0c6dd)
        $0.font = Font(28)
    }
    
    let guideLineOne = UIImageView().then{
        $0.image = UIImage(named: "Guidelines")
    }
    
    let receiveInfo = UILabel().then{
        $0.text = "收款信息"
        $0.textColor = Color(0xc0c6dd)
        $0.font = Font(28)
    }
    let guideLineTwo = UIImageView().then{
        $0.image = UIImage(named: "Guidelines")
    }
    let imgInfo = UILabel().then{
        $0.text = "上传照片"
        $0.textColor = Color(0xc0c6dd)
        $0.font = Font(28)
    }
    
    override func setupView() {
        hidLine()
        self.contentView.addSubviews(views: [shopInfo,guideLineOne,receiveInfo,guideLineTwo,imgInfo])
        
        shopInfo.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(57)
            make.centerY.equalToSuperview()
        }
        
        receiveInfo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        guideLineOne.snp.makeConstraints { (make) in
            make.left.equalTo(shopInfo.snp.right).snOffset(25)
            make.centerY.equalToSuperview()
            make.right.equalTo(receiveInfo.snp.left).snOffset(-25)
            make.height.snEqualTo(14)
        }
        
        imgInfo.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-57)
            make.centerY.equalToSuperview()
        }
        
        guideLineTwo.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.height.snEqualTo(14)
            make.left.equalTo(receiveInfo.snp.right).snOffset(25)
            make.right.equalTo(imgInfo.snp.left).snOffset(-25)
        }
        
        
    }

}
