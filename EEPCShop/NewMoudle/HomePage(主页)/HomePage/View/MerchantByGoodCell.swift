//
//  MerchantByGoodCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MerchantByGoodCell: SNBaseTableViewCell {
    
    var clickEvent:(()->())?
    
    var model:HomePageModel? {
        didSet{
            guard  let cellModel = model else {
                return
            }
            name.text = cellModel.shop_name
            
            let discountF = (Float(model!.user_discount)!) * 10
             
            couponLable.text =  String(format: "%.1f", discountF) + "折"
            
            des.text =  "满" + cellModel.base + "减" + cellModel.bouns
            cat.text = cellModel.lable
            
//            self.discount.text = "满" + cellModel.base + "减" + cellModel.bouns
            
            address.text = cellModel.province + cellModel.city + cellModel.address_detail
            
            img.kf.setImage(with: URL(string: httpUrl + cellModel.main_img))
            
            if cellModel.goods.count == 1 {
                img1.kf.setImage(with: URL(string: httpUrl + cellModel.goods[0].good_main_pic))
            }else if cellModel.goods.count == 2{
                img1.kf.setImage(with: URL(string: httpUrl + cellModel.goods[0].good_main_pic))
                img2.kf.setImage(with: URL(string: httpUrl + cellModel.goods[1].good_main_pic))
            }else if cellModel.goods.count == 3{
                img1.kf.setImage(with: URL(string: httpUrl + cellModel.goods[0].good_main_pic))
                img2.kf.setImage(with: URL(string: httpUrl + cellModel.goods[1].good_main_pic))
                img3.kf.setImage(with: URL(string: httpUrl + cellModel.goods[2].good_main_pic))
            }
            
            if XKeyChain.get(latitudeKey).isEmpty {
                distance.text = "暂未定位"
            }else{
          
                let distanceMI = String(format: "%.2f", Float(cellModel.dis)!/1000.0)
                distance.text =  "距离" + distanceMI + "km"
                
            }
        }
    }
    
    let baseView = UIView().then{
        $0.backgroundColor = ColorRGB(red: 254, green: 253, blue: 253)
        $0.layer.cornerRadius = fit(16)
    }
    
    let img = UIImageView().then{
        $0.contentMode = .scaleToFill
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = fit(8)
        $0.layer.masksToBounds = true
    }
    
    let name = UILabel().then{
        $0.font = BoldFont(30)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.text = "店家名称"
    }
    
    let couponDes = UILabel().then{
        $0.backgroundColor = .red
        $0.layer.cornerRadius = fit(8)
        $0.layer.masksToBounds = true
    }
    
    let des = UILabel().then{
        $0.font = Font(24)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.textAlignment = .center
        
    }
    
    //    let couponImage = UIImageView().then{
    //        $0.image = UIImage(named: "conpon1")
    //        $0.layer.cornerRadius = fit(2)
    //    }
    
    //    let discount = UILabel().then{
    //        $0.font = Font(24)
    //        $0.text = ""
    //        $0.textColor = Color(0xff4242)
    //        $0.textAlignment = .center
    //    }
    
    let couponLable = UILabel().then{
        $0.font = Font(24)
        $0.text = "优惠"
        $0.textAlignment = .center
        $0.backgroundColor = .red
        $0.textColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(5)
        $0.layer.masksToBounds = true
    }
    //
    let cat = UILabel().then{
        $0.font = Font(24)
        $0.textColor = Color(0xff7e00)
    }
    
    let address = UILabel().then{
        $0.font = Font(20)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.text = "深圳市龙华区民治街道嘉熙业广场"
    }
    
    let distance = UILabel().then{
        $0.font = Font(16)
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
        $0.text = ""
    }
    
    
    let couponButton = UIButton().then{
        //        $0.setTitle("领劵", for: .normal)
        //        $0.layer.cornerRadius = fit(5)
        //        $0.backgroundColor = Color(0xff4242)
        //        $0.setTitleColor(Color(0xffffff), for: .normal)
        //        $0.titleLabel?.font = Font(32)
        $0.setImage(UIImage(named: "click"), for: .normal)
    }
    
    //新加模块
    
    let specialImage = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "home_shop_characteristic")
    }
    
    let specialLabel = UILabel().then{
        $0.text = "特色经营"
        $0.textColor = Color(0x2A3457)
        $0.font = BoldFont(28)
    }
    
    let img1 = UIImageView().then{
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = fit(10)
        $0.layer.masksToBounds = true
    }
    
    let img2 = UIImageView().then{
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = fit(10)
        $0.layer.masksToBounds = true
    }
    
    let img3 =  UIImageView().then{
        $0.backgroundColor = .clear
        $0.layer.cornerRadius = fit(10)
        $0.layer.masksToBounds = true
    }
    
    
    @objc func click(){
        guard let action = clickEvent else {
            return
        }
        action()
    }
    
    override func setupView() {
        hidLine()
        
        self.contentView.backgroundColor = Color(0xf5f5f5)
        self.contentView.addSubview(baseView)
        baseView.addSubview(img)
        baseView.addSubview(name)
        
//        baseView.addSubview(couponImage)
        
//        baseView.addSubview(discount)
        baseView.addSubview(des)
        baseView.addSubview(cat)
        baseView.addSubview(couponLable)
        baseView.addSubview(address)
        baseView.addSubview(couponButton)
        baseView.addSubview(distance)
        
        baseView.addSubview(specialImage)
        baseView.addSubview(specialLabel)
        baseView.addSubview(img1)
        baseView.addSubview(img2)
        baseView.addSubview(img3)

        
        couponButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        
        baseView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.snEqualTo(186 + 245)
            make.width.snEqualTo(690)
        }
        
        img.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(20)
            make.left.equalTo(baseView.snp.left).snOffset(20)
            make.height.width.snEqualTo(148)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.top)
            make.left.equalTo(img.snp.right).snOffset(24)
            make.right.equalToSuperview().snOffset(-125)
            make.height.snEqualTo(32)
        }
        
        des.snp.makeConstraints { (make) in
            //            make.top.equalTo(name.snp.bottom).snOffset(10)
            make.left.equalTo(couponLable.snp.right).snOffset(10)
            make.centerY.equalTo(couponLable.snp.centerY)
            //            make.height.snEqualTo(40)
            //            make.width.snEqualTo(80)
        }
        
        
//        couponImage.snp.makeConstraints { (make) in
//            make.left.equalTo(des.snp.right).snOffset(10)
//            make.centerY.equalTo(des.snp.centerY)
//            make.width.snEqualTo(210)
//            make.height.snEqualTo(40)
//        }
        
//        discount.snp.makeConstraints { (make) in
//            make.left.equalTo(couponImage.snp.left).snOffset(10)
//            make.centerY.equalTo(couponImage.snp.centerY)
//        }
        
        couponLable.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).snOffset(10)
            make.left.equalTo(img.snp.right).snOffset(24)
            make.width.snEqualTo(70)
            make.height.snEqualTo(30)
        }
        
        cat.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(24)
            make.top.equalTo(couponLable.snp.bottom).snOffset(14)
            make.right.equalToSuperview().snOffset(-100)
        }
        
        
        couponButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-5)
            make.centerY.equalTo(des.snp.centerY)
            make.width.snEqualTo(120)
            make.height.snEqualTo(50)
        }
        
        distance.snp.makeConstraints { (make) in
            make.left.equalTo(name.snp.right)
            make.right.equalToSuperview()
            make.centerY.equalTo(name.snp.centerY)
        }
        
        address.snp.makeConstraints { (make) in
            make.bottom.equalTo(img.snp.bottom)
            make.left.equalTo(img.snp.right).snOffset(24)
            make.right.equalToSuperview().snOffset(-20)
        }
        
        
        specialImage.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalTo(img.snp.bottom).snOffset(30)
            make.width.height.snEqualTo(28)
        }
        
        specialLabel.snp.makeConstraints { (make) in
            make.left.equalTo(specialImage.snp.right).snOffset(10)
            make.centerY.equalTo(specialImage.snp.centerY)
        }
        
        img1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.top.equalTo(specialImage.snp.bottom).snOffset(20)
            make.width.snEqualTo(208)
            make.height.snEqualTo(177)
        }
        
        img2.snp.makeConstraints { (make) in
            make.left.equalTo(img1.snp.right).snOffset(18)
            make.top.equalTo(specialImage.snp.bottom).snOffset(20)
            make.width.snEqualTo(208)
            make.height.snEqualTo(177)
        }
        
        img3.snp.makeConstraints { (make) in
            make.left.equalTo(img2.snp.right).snOffset(18)
            make.top.equalTo(specialImage.snp.bottom).snOffset(20)
            make.width.snEqualTo(208)
            make.height.snEqualTo(177)
        }
    }
}
extension MerchantByGoodCell{
    func  setCoupon(_ total:String,_ num:String){
    }
}
