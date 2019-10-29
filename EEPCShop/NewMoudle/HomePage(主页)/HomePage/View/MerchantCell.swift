//
//  MerchantCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MerchantCell: SNBaseTableViewCell {
    
    var clickEvent:(()->())?

    
    var model:HomePageModel? {
        didSet{
            guard  let cellModel = model else {
                return
            }
            CNLog(model?.goods)
            
            name.text = cellModel.shop_name
            
            let discountF = (Float(model!.user_discount)!) * 10
            
            couponLable.text = String(format: "%.1f", discountF) + "折"

            des.text =   "满" + cellModel.base + "减" + cellModel.bouns
//            des.text =  cellModel.lable
            cat.text = cellModel.lable
            
//            self.discount.text = "满" + cellModel.base + "减" + cellModel.bouns

            address.text = cellModel.province + cellModel.city + cellModel.address_detail
            
            img.kf.setImage(with: URL(string: httpUrl + cellModel.main_img))
            
            if XKeyChain.get(latitudeKey).isEmpty {
                distance.text = "暂未定位"
            }else{
//                let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(Double(XKeyChain.get(latitudeKey))!,Double(XKeyChain.get(longiduteKey))!))
//                //            let point1 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(111.2323232,34.23121))
//                let point2 = BMKMapPointForCoordinate(CLLocationCoordinate2DMake(Double(cellModel.lat)!,Double(cellModel.lng)!))
//
//                let distanceMI = String(format: "%.2f", BMKMetersBetweenMapPoints(point1,point2)/1000)
//
//                distance.text = distanceMI + "km"
                let distanceMI = String(format: "%.2f", Float(cellModel.dis)!/1000.0)
                distance.text = "距离" +  distanceMI + "km"
                
            }
//            self.makeNewMoudel()

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
//        $0.text = ""
        $0.textColor = ColorRGB(red: 42, green: 52, blue: 87)
//        $0.layer.borderWidth = fit(1)
//        $0.layer.borderColor = Color(0xffc1c1).cgColor
//        $0.layer.cornerRadius = fit(2)
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
    
    let newView = UIView().then{
        $0.backgroundColor = .red
    }

    let specialImage = UIImageView().then{
        $0.backgroundColor = .clear
        $0.image = UIImage(named: "")
    }
    
    let specialLabel = UILabel().then{
        $0.text = "特色经营"
        $0.textColor = Color(0x2A3457)
        $0.font = BoldFont(28)
    }
    
    
    func makeNewMoudel(){
        self.contentView.addSubview(newView)
        newView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.height.snEqualTo(40)
            make.top.equalTo(img.snp.bottom).snOffset(30)
        }
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
        
        couponButton.addTarget(self, action: #selector(click), for: .touchUpInside)

        
        baseView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.snEqualTo(186)
            make.width.snEqualTo(690)
        }
        
        img.snp.makeConstraints { (make) in
            make.centerY.equalTo(baseView.snp.centerY)
            make.left.equalTo(baseView.snp.left).snOffset(20)
            make.height.width.snEqualTo(148)
        }
        
        name.snp.makeConstraints { (make) in
            make.top.equalTo(img.snp.top)
            make.left.equalTo(img.snp.right).snOffset(24)
            make.right.equalToSuperview().snOffset(-125)
            make.height.snEqualTo(32)
        }
        
        couponLable.snp.makeConstraints { (make) in
            make.top.equalTo(name.snp.bottom).snOffset(10)
            make.left.equalTo(img.snp.right).snOffset(24)
            make.width.snEqualTo(70)
            make.height.snEqualTo(30)
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

     
//
        cat.snp.makeConstraints { (make) in
            make.left.equalTo(img.snp.right).snOffset(24)
            make.top.equalTo(couponLable.snp.bottom).snOffset(14)
            make.right.equalToSuperview().snOffset(-100)
        }
//
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
    }
}
extension MerchantCell{
    func  setCoupon(_ total:String,_ num:String){
    }
}
