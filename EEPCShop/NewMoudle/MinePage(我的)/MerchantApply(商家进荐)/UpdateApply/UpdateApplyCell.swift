//
//  UpdateApplyCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Kingfisher
class UpdateApplyCell: SNBaseTableViewCell {
    
    var model :ShopMsgModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            
            license_no.textfield.text = cellModel.license_no
            address.textfield.text = cellModel.province + cellModel.city
            addressDetail.textfield.text = cellModel.address_detail
            legal_person.textfield.text = cellModel.legal_person
            legal_id.textfield.text = cellModel.legal_id
            cat.textfield.text = cellModel.cat_name
            discount.textfield.text = cellModel.discount
            
            if cellModel.main_img == "" {
                main_img.imageView.setImage(UIImage(named: "picture"), for: .normal)
                license_img.imageView.setImage(UIImage(named: "picture"), for: .normal)
            }else{
                main_img.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.main_img), for: .normal)
                license_img.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.license_img), for: .normal)
            }

        }
    }
    
    var clickBtnEvent:(()->())?
    
    var clickEvent:((_ para:Int)->())?
    
    
    let license_no = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let address = InfoPikerView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let addressDetail = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let legal_person = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let legal_id = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let cat = InfoPikerView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let discount = InfoPikerView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let location = LocationView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.isUserInteractionEnabled = true
    }
    
    let main_img = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 1
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)
        
    }
    
    let license_img = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 2
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)
    }
    
    
    let submitButton = UIButton().then{
        $0.backgroundColor = Color(0x2777ff)
        $0.layer.cornerRadius = fit(49)
        $0.setTitle("下一步", for:.normal)
        $0.setTitleColor(UIColor.white, for:.normal)
        $0.titleLabel?.font = Font(32)
    }
    @objc func click(sender:UIButton){
        guard let action = clickEvent else {
            return
        }
        action(sender.tag)
    }
    
    
    func bindEvent(){
        submitButton.addTarget(self, action: #selector(stepOne), for: .touchUpInside)
        main_img.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)
        license_img.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    @objc func stepOne(){
        guard let clickEvent = clickBtnEvent else {return}
        clickEvent()
    }
    override func setupView() {
        license_no.set(name: "营业执照号码", placeHolder: "请输入营业执照号码")
        address.set(name: "店铺地址", placeHolder: "请选择店铺地址")
        addressDetail.set(name: "店铺详细地址", placeHolder: "请输入店铺详细地址")
        legal_person.set(name: "法人姓名", placeHolder: "请输入法人姓名")
        legal_id.set(name: "法人身份证", placeHolder: "请输入法人身份证")
        cat.set(name: "商家分类", placeHolder: "请选择商家分类")
        discount.set(name: "折扣", placeHolder: "请选择折扣比例")
        location.set(name: "定位", placeHolder: "")
        main_img.imageView.setImage(UIImage(named: "picture"), for: .normal)
        main_img.nameLable.text  = "上传商家形象照片"
        license_img.imageView.setImage(UIImage(named: "picture"), for: .normal)
        license_img.nameLable.text   = "上传营业执照照片"
        
        line.isHidden = true
        
        contentView.backgroundColor = Color(0xffffff)
        
        contentView.addSubviews(views: [license_no,address,addressDetail,legal_person,legal_id,cat,discount,location,main_img,license_img,submitButton])
        
        bindEvent()

        
        license_no.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        address.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(license_no.snp.bottom)
            make.height.snEqualTo(100)
            
        }
        
        addressDetail.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(address.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        legal_person.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(addressDetail.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        legal_id.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(legal_person.snp.bottom)
            make.height.snEqualTo(100)
        }
        cat.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(legal_id.snp.bottom)
            make.height.snEqualTo(100)
        }
        discount.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(cat.snp.bottom)
            make.height.snEqualTo(100)
        }
        location.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(discount.snp.bottom)
            make.height.snEqualTo(100)
        }
        main_img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(location.snp.bottom).snOffset(20)
            make.height.snEqualTo(418)
        }
        
        license_img.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(main_img.snp.bottom).snOffset(20)
            make.height.snEqualTo(418)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(89)
            make.right.equalToSuperview().snOffset(-89)
            make.top.equalTo(license_img.snp.bottom).snOffset(75)
            make.height.snEqualTo(98)
        }
    }
}
