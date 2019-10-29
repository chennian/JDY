//
//  IDCardUploadView.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class UploadView: SNBaseView {
    
    let nameLable  =  UILabel().then{
        $0.textColor = Color(0x262626)
        $0.font = Font(32)
    }
    
    let imageView = UIButton().then{
        $0.backgroundColor = Color(0xffffff)
        $0.contentMode = .scaleAspectFill
    }
    
    override func setupView() {
        self.addSubviews(views: [nameLable,imageView])
        
        nameLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLable.snp.bottom).snOffset(30)
            make.width.snEqualTo(620)
            make.height.snEqualTo(348)
        }
    }

}
