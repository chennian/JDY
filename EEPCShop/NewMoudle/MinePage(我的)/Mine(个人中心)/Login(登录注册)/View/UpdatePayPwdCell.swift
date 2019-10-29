//
//  UpdatePayPwdCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/23.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class UpdatePayPwdCell: SNBaseTableViewCell {
    
    var clickEvent:(()->())?
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(20)
    }
    
    let phone = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let pwd = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let confirmPwd = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let code = CodeView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let submitButton = UIButton().then{
        $0.backgroundColor = Color(0x2777ff)
        $0.layer.cornerRadius = fit(49)
        $0.setTitle("保存", for:.normal)
        $0.setTitleColor(UIColor.white, for:.normal)
        $0.titleLabel?.font = Font(32)
    }
    @objc func click(){
        guard let action = clickEvent else {
            return
        }
        action()
    }
    
    func bindEvent(){
        submitButton.addTarget(self, action: #selector(click), for: .touchUpInside)
    }
    
    override func setupView() {
        contentView.backgroundColor = Color(0xf2f5f7)
        
        contentView.addSubview(baseView)
        
        baseView.addSubviews(views: [phone,pwd,confirmPwd,code,submitButton]);
        phone.set(name: "手机号", placeHolder: "请输入手机号码")
        phone.textfield.text = XKeyChain.get(UITOKEN_PHONE)
        phone.textfield.isEnabled = false
        pwd.set(name: "新密码", placeHolder: "请输入新密码")
        confirmPwd.set(name: "确认密码", placeHolder: "请输入确认密码")
        
        pwd.textfield.isSecureTextEntry = true
        confirmPwd.textfield.isSecureTextEntry = true
        
        bindEvent()
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalToSuperview().snOffset(20)
            make.height.snEqualTo(730)
        }
        
        phone.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(20)
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(110)
        }

        pwd.snp.makeConstraints { (make) in
            make.top.equalTo(phone.snp.bottom)
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(110)
        }
        
        confirmPwd.snp.makeConstraints { (make) in
            make.top.equalTo(pwd.snp.bottom)
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(110)
        }
        
        code.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPwd.snp.bottom)
            make.left.equalToSuperview().snOffset(35)
            make.right.equalToSuperview().snOffset(-35)
            make.height.snEqualTo(110)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(93)
            make.right.equalToSuperview().snOffset(-63)
            make.top.equalTo(code.snp.bottom).snOffset(126)
            make.height.snEqualTo(98)
        }
        
        
    }
    
}
