//
//  MyInfoStepTwoCell.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit

class MyInfoStepTwoCell: SNBaseTableViewCell {
    
    var model :ShopMsgModel?{
        didSet{
            guard let cellModel = model else {
                return
            }
            
            bank_no.textfield.text = cellModel.bank_no
            bank_name.textfield.text = cellModel.bank_name
            bank_type.textfield.text = cellModel.bank_type
            bank_branch.textfield.text = cellModel.bank_branch
            bank_address.textfield.text = cellModel.bank_province + cellModel.bank_city
            open_bank_no.textfield.text = cellModel.open_bank_no
            open_bank_name.textfield.text = cellModel.open_bank_name
            
            open_bank_type.textfield.text = cellModel.open_bank_type
            open_bank_branch.textfield.text = cellModel.open_bank_branch

            
            if cellModel.apliy_receiev_code == "" || cellModel.apliy_receiev_code.isEmpty {
                apliy_receiev_code.imageView.setImage(UIImage(named: "picture"), for: .normal)
            }else{
                apliy_receiev_code.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.apliy_receiev_code), for: .normal)
            }
            
            if  cellModel.wexin_receive_code == "" || cellModel.wexin_receive_code.isEmpty{
                wexin_receive_code.imageView.setImage(UIImage(named: "picture"), for: .normal)
            }else{
                wexin_receive_code.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.wexin_receive_code), for: .normal)

            }
            
            
            if  cellModel.legal_id_front == "" || cellModel.legal_id_front.isEmpty{
                ID_front.imageView.setImage(UIImage(named: "picture"), for: .normal)
            }else{
                ID_front.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.legal_id_front), for: .normal)
                
            }
            
            if  cellModel.legal_id_back == "" || cellModel.legal_id_back.isEmpty{
                ID_back.imageView.setImage(UIImage(named: "picture"), for: .normal)
            }else{
                ID_back.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.legal_id_back), for: .normal)
                
            }
        }
    }
    
    
    var clickBtnEvent:((_ para:Int)->())?
    
    let bank_no = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let bank_name = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let bank_type = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let bank_branch = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let bank_address = InfoPikerView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    
    let open_bank_no = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
        
    }
    
    let open_bank_name = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let open_bank_type = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let open_bank_branch = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    
    
    let apliy_receiev_code = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 10
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)

    }
    
    let wexin_receive_code = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 20
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)

    }
    
    let ID_front = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 30
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)
    }
    
    let ID_back = UploadView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.imageView.tag = 40
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = fit(20)
    }
    
    let pay_pwd = InfoView().then{
        $0.backgroundColor = Color(0xffffff)
    }

    
    let submitButton = UIButton().then{
        $0.backgroundColor = Color(0x2777ff)
        $0.layer.cornerRadius = fit(49)
        $0.setTitle("提交", for:.normal)
        $0.setTitleColor(UIColor.white, for:.normal)
        $0.titleLabel?.font = Font(32)
        $0.tag = 50
    }
    
    func bindEvent(){
        submitButton.addTarget(self, action: #selector(click), for: .touchUpInside)
        apliy_receiev_code.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)
        wexin_receive_code.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)
        ID_front.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)
        ID_back.imageView.addTarget(self, action: #selector(click), for: .touchUpInside)

    }
    
    @objc func click(sender:UIButton){
        guard let action = clickBtnEvent else {
            return
        }
        action(sender.tag)
    }
    
    override func setupView() {
        
        bank_no.set(name: "银行卡号", placeHolder: "请输出银行卡号(选填)")
        bank_name.set(name: "姓名", placeHolder: "请输入银行卡所属人(选填)")
        bank_type.set(name: "开户行", placeHolder: "请输入开户行(选填)")
        bank_branch.set(name: "开户支行", placeHolder: "请输入开户支行(选填)")
        bank_address.set(name: "所在地", placeHolder: "请选择所在地(选填)")
        
        open_bank_no.set(name: "公户银行卡号", placeHolder: "请输出公户银行卡号(选填)")
        open_bank_name.set(name: "公户开户名称", placeHolder: "请输入公户开户名称(选填)")
        open_bank_type.set(name: "公户开户行", placeHolder: "请输入公户开户行(选填)")
        open_bank_branch.set(name: "公户开户支行", placeHolder: "请输入公户开户支行(选填)")
 
        apliy_receiev_code.imageView.setImage(UIImage(named: "picture"), for: .normal)
        apliy_receiev_code.nameLable.text  = "支付宝收款码"
        wexin_receive_code.imageView.setImage(UIImage(named: "picture"), for: .normal)
        wexin_receive_code.nameLable.text   = "微信收款码"
        
        ID_front.imageView.setImage(UIImage(named: "idcard1"), for: .normal)
        ID_front.nameLable.text   = "上传身份证正面照"
        ID_back.imageView.setImage(UIImage(named: "idcard2"), for: .normal)
        ID_back.nameLable.text   = "上传身份证反面照"
        
        pay_pwd.set(name: "支付密码", placeHolder: "请输入支付密码")
        pay_pwd.textfield.isSecureTextEntry = true
        pay_pwd.textfield.keyboardType = .numberPad

        line.isHidden = true
        contentView.backgroundColor = Color(0xffffff)

        contentView.addSubviews(views: [bank_no,bank_name,bank_type,bank_branch,open_bank_no,open_bank_name,open_bank_type,open_bank_branch,bank_address,apliy_receiev_code,wexin_receive_code,ID_front,ID_back,pay_pwd,submitButton])
        
        bindEvent()
 
        bank_no.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        bank_name.snp.makeConstraints { (make) in
            make.top.equalTo(bank_no.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        bank_type.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(bank_name.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        bank_branch.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(bank_type.snp.bottom)
            make.height.snEqualTo(100)
            
        }
        
        bank_address.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(bank_branch.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        open_bank_no.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(bank_address.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        open_bank_name.snp.makeConstraints { (make) in
            make.top.equalTo(open_bank_no.snp.bottom)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(100)
        }
        
        open_bank_type.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(open_bank_name.snp.bottom)
            make.height.snEqualTo(100)
        }
        
        open_bank_branch.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(open_bank_type.snp.bottom)
            make.height.snEqualTo(100)
            
        }
        
        apliy_receiev_code.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(open_bank_branch.snp.bottom).snOffset(30)
            make.height.snEqualTo(418)
        }
        
        wexin_receive_code.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(apliy_receiev_code.snp.bottom).snOffset(30)
            make.height.snEqualTo(418)
        }
        
        ID_front.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(wexin_receive_code.snp.bottom).snOffset(30)
            make.height.snEqualTo(418)
        }
        
        ID_back.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.top.equalTo(ID_front.snp.bottom).snOffset(30)
            make.height.snEqualTo(418)
        }
        
        
        pay_pwd.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.top.equalTo(ID_back.snp.bottom).snOffset(30)
            make.height.snEqualTo(100)
        }
        
        submitButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(63)
            make.right.equalToSuperview().snOffset(-63)
            make.top.equalTo(pay_pwd.snp.bottom).snOffset(40)
            make.height.snEqualTo(98)
        }
    }
}
