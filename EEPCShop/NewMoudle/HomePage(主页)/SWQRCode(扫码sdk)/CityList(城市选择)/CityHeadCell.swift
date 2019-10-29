//
//  CityHeadCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class CityHeadCell: SNBaseTableViewCell {
    
    let current  = UILabel().then{
        $0.backgroundColor = Color(0x2a3457)
        $0.font = Font(28)
        $0.text = "当前定位"
    }
    
    let currentCity = UILabel().then{
        $0.backgroundColor = Color(0x2a3457)
        $0.font = BoldFont(32)
        $0.text = "深圳"
    }

    let hot  = UILabel().then{
        $0.backgroundColor = Color(0x2a3457)
        $0.font = Font(28)
        $0.text = "热门城市"
    }
    
    
    let city1 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("东莞", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city2 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("深圳", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city3 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("广州", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city4 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("温州", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city5 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("郑州", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city6 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("金华", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city7 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("佛山", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city8 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("上海", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    let city9 = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.backgroundColor  = Color(0xf5f5f5)
        $0.setTitle("苏州", for: UIControl.State.normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    override func setupView() {
        
    }

}
