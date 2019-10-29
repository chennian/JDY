//
//  CommunityWebController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/18.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import WebKit

class CommunityWebController: SNBaseViewController {
    
    var urlString:String = ""
    
    let web = WKWebView().then{
        $0.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    override func setupView() {
        self.view.addSubview(web)
        web.navigationDelegate = self

        web.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        web.load(URLRequest(url: URL(string: urlString)!))
    }
}
extension CommunityWebController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let urlString:String = (url?.absoluteString)!
    
        if urlString.contains("scheme://close"){
            self.navigationController?.popViewController(animated: false)
        }
        
        decisionHandler(.allow)
    }
    
    
    
}
