//
//  MinePageHeadCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/3.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MinePageHeadCell: SNBaseTableViewCell {
    
    let img = UIImageView().then{
        $0.image = UIImage(named: "mineLayer1")
    }
    
    let name = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(36)
        $0.text = "老陈"
    }
    
    let levelView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let level = UILabel().then{
        $0.textColor = Color(0x3660fb)
        $0.font = Font(26)
        $0.text = "普通会员"
    }
    

    override func setupView() {
        self.contentView.backgroundColor = Color(0xf5f5f5)

        self.contentView.addSubview(img)
        img.addSubview(name)
        img.addSubview(levelView)
        levelView.addSubview(level)
        hidLine()
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(35)
            make.height.snEqualTo(290)
        }
        
        name.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.left).snOffset(58)
            make.top.equalTo(img.snp.top).snOffset(46)
        }
        
        levelView.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.left)
            make.top.equalTo(name.snp.bottom).snOffset(20)
            make.height.snEqualTo(40)
            make.width.snEqualTo(126)
        }
        
        level.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
    }

}
