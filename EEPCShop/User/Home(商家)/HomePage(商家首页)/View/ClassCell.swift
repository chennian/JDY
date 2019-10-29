//
//  ClassCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ClassCell: SNBaseTableViewCell {
    var slidingMenuView = CoolSlidingMenuView().then{
        $0.pgCtrl.isHidden = false
        $0.contentMode = .scaleAspectFit
        $0.pgCtrlNormalColor = .lightGray
        $0.pgCtrlSelectedColor = .red
        $0.countRow = 2
        $0.countCol = 4

    }

    override func setupView() {
        hidLine()

        self.contentView.addSubview(slidingMenuView)
        
        let arrMenu = [
            ["title":"餐饮副食","image":"food.png"],
            ["title":"旅游住宿","image":"tourism.png"],
            ["title":"日用百货","image":"commodity.png"],
            ["title":"装饰装修","image":"decoration.png"],
            ["title":"数码电子","image":"Digital.png"],
            ["title":"教育培训","image":"education.png"],
            ["title":"医疗服务","image":"Medical.png"],
            ["title":"机械设备","image":"device.png"]
        ]
        slidingMenuView.arrMenu = arrMenu
        
        slidingMenuView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
