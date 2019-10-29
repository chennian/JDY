//
//  WalletDetailHeadCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/4.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class WalletDetailHeadCell: SNBaseTableViewCell {
    
    let img1 = UIImageView().then{
        $0.backgroundColor = Color(0x3660fb)
    }
    let name1  = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.text = "转入地址"
        $0.font = Font(32)
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xfefdfd)
        $0.layer.cornerRadius = fit(20)
    }
    
    let codeImageView = UIImageView().then{
        $0.backgroundColor = .red
    }
    
    let walletAddress = UILabel().then{
        $0.font = Font(30)
        $0.text = "83jksdj83j7dsj83iks802ksd6ft3j7de"
        $0.numberOfLines = 0
        $0.textColor = Color(0x2a3457)
    }

    let copyBtn = UIButton().then{
        $0.setTitle("复制地址", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.backgroundColor = Color(0x3660fb)
        $0.layer.cornerRadius = fit(30)
    }
    
    let img2 = UIImageView().then{
        $0.backgroundColor = Color(0x3660fb)
    }
    let name2  = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.text = "交易记录"
        $0.font = Font(32)
    }
    

    override func setupView() {
        self.contentView.backgroundColor = Color(0xf0f0f0)
        
        self.contentView.addSubviews(views: [img1,name1,baseView,img2,name2])
        
        baseView.addSubviews(views: [codeImageView,walletAddress,copyBtn])
        
        img1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.snEqualTo(4)
            make.height.snEqualTo(32)
        }
        
        name1.snp.makeConstraints { (make) in
            make.left.equalTo(img1.snp.right).snOffset(11)
            make.centerY.equalTo(img1.snp.centerY)
        }
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(img1.snp.bottom).snOffset(22)
            make.height.snEqualTo(292)
        }
        
        codeImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(36)
            make.centerY.equalToSuperview()
            make.height.width.snEqualTo(224)
        }
        
        walletAddress.snp.makeConstraints { (make) in
            make.left.equalTo(codeImageView.snp.right).snOffset(33)
            make.top.equalTo(codeImageView.snp.top)
            make.right.equalToSuperview().snOffset(-50)
            make.height.snEqualTo(80)
        }
        
        copyBtn.snp.makeConstraints { (make) in
            make.bottom.equalTo(codeImageView.snp.bottom)
            make.left.equalTo(codeImageView.snp.right).snOffset(38)
            make.width.snEqualTo(215)
            make.height.snEqualTo(60)
        }
        
        img2.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(baseView.snp.bottom).snOffset(51)
            make.width.snEqualTo(4)
            make.height.snEqualTo(32)
        }
        
        name2.snp.makeConstraints { (make) in
            make.left.equalTo(img2.snp.right).snOffset(11)
            make.centerY.equalTo(img2.snp.centerY)
        }
        
        
    
        
    }
}
