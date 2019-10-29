//
//  QRCodeView.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/21.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class QRCodeView: SNBaseView {
    var icon :UIImage?
    func creatErcode(_ url:String){
        let img = QRCodeTool.creatQRCodeImage(text: url, size: fit(480), icon: nil)
        ercodeBtn.setImage(img, for: UIControl.State.normal)
    }
    
    
    func creatReceiveErcode(_ shopId:String ,_ icon:UIImage){
        let url = "UITOKEN://" + shopId
        let img = QRCodeTool.creatQRCodeImage(text: url, size: fit(488), icon: icon)
        ercodeBtn.setImage(img, for: .normal)
    }
    
    let ercodeBtn = UIButton()
    
    override func setupView() {
        
        addSubview(ercodeBtn)
        
        ercodeBtn.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalToSuperview()
        }
    }
    
}
