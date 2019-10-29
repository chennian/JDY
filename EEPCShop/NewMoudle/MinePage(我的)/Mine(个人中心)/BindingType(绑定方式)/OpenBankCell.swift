//
//  OpenBankType.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/30.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class OpenBankCell: SNBaseTableViewCell {
    
    var cellModel:BindingModel?{
        didSet{
            guard let model = cellModel else {
                return
            }
            bank_type.text = model.open_bank_type
            bank_branch.text = model.open_bank_branch
            
            
            bank_no.text = model.open_bank_no.formateForBankCard()
            
            
            
            holdPerson.text = model.open_bank_name
//            addressCity.text = model.bank_city
            
        }
    }
    
    let mark = UIView().then{
        $0.backgroundColor = Color(0x3660fb)
    }
    
    let lable = UILabel().then{
        $0.text = "公户"
        $0.font = Font(32)
        $0.textColor = Color(0x2a3457)
    }
    
    let img = UIImageView().then{
        $0.image = UIImage(named: "card_bgimg")
    }
    
    
    
    let bank_type = UILabel().then{
        $0.text = "招商银行"
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let bank_branch = UILabel().then{
        $0.text = "宝路支行"
        $0.font = Font(26)
        $0.textColor = Color(0x7b93f5)
    }
    
    
    let bank_no = UILabel().then{
        $0.text = "1872  6543  9870  5894  217"
        $0.font = Font(38)
        $0.textColor = Color(0xffffff)
    }
    
    let holdLable = UILabel().then{
        $0.text = "持卡人"
        $0.font = Font(26)
        $0.textColor = Color(0x7d95f5)
    }
    
    let holdPerson = UILabel().then{
        $0.text = "张大邮"
        $0.font = Font(28)
        $0.textColor = Color(0xffffff)
    }
    
    let addressLable = UILabel().then{
        $0.text = "所在地"
        $0.font = Font(26)
        $0.textColor = Color(0x7d95f5)
        $0.isHidden = true
    }
    
    
    let addressCity = UILabel().then{
        $0.text = "深圳市"
        $0.font = Font(28)
        $0.textColor = Color(0xffffff)
        $0.isHidden = true
    }
    
    
    override func setupView() {
        self.contentView.addSubviews(views: [mark,lable,img])
        
        img.addSubviews(views: [bank_type,bank_branch,bank_no,holdLable,holdPerson,addressLable,addressCity])
        
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
        
        bank_type.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(46)
            make.top.equalToSuperview().snOffset(65)
        }
        
        bank_branch.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-46)
            make.centerY.equalTo(bank_type.snp.centerY)
        }
        
        bank_no.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(46)
            make.top.equalTo(bank_type.snp.bottom).snOffset(45)
        }
        
        holdLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(46)
            make.top.equalTo(bank_no.snp.bottom).snOffset(45)
        }
        holdPerson.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(46)
            make.top.equalTo(holdLable.snp.bottom).snOffset(18)
        }
        
        addressLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(holdLable.snp.centerY)
            make.right.equalToSuperview().snOffset(-46)
        }
        addressCity.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-46)
            make.top.equalTo(addressLable.snp.bottom).snOffset(18)
        }
        
        
    }
}
