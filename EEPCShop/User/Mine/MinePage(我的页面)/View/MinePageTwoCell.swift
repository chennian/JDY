//
//  MinePageTwoCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/3.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MinePageTwoCell: SNBaseTableViewCell {
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(20)
    }
    
    let one  = MineInfoView().then{
        $0.layer.cornerRadius = fit(20)
    }
    let two  = MineInfoView().then{
        $0.layer.cornerRadius = fit(20)
    }
    
    override func setupView() {
        self.contentView.backgroundColor = Color(0xf5f5f5)
        self.contentView.addSubview(baseView)
        self.baseView.addSubviews(views: [one,two])
        
        one.set(img:UIImage(named: "share")!, name: "分享好友")
        two.set(img:UIImage(named: "about")!, name: "关于我们")
        two.hidLine()
        
        self.baseView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
        }
        
        
        one.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.snEqualTo(125)
        }
        
        two.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(one.snp.bottom)
            make.height.snEqualTo(125)
        }
        
    }
    
}
