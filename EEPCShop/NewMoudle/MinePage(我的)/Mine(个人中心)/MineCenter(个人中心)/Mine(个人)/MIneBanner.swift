//
//  MIneBanner.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SDCycleScrollView

class MIneBanner: SNBaseTableViewCell {
    
    override func setupView() {
        hidLine()
        contentView.addSubview(sdScrollBanner)
        sdScrollBanner.backgroundColor = .clear
        contentView.backgroundColor = Color(0xffffff)
        self.backgroundColor = .clear
        sdScrollBanner.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
            make.height.snEqualTo(160)
        }
        sdScrollBanner.localizationImageNamesGroup = [UIImage(named: "17banner")!,UIImage(named:"17banner1")!]
  
        
    }
    
    lazy var sdScrollBanner : SDCycleScrollView = {
        let obj = SDCycleScrollView(frame: CGRect.zero, delegate: nil, placeholderImage: UIImage())
        obj?.bannerImageViewContentMode = .scaleAspectFit
        obj?.pageDotColor = UIColor(white: 1.0, alpha: 0.6)
        obj?.currentPageDotColor = .white
        return obj!
    }()
    
}
