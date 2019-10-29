//
//  CommunityController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/10.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//
import UIKit
import WebKit

class CommunityController: SNBaseViewController {
    
    let web = WKWebView().then{
        $0.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        navigationController?.navigationBar.isHidden = false
//    }
    
    override func setupView() {
        self.view.addSubview(web)
        web.navigationDelegate = self
        
        web.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-LL_TabbarSafeBottomMargin)
        }
    
        web.load(URLRequest(url: URL(string: "http://shop.shijihema.cn/community/communityIndex/" + XKeyChain.get(TOKEN) + "/"  + XKeyChain.get(latitudeKey)  + "/" +  XKeyChain.get(longiduteKey) + "/1")!))
    }
}

extension CommunityController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let urlString:String = (url?.absoluteString)!
        CNLog(urlString)
        if urlString.contains("common"){
            let vc = CommunityWebController()
            vc.urlString  = urlString
            self.navigationController?.pushViewController(vc, animated: true)
        
            decisionHandler(.cancel)
            return
        }
        
        if urlString.contains("scheme://close"){
            self.navigationController?.popViewController(animated: false)
        }
        
        decisionHandler(.allow)
    }
    
    
    
}
