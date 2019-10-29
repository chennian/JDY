//
//  TableViewCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/15.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ServiceCell: SNBaseTableViewCell {
    
    
    
    var model :ServiceModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            CNLog(cellModel)
            
            askLabel.text = cellModel.content
            time.text = cellModel.add_time
            
            if cellModel.reply == "" {
                replyLabel.text  = "请耐心等待客服回复。"
            }else{
                replyLabel.text = cellModel.reply
            }
            
        }
    }
    
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(10)
    }
    

    let askImg = UIImageView().then{
        $0.backgroundColor = Color(0xe1e1e1)
        $0.layer.cornerRadius = fit(60)
        $0.layer.masksToBounds = true
    }
    
    let imgLable = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(36)
        $0.text = "我"
    }
    
    
    let askLabel = UITextView().then{
        $0.textColor = Color(0x262626)
        $0.isEditable = false
    }
    
    let time = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
    }
    
    let cutLine = UIView().then{
        $0.backgroundColor = Color(0xa9aebe)
    }
    
    let replyImg =  UIImageView().then{
        $0.image = UIImage(named: "cs")
        $0.backgroundColor = Color(0xf2e945)
        $0.layer.cornerRadius = fit(60)
        $0.layer.masksToBounds = true
        $0.contentMode = .scaleToFill
    }
    
    let replyLabel = UITextView().then{
        $0.textColor = Color(0x262626)
        $0.isEditable = false
    }
    
    

    override func setupView() {
        
        hidLine()
        self.addSubview(baseView)
        self.contentView.backgroundColor = Color(0xf5f5f5)
        baseView.addSubviews(views: [askImg,imgLable,askLabel,time,cutLine,replyImg,replyLabel])
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(30)
            make.height.snEqualTo(400)
        }
        
        askImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(120)
        }
        
        imgLable.snp.makeConstraints { (make) in
            make.centerX.equalTo(askImg.snp.centerX)
            make.centerY.equalTo(askImg.snp.centerY)
        }
        
        askLabel.snp.makeConstraints { (make) in
            make.left.equalTo(askImg.snp.right).snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(30)
            make.height.snEqualTo(120)
        }
        
        time.snp.makeConstraints { (make) in
            make.left.equalTo(askImg.snp.right).snOffset(30)
            make.top.equalTo(askLabel.snp.bottom).snOffset(20)
        }
        
        cutLine.snp.makeConstraints { (make) in
            make.top.equalTo(time.snp.bottom).snOffset(30)
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
        }
        
        replyImg.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalTo(cutLine.snp.bottom).snOffset(20)
            make.width.height.snEqualTo(120)
        }
        
        replyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(replyImg.snp.right).snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(cutLine.snp.bottom).snOffset(20)
            make.height.snEqualTo(120)

        }
        
    }

}
