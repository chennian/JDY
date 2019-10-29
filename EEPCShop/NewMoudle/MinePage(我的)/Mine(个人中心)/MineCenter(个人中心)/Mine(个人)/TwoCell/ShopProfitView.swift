//
//  ShopProfitData.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/25.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ShopProfitView: UIView{
    
    var clickEvent:((_ para:Int)->())?
    
    
    let baseView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let baseReceiveView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let baseRectView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    let baseRmdView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    let baseBalanceView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    
    let receiveLable = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "营业额"
    }
    
    let receiveProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(32)
        $0.text = "￥1000.00"
    }
    
    
    let rectLable = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "消费分润"
    }
    
    
    let rectProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(30)
        $0.text = "￥1000.00"
    }
    
    let rmdLable = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "店铺分润"
    }
    
    let rmdProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(32)
        $0.text = "￥1000.00"
    }
    
    let balanceLabel = UILabel().then{
        $0.textColor = Color(0xa9aebe)
        $0.font = Font(26)
        $0.text = "余额"
    }
    
    let balanceProfit = UILabel().then{
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(32)
        $0.text = "￥1000.00"
    }
    
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func tapActionA(){
        guard let action = self.clickEvent else {
            return
        }
        action(1)
    }
    @objc func tapActionB(){
        guard let action = self.clickEvent else {
            return
        }
        action(2)
    }
    
    @objc func tapActionC(){
        guard let action = self.clickEvent else {
            return
        }
        action(3)
    }
    
    @objc func tapActionD(){
        guard let action = self.clickEvent else {
            return
        }
        action(4)
    }
    
    func bindEvent(){
        
        let tapA = UITapGestureRecognizer.init(target: self, action: #selector(tapActionA))
        baseReceiveView.addGestureRecognizer(tapA)
        
        let tapB = UITapGestureRecognizer.init(target: self, action: #selector(tapActionB))
        baseRectView.addGestureRecognizer(tapB)
        
        let tapC = UITapGestureRecognizer.init(target: self, action: #selector(tapActionC))
        baseRmdView.addGestureRecognizer(tapC)
        
        let tapD = UITapGestureRecognizer.init(target: self, action: #selector(tapActionD))
        baseBalanceView.addGestureRecognizer(tapD)
        
    }
    
    func setupView() {
    
        
        self.addSubviews(views: [baseView])
        baseView.addSubviews(views: [baseReceiveView,baseRectView,baseRmdView,baseBalanceView])
        
        baseReceiveView.addSubviews(views: [receiveLable,receiveProfit])
        baseRectView.addSubviews(views: [rectLable,rectProfit])
        baseRmdView.addSubviews(views: [rmdLable,rmdProfit])
        baseBalanceView.addSubviews(views: [balanceLabel,balanceProfit])
        
        bindEvent()
        
        baseView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(250)
            make.centerY.equalToSuperview()
        }
        
        baseReceiveView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(baseView.snp.top)
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(120)
        }
        
        baseRectView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(baseView.snp.top)
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(120)
        }
  
        
        baseRmdView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(baseReceiveView.snp.bottom)
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(120)
        }
        
        baseBalanceView.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalTo(baseRectView.snp.bottom)
            make.width.equalTo((ScreenW - 40)/2)
            make.height.snEqualTo(120)
        }
        
        
        receiveLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
        }
        receiveProfit.snp.makeConstraints { (make) in
            make.top.equalTo(receiveLable.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        rectLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
        }
        rectProfit.snp.makeConstraints { (make) in
            make.top.equalTo(rectLable.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
       rmdLable.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
        }
        rmdProfit.snp.makeConstraints { (make) in
            make.top.equalTo(rmdLable.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
        balanceLabel.snp.makeConstraints { (make) in
            make.top.equalToSuperview().snOffset(30)
            make.centerX.equalToSuperview()
        }
        balanceProfit.snp.makeConstraints { (make) in
            make.top.equalTo(balanceLabel.snp.bottom).snOffset(20)
            make.centerX.equalToSuperview()
        }
        
    }
    
}
