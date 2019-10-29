//
//  topFunctionView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class topFunctionView: SNBaseView {
    let image = UIImageView()
    
    let label = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(26)
    }

    override func setupView() {
        self.addSubview(image)
        self.addSubview(label)
        
        image.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
            make.width.height.snEqualTo(66)
        }
        
        label.snp.makeConstraints { (make) in
            make.top.equalTo(image.snp.bottom).snOffset(18)
            make.centerX.equalToSuperview()
        }
        
    }
}
