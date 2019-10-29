//
//  ADModuleCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/9.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ADModuleCell: SNBaseTableViewCell {
    
    var clickEventOne:(()->())?
    var clickEventTwo:(()->())?
    var clickEventThree:(()->())?
    var clickEventFour:(()->())?

    
    var models : [BannerModel] = []{
        didSet{
            one.kf.setImage(with: URL(string: "http://app.ui-token.com/NewPublic/" + models[0].img + "@2x.png"))
            two.kf.setImage(with: URL(string: "http://app.ui-token.com/NewPublic/" + models[1].img + "@2x.png"))
            three.kf.setImage(with: URL(string: "http://app.ui-token.com/NewPublic/" + models[2].img + "@2x.png"))
            four.kf.setImage(with: URL(string: "http://app.ui-token.com/NewPublic/" + models[3].img + "@2x.png"))
        }
    }
    
    let one = UIImageView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = fit(8)
//        $0.image = UIImage(named: "HongKong")
    }
    let two = UIImageView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = fit(8)
//        $0.image = UIImage(named: "food")
    }
    let three = UIImageView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = fit(8)
//        $0.image = UIImage(named: "Hotel")
    }
    
    let four = UIImageView().then{
        $0.backgroundColor = .clear
        $0.isUserInteractionEnabled = true
        $0.layer.cornerRadius = fit(8)
//        $0.image = UIImage(named: "HongKong")
    }
    
     @objc  func oneAction(){
        guard let action = clickEventOne else {
            return
        }
        action()
    }
    @objc  func twoAction(){
        guard let action = clickEventTwo else {
            return
        }
        action()
    }
    @objc  func threeAction(){
        guard let action = clickEventThree else {
            return
        }
        action()
    }
    @objc  func fourAction(){
        guard let action = clickEventFour else {
            return
        }
        action()
    }

    func  bindEvent(){
        let tapOne = UITapGestureRecognizer.init(target: self, action: #selector(oneAction))
        let tapTwo = UITapGestureRecognizer.init(target: self, action: #selector(twoAction))
        let tapThree = UITapGestureRecognizer.init(target: self, action: #selector(threeAction))
        let tapFour = UITapGestureRecognizer.init(target: self, action: #selector(fourAction))

        one.addGestureRecognizer(tapOne)
        two.addGestureRecognizer(tapTwo)
        three.addGestureRecognizer(tapThree)
        four.addGestureRecognizer(tapFour)

    }
    
    
    override func setupView() {
        self.contentView.backgroundColor = Color(0xffffff)
        
        self.contentView.addSubviews(views: [one,two,three,four])
        hidLine()
        
        bindEvent()
        
        four.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(25)
            make.right.equalToSuperview().snOffset(-25)
            make.top.equalToSuperview()
            make.height.snEqualTo(124)
        }
        
        one.snp.makeConstraints { (make) in
            make.top.equalTo(four.snp.bottom).snOffset(28)
            make.left.equalToSuperview().snOffset(25)
            make.width.snEqualTo(366)
            make.height.snEqualTo(324)
        }
        
        two.snp.makeConstraints { (make) in
            make.top.equalTo(one.snp.top)
            make.right.equalToSuperview().snOffset(-25)
            make.left.equalTo(one.snp.right).snOffset(16)
            make.height.equalTo(fit(154))
        }
        
        three.snp.makeConstraints { (make) in
            make.left.equalTo(one.snp.right).snOffset(16)
            make.top.equalTo(two.snp.bottom).snOffset(16)
            make.right.equalToSuperview().snOffset(-25)
            make.bottom.equalTo(one.snp.bottom)
        }
    }
}
