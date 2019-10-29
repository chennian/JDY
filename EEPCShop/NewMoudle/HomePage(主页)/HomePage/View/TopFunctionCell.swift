//
//  TopFunctionCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class TopFunctionCell: SNBaseTableViewCell {
    
    var clickEvent:((_ para:Int)->())?
    
    let baseImageView = UIImageView().then{
        $0.image = UIImage(named: "home_bgtop1")
        $0.isUserInteractionEnabled = true
    }
    
    let scan = topFunctionView().then{
        $0.image.image = UIImage(named: "66a")
        $0.label.text = "扫一扫"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let receive = topFunctionView().then{
        $0.image.image = UIImage(named: "66b")
        $0.label.text = "收款码"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let coupon = topFunctionView().then{
        $0.image.image = UIImage(named: "66c")
        $0.label.text = "卡卷"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    let map = topFunctionView().then{
        $0.image.image = UIImage(named: "66d")
        $0.label.text = "地 图"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }
    
    
    let service = topFunctionView().then{
        $0.image.image = UIImage(named: "66e")
        $0.label.text = "火车票"
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
    }

    @objc func tapAction1(){
        guard let action = clickEvent else {
            return
        }
        action(1)
    }
    @objc func tapAction2(){
        guard let action = clickEvent else {
            return
        }
        action(2)
    }
    @objc func tapAction3(){
        guard let action = clickEvent else {
            return
        }
        action(3)
    }
    
    @objc func tapAction4(){
        guard let action = clickEvent else {
            return
        }
        action(4)
    }
    
    @objc func tapAction5(){
        guard let action = clickEvent else {
            return
        }
        action(5)
    }
    
    func bindEvent(){
        
        let tap1 = UITapGestureRecognizer.init(target: self, action: #selector(tapAction1))
        let tap2 = UITapGestureRecognizer.init(target: self, action: #selector(tapAction2))
        let tap3 = UITapGestureRecognizer.init(target: self, action: #selector(tapAction3))
        let tap4 = UITapGestureRecognizer.init(target: self, action: #selector(tapAction4))
        let tap5 = UITapGestureRecognizer.init(target: self, action: #selector(tapAction5))

        
        scan.addGestureRecognizer(tap1)
        receive.addGestureRecognizer(tap2)
        coupon.addGestureRecognizer(tap3)
        map.addGestureRecognizer(tap4)
        service.addGestureRecognizer(tap5)


    }
    
    override func setupView() {
        
        self.contentView.addSubview(baseImageView)
        
        baseImageView.addSubview(scan)
        baseImageView.addSubview(receive)
        baseImageView.addSubview(coupon)

        baseImageView.addSubview(map)
        baseImageView.addSubview(service)
        
        self.line.isHidden = true
        
        bindEvent()
        
        baseImageView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
        
        scan.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
            make.width.equalTo(ScreenW/5)
            make.height.snEqualTo(110)
        }
        
        receive.snp.makeConstraints { (make) in
            make.left.equalTo(scan.snp.right)
            make.top.equalToSuperview().snOffset(20)
            make.width.equalTo(ScreenW/5)
            make.height.snEqualTo(110)
        }
        
        coupon.snp.makeConstraints { (make) in
            make.left.equalTo(receive.snp.right)
            make.top.equalToSuperview().snOffset(20)
            make.width.equalTo(ScreenW/5)
            make.height.snEqualTo(110)
        }
        
        map.snp.makeConstraints { (make) in
            make.left.equalTo(coupon.snp.right)
            make.top.equalToSuperview().snOffset(20)
            make.width.equalTo(ScreenW/5)
            make.height.snEqualTo(110)
        }
        
        service.snp.makeConstraints { (make) in
            make.left.equalTo(map.snp.right)
            make.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(20)
            make.height.snEqualTo(110)
        }

    }

}
