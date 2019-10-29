//
//  InfoSelectView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/30.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class InfoSelectView: SNBaseView {
    
    let name = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0x262626)
    }
    
    
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(32)
        $0.textColor = Color(0x262626)
        $0.textAlignment = .right
    }
    
    let selectType = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(32)
        $0.textColor = Color(0x262626)
        $0.textAlignment = .right
        $0.placeholder = "邀请进驻类型"
    }
    
    let accessoryImageView = UIImageView().then {
        $0.image = Image("dropdown")
    }
    

    
    let line = UIView().then{
        $0.backgroundColor = Color(0xd3dbea)
    }
    
    override func setupView() {
        self.addSubviews(views: [name,textfield,line,selectType,accessoryImageView])
        
        name.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().snOffset(35)
        }
        
        accessoryImageView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().snOffset(-42)
            make.width.snEqualTo(18)
            make.height.snEqualTo(14)
        }
        
        selectType.snp.makeConstraints { (make) in
            make.right.equalTo(accessoryImageView.snp.left).snOffset(-27)
            make.centerY.equalTo(accessoryImageView.snp.centerY)
            make.width.snEqualTo(180)
        }
        
        textfield.snp.makeConstraints { (make) in
            make.right.equalTo(selectType.snp.left).snOffset(-30)
            make.centerY.equalToSuperview()
            make.width.snEqualTo(300)
        }
        
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }
        
    }
}
extension InfoSelectView{
    func set(name: String, placeHolder: String) {
        self.name.text = name
        self.textfield.placeholder = placeHolder
    }
}
