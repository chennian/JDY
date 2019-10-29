//
//  CashLogCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/27.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class CashLogCell: SNBaseTableViewCell {
    
    var model:CashLogModel?{
        didSet{
            guard let cellModel = model  else { return }
            if cellModel.type == "1" {
                type.text = "提现到银行卡"
            }else if cellModel.type == "2"{
                type.text = "提现到支付宝"
            }else if cellModel.type == "3"{
                type.text = "提现到微信"
            }else{
                type.text = "提现到公户"
            }
            
            
            num.text = "￥ \(cellModel.num)"
            time.text = cellModel.add_time
            
            if cellModel.status == "1" {
                status.text = "审核中"
            }else if cellModel.status == "2"{
                status.text = "已打款"
            }else{
                status.text = "打款失败"
            }
            
        }
    }
    
    
    
    let type = UILabel().then{
        $0.text = "微信提现"
        $0.textColor = Color(0x262626)
        $0.font = Font(36)
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
    let status = UILabel().then{
        $0.text = "待审核"
        $0.textColor = Color(0x2777ff)
        $0.font = Font(30)
    }
    
    override func setupView() {
        
        self.contentView.addSubviews(views: [self.type,self.num,self.time,self.status])
        type.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.left.equalToSuperview().snOffset(30)
        }
        
        num.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(type.snp.centerY)
        }
        
        time.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(type.snp.bottom).snOffset(20)
        }
        
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalTo(time.snp.centerY)
        }
        
    }
}
