//
//  CallUIViewController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class CallUIViewController: SNBaseViewController {
    
    var phoneNum:String?
    
    
    let backImage = UIImageView().then{
        $0.image = UIImage(named: "call_bgimg")
        $0.isUserInteractionEnabled = true
    }
    

    let phone = UILabel().then{
        $0.textColor = Color(0xffffff)
        $0.font = Font(40)
    }
    
    let msg = UILabel().then{
        $0.text = "呼叫成功，请接听..."
        $0.textColor = Color(0xffffff)
        $0.font = Font(30)
    }
    let callback  = UIButton().then{
        $0.setTitle("返回", for: .normal)
        $0.backgroundColor = .red
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    override func setupView() {
        
        self.view.addSubview(backImage)
        backImage.addSubview(msg)
        backImage.addSubview(phone)
        backImage.addSubview(callback)
        
        phone.text = phoneNum
        
        CNLog(phoneNum)
        
        callback.addTarget(self, action: #selector(back), for: .touchUpInside)
        
        backImage.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    
        
        phone.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(100)
        }
        
        msg.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(phone.snp.bottom).snOffset(30)
        }
        
        callback.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.right.equalToSuperview().snOffset(-30)
            make.bottom.equalToSuperview().snOffset(-80)
            make.height.snEqualTo(100)
        }
        
    }

}
