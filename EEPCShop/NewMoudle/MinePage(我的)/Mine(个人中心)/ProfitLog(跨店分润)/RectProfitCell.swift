//
//  RectProfitCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/27.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class RectProfitCell: SNBaseTableViewCell {
    
    var model:RectProfitModel?{
        didSet{
            guard let cellModel = model  else { return }
            
            num.text = "+\(cellModel.profit)"
            time.text = cellModel.add_time
            
        }
    }
    
    
    let num = UILabel().then{
        $0.text = "+100"
        $0.textColor = Color(0x262626)
        $0.font = BoldFont(36)
    }
    let time = UILabel().then{
        $0.text = "2019-04-27"
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(30)
    }

    
    override func setupView() {
        
        self.contentView.addSubviews(views: [self.num,self.time])
  
        
        num.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().snOffset(30)
        }
        
        time.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }
    }
}
