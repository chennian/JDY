//
//  InfoPikerView.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class InfoPikerView: SNBaseView {
    
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
    
    let accessoryImageView = UIImageView().then {
        $0.image = Image("dropdown")
    }
    
    
    let line = UIView().then{
        $0.backgroundColor = Color(0xd3dbea)
    }
    
    func hidLine() {
        line.isHidden = true
    }
    
    override func setupView() {
        self.addSubviews(views: [name,textfield,line,accessoryImageView])
        
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
        
        textfield.snp.makeConstraints { (make) in
            make.right.equalTo(accessoryImageView.snp.left).snOffset(-27)
            make.centerY.equalTo(accessoryImageView.snp.centerY)
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
extension InfoPikerView{
    func set(name: String, placeHolder: String) {
        self.name.text = name
        self.textfield.placeholder = placeHolder
    }
}
