//
//  TitleCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/19.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class TitleCell: SNBaseTableViewCell {
    
    let lable1 = UILabel().then{
        $0.text = "金额(￥)"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    let lable2 = UILabel().then{
        $0.text = "时间"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    let lable3 = UILabel().then{
        $0.text = "实收(￥)"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }

    override func setupView() {
        self.contentView.addSubviews(views: [lable1,lable2,lable3])
        
        lable1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(53)
            make.centerY.equalToSuperview()
        }
        
        lable2.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(lable1.snp.centerY)
        }
        
        lable3.snp.makeConstraints { (make) in
            make.centerY.equalTo(lable1.snp.centerY)
            make.right.equalToSuperview().snOffset(-54)
        }
        
    }

}
