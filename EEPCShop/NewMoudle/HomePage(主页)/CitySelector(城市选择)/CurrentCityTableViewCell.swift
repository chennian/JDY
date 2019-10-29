//
//  CurrentCityTableViewCell.swift
//  SoolyWeather
//
//  Created by SoolyChristina on 2017/3/10.
//  Copyright © 2017年 SoolyChristina. All rights reserved.
//

import UIKit

class CurrentCityTableViewCell: SNBaseTableViewCell {
    
    var tapEvent:((_ cityName:String)->())?
    
    override func setupView() {
        self.backgroundColor = cellColor
        let btn = UIButton(frame: CGRect(x: btnMargin, y:15 , width: btnWidth, height: btnHeight))
        
        if XKeyChain.get(CITY).isEmpty {
            btn.setTitle("未定位", for: .normal)
        }else{
            btn.setTitle(XKeyChain.get(CITY), for: .normal)
        }
        
        btn.setTitleColor(mainColor, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        btn.backgroundColor = UIColor.white
        btn.layer.cornerRadius = 1
        btn .addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        self.addSubview(btn)
        
    }
    
    
    @objc  func btnClick(btn: UIButton) {
        
        guard let action = tapEvent else {
            return
        }
        action((btn.titleLabel?.text!)!)
        
    }

}
