//
//  GoodManagerController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/18.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//


import UIKit
import WebKit

class WebController: SNBaseViewController {
    
    var urlString:String = ""
    
    let web = WKWebView().then{
        $0.backgroundColor = .clear
    }
    
    
    override func setupView() {
        
        
        self.view.addSubview(web)
        
        web.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        web.load(URLRequest(url: URL(string: urlString)!))
    }
}
