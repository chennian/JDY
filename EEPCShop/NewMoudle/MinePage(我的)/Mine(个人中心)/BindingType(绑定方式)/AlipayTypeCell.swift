//
//  AlipayTypeCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/21.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class AlipayTypeCell: SNBaseTableViewCell {
    
    var cellModel:BindingModel?{
        didSet{
            guard let model = cellModel else {
                return
            }
            
            img.kf.setImage(with: URL(string:httpUrl +  model.apliy_receiev_code))
        }
    }
    
    let mark = UIView().then{
        $0.backgroundColor = Color(0x3660fb)
    }
    
    let lable = UILabel().then{
        $0.text = "支付宝"
        $0.font = Font(32)
        $0.textColor = Color(0x2a3457)
    }
    
    let img = UIImageView().then{
        $0.image = UIImage(named: "card_bgimg")
//        $0.contentMode = .scaleAspectFill
    }
    
    
    override func setupView() {
        self.contentView.addSubviews(views: [mark,lable,img])
        
        mark.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(45)
            make.left.equalToSuperview().snOffset(42)
            make.height.snEqualTo(32)
            make.width.snEqualTo(4)
        }
        
        lable.snp.makeConstraints { (make) in
            make.centerY.equalTo(mark.snp.centerY)
            make.left.equalTo(mark.snp.right).snOffset(10)
        }
        
        img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(mark.snp.bottom).snOffset(26)
            make.height.snEqualTo(388)
        }
        
    }
}
