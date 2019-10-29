//
//  PhoneView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class PhoneView: SNBaseView {
    
    var clickEvent:(()->())?
    
    let number = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.font = BoldFont(40)
    }
    
    let des = UILabel().then{
        $0.textColor = Color(0x262626)
        $0.font = Font(28)
    }

    
    
    @objc func tapAction(){
        guard let action = clickEvent else {
            return
        }
        action()
    }
    
    override func setupView() {
        
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        self.addGestureRecognizer(tap)
        
        self.addSubview(number)
        self.addSubview(des)
        
        number.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(50)
        }
        
        des.snp.makeConstraints { (make) in
            make.top.equalTo(number.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
    }

}
