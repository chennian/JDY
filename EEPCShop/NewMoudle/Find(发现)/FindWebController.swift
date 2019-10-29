//
//  FindWebController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/12.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import WebKit

class FindWebController: UIViewController {
    
    var para:String = ""
    
    let webView = WKWebView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.webView)
        
        self.webView.load(URLRequest(url:URL(string: "http://shop.shijihema.cn/common/getFindDetail/" + self.para)!))
        
        self.webView.navigationDelegate = self
        
        
        self.webView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }

        // Do any additional setup after loading the view.
    }
    
}
extension FindWebController:WKNavigationDelegate{
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        SZHUD("加载中...", type: .loading, callBack: nil)
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        SZHUD("加载失败", type:.error, callBack: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        SZHUD("完成", type: .success, callBack: nil)
    }
    
}
