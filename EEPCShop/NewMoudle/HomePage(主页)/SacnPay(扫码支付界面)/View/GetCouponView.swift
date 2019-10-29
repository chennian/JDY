//
//  GetCouponView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/13.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class GetCouponView: SNBaseView {
    
    
    var tapBlock:(()->())?
    var closeBlock:(()->())?

    
    let baseViewImage = UIImageView().then{
        $0.image = UIImage(named: "bgcolor")
        $0.isUserInteractionEnabled = true
    }
    
    let close = UIButton().then{
        $0.setImage(UIImage(named: "close"), for: .normal)
    }
    
    let title = UILabel().then{
        $0.text = "满100减7"
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let time = UILabel().then{
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
        $0.text = "2019-05-13 17:21:10"
    }
    
    let getCoupon = UILabel().then{
        $0.text = "领取"
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    let notice = UILabel().then{
        $0.text = ""
        $0.font = Font(32)
        $0.textColor = Color(0xffffff)
    }
    
    @objc func tapAction(){
        guard let action = tapBlock else {
            return
        }
        action()
    }
    
    
    @objc func closeAction(){
        guard let action = closeBlock else {
            return
        }
        action()
    }
    
    override func setupView() {
        
//        self.alpha = 0.5
        
        self.addSubviews(views: [baseViewImage,close,notice])
        baseViewImage.addSubviews(views: [title,time,getCoupon])
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapAction))
        baseViewImage.addGestureRecognizer(tap)
        
        close.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        
        baseViewImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.right.equalToSuperview().snOffset(-40)
            make.height.snEqualTo(144)
            make.centerY.equalToSuperview()
        }
        
        close.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(50)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.top.equalToSuperview().snOffset(25)
        }
        
        time.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(40)
            make.top.equalTo(title.snp.bottom).snOffset(25)
        }
        
        getCoupon.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.centerY.equalToSuperview()
        }
    
        notice.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(baseViewImage.snp.bottom).snOffset(30)
        }
    }
}

