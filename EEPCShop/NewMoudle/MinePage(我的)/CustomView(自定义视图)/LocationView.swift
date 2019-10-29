//
//  LocationView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/5.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class LocationView: SNBaseView {
    
    var clickEvent:(()->())?
    
    let name = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0x262626)
    }
    
    let textfield = UITextField().then{
        $0.borderStyle = .none
        $0.font = Font(26)
        $0.textColor = Color(0xa3a2a2)
        $0.textAlignment = .right
        $0.isUserInteractionEnabled = false
    }
    
    let locationButton = UIButton().then{
        $0.setImage(UIImage(named: "location"), for: .normal)
    }
    
    let line = UIView().then{
        $0.backgroundColor = Color(0xd3dbea)
    }
    @objc func click(){
        guard let action  =  clickEvent else {
            return
        }
        action()
    }
    
    override func setupView() {
        self.addSubviews(views: [name,textfield,locationButton,line])
        
        locationButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        name.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().snOffset(35)
            make.width.snEqualTo(70)
        }
    
        locationButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-65)
            make.centerY.equalToSuperview()
            make.width.height.snEqualTo(50)
        }
        
        textfield.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right).snOffset(30)
            make.centerY.equalToSuperview()
            make.right.equalTo(locationButton.snp.left).snOffset(-30)
        }
        
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(1)
            make.bottom.equalToSuperview()
        }
    }
}
extension LocationView{
    func set(name: String, placeHolder: String) {
        self.name.text = name
        self.textfield.placeholder = placeHolder
    }
}
