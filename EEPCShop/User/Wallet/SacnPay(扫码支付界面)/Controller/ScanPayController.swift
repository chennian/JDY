//
//  ScanPayController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/18.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ScanPayController: SNBaseViewController {
    
    let passwordView = PassWordField().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    
    let mask = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.alpha = 0.3
    }
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_white"), for: .normal)
    }
    
    let notice = UILabel().then{
        $0.font = Font(36)
        $0.textColor = Color(0x2a3457)
        $0.text = "请输入支付密码"
    }
    
    
    let payLine = UIView().then{
        $0.backgroundColor = Color(0xd2d2d2)
    }
    

    
    //---------------------------------------------------------------------------//
    
    let shopImage = UIImageView().then{
        $0.image  = UIImage(named: "shop2")
        $0.layer.cornerRadius = fit(8)
    }
    
    let shopName = UILabel().then{
        $0.text = "假日酒店"
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(30)
    }

    let payLable = UILabel().then{
        $0.text = "付款金额"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    
    let moneyField = UITextField().then{
        $0.placeholder = "请输入金额"
        $0.font = Font(48)
        $0.textColor = Color(0x2a3457)
        $0.borderStyle = .none
        $0.keyboardToolbar.isHidden = true
        $0.keyboardType = .numberPad
    }


    let line = UIView().then{
        $0.backgroundColor = Color(0xe5e5e5)
    }
    
    let eepcLable = UILabel().then{
        $0.text = "EEPC:"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
    }
    
    let usdtLable = UILabel().then{
        $0.text = "USDT:"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(26)
    }
    
    let  doneButton = UIButton().then{
        $0.setTitle("确定", for: .normal)
        $0.layer.cornerRadius = fit(49)
        $0.backgroundColor = Color(0x3660fb)
        $0.titleLabel?.font = Font(30)
        $0.setTitleColor(Color(0xffffff), for: .normal)
    }
    
    override func bindEvent() {
        doneButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteBack), for: .touchUpInside)

    }
    
    @objc func doneAction() {
        setPasswordView()
//        self.navigationController?.popToRootViewController(animated: true)
    
    }
    
    func setPasswordView(){
        self.view.addSubview(mask)
        mask.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        self.view.addSubview(mainView)
        
        mainView.addSubviews(views: [deleteBtn,notice,payLine,passwordView])
        
        passwordView.delegate = self
        passwordView.textField.becomeFirstResponder()
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(343)
            make.bottom.equalToSuperview().snOffset(-432)
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(47)
            make.top.equalToSuperview().snOffset(40)
            make.width.snEqualTo(40)
            make.height.snEqualTo(40)
        }
        notice.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(deleteBtn.snp.centerY)
        }
        
        payLine.snp.makeConstraints { (make) in
            make.left.equalTo(mainView.snp.left)
            make.right.equalTo(mainView.snp.right)
            make.height.snEqualTo(1)
            make.top.equalTo(notice.snp.bottom).snOffset(40)
        }

        passwordView.snp.makeConstraints { (make) in
            make.width.snEqualTo(547)
            make.height.snEqualTo(88)
            make.top.equalTo(payLine.snp.bottom).snOffset(35)
            make.centerX.equalToSuperview()

        }
        
    }
    
    
    @objc func deleteBack(){
        passwordView.textField.resignFirstResponder()
        passwordView.textFieldText = ""
        passwordView.textField.text = ""
        passwordView.view1.isHidden = true
        passwordView.view2.isHidden = true
        passwordView.view3.isHidden = true
        passwordView.view4.isHidden = true
        passwordView.view5.isHidden = true
        passwordView.view6.isHidden = true
        mainView.removeFromSuperview()
        mask.removeFromSuperview()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    
    override func setupView() {
        self.title = "付款"
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.addSubviews(views: [shopImage,shopName,payLable,moneyField,line,eepcLable,usdtLable,doneButton])
    
    
        
        shopImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(30)
            make.width.height.snEqualTo(120)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(shopImage.snp.bottom).snOffset(25)
        }
        
        payLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(shopName.snp.bottom).snOffset(65)
        }
        
        moneyField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(payLable.snp.bottom).snOffset(47)
            make.right.equalToSuperview().snOffset(-48)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(49)
            make.right.equalToSuperview().snOffset(71)
            make.top.equalTo(moneyField.snp.bottom).snOffset(24)
            make.height.snEqualTo(1)
        }
        
        eepcLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(55)
            make.top.equalTo(line.snp.bottom).snOffset(55)
        }
        
        usdtLable.snp.makeConstraints { (make) in
            make.centerY.equalTo(eepcLable.snp.centerY)
            make.left.equalTo(eepcLable.snp.right).snOffset(257)
        }
        
        
        doneButton.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(90)
            make.right.equalToSuperview().snOffset(-90)
            make.top.equalTo(eepcLable.snp.bottom).snOffset(110)
            make.height.snEqualTo(98)
        }
        
    }

  
}
extension ScanPayController:PassWordFieldDelegate{
    func inputTradePasswordFinish(tradePasswordView: PassWordField, password: String) {
        
        CNLog(password)
    }
    
}
