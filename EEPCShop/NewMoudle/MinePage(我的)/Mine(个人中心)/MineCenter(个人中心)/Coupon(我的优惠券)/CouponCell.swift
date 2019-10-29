//
//  CouponCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/15.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class CouponCell: SNBaseTableViewCell {
    
    var model:UserCouponModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            if cellModel.type == "1"{
                title.text = "满" + cellModel.base + "减" + cellModel.bonus
            }else{
                title.text = "大圣商城" + "满" + cellModel.base + "减" + cellModel.bonus + "优惠券"
            }
            
            if cellModel.used == "0" {
                
                let time = NSDate()
                let avail =  self.stringConvertDate(string:cellModel.availdate)
                
                if  time as Date > avail {
                    baseViewImage.image = UIImage(named: "usecoupon")
                    timeLable.text = cellModel.availdate
                    status.text = "已过期"
                }else{
                    if cellModel.type == "1"{
                        baseViewImage.image = UIImage(named: "bgcolor")
                    }else{
                        baseViewImage.image = UIImage(named: "dacoupon")
                    }
                    timeLable.text = cellModel.availdate
                    status.text = "未使用"
                }
            }else{
                baseViewImage.image = UIImage(named: "usecoupon")
                timeLable.text = cellModel.availdate
                status.text = "已使用"
            }
        }
        
    }
    
    func stringConvertDate(string:String, dateFormat:String="yyyy-MM-dd HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: string)
        return date!
    }
    
    
    let baseViewImage = UIImageView().then{
        $0.backgroundColor = .clear
    }
    
    
    let title = UILabel().then{
        $0.text = ""
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let timeLable = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
        $0.text = ""
    }
    
    let status = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
        $0.text = ""
    }
    
    
    
    override func setupView() {
        self.addSubviews(views: [baseViewImage])
        baseViewImage.addSubviews(views: [title,timeLable,status])
        
        
        baseViewImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.right.equalToSuperview().snOffset(-40)
            make.height.snEqualTo(144)
            make.centerY.equalToSuperview()
        }
        
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.top.equalToSuperview().snOffset(25)
        }
        
        timeLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.top.equalTo(title.snp.bottom).snOffset(25)
        }
        
        
        status.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }
        
    }
    
    
}
