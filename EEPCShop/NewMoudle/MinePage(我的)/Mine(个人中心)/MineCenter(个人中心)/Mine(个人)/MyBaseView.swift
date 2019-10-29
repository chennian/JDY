//
//  MyBaseView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/21.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MyBaseView: SNBaseView {
    
    var imgViewIcon = UIImageView().then{
        $0.contentMode = .scaleAspectFit
    }
    var lblTitle = UILabel().then{
        $0.font = Font(24)
    }
    

    override func setupView() {
        
        self.addSubview(imgViewIcon)
        self.addSubview(lblTitle)
        
        imgViewIcon.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(20)
            make.centerX.equalToSuperview()
            make.width.height.snEqualTo(75)
        }
        
        lblTitle.snp.makeConstraints { (make) in
            make.top.equalTo(imgViewIcon.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
