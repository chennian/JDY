//
//  ServiceViewController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import DZNEmptyDataSet

class ServiceViewController: SNBaseViewController {
    
    
    var model :[ServiceModel] = []
    
    let bottomView = UIView().then{
        $0.backgroundColor = Color(0xf5f5f5)
    }
    
    let cutLine = UIView().then{
        $0.backgroundColor = Color(0xa9aebe)
    }
    
    
    let labelField = SLTextView().then{
        $0.font = Font(30)
        $0.textColor = Color(0x313131)
        $0.placeholder = "请说明你的问题，客服会尽快回复。"
        $0.placeholderColor = Color(0xa3a2a2)
        //        $0.backgroundColor = Color(0xf5f5f5)
        $0.layer.borderWidth = fit(1)
        $0.layer.borderColor = Color(0xd8dade).cgColor
        $0.layer.cornerRadius = fit(20)
    }
    
    let applyButton = UIButton().then{
        $0.backgroundColor = ColorRGB(red: 11.0, green: 93.0, blue: 173.0)
        $0.setTitle("提交", for: .normal)
        $0.layer.cornerRadius = fit(8)
        $0.setTitleColor(Color(0xffffff), for: .normal)
    }
    
    
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(ServiceCell.self)
        $0.separatorStyle = .none
    }
    
    @objc func applyAction(){

        if self.labelField.text! == ""{
            SZHUD("请输入你的问题", type: .info, callBack: nil)
            return
        }
        
        let url = httpUrl + "/main/applyAction"
        let para:[String:String] = ["content":self.labelField.text!]
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                SZHUD("提交成功，请耐心等待回复" , type: .success, callBack: nil)
                self.loadServiceData()
                
            }else if jsonData["code"].intValue == 1006 {
             let vc = LoginViewController()
             vc.modalPresentationStyle = .fullScreen
             self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    override func setupView() {
        
        self.title = "客服"
        
        self.view.backgroundColor = Color(0xffffff)
 
        
        self.view.addSubview(bottomView)
        bottomView.addSubview(labelField)
        bottomView.addSubview(applyButton)
        bottomView.addSubview(cutLine)
        applyButton.addTarget(self, action: #selector(applyAction), for: .touchUpInside)
        bottomView.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().snOffset(-LL_TabbarSafeBottomMargin)
            make.left.right.equalToSuperview()
            make.height.snEqualTo(300)
        }
        
        cutLine.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.snEqualTo(1)
            make.top.equalToSuperview()
        }
        
        applyButton.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-30)
            make.bottom.equalToSuperview().snOffset(-30)
            make.width.snEqualTo(100)
            make.height.snEqualTo(60)
        }
        
        labelField.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.top.equalToSuperview().snOffset(30)
            make.bottom.equalToSuperview().snOffset(-30)
            make.right.equalTo(applyButton.snp.left).snOffset(-20)
        }
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(bottomView.snp.top)
            make.right.equalToSuperview()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        loadServiceData()

    }
    
     func loadServiceData() {
        
        let url = httpUrl + "/main/getServiceList"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                let jsonObj = jsonData["data"]
                CNLog(jsonObj)
                self.model  = jsonObj.arrayValue.compactMap({ServiceModel(jsonData: $0)})
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else if jsonData["code"].intValue == 1006 {
             let vc = LoginViewController()
             vc.modalPresentationStyle = .fullScreen
             self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
}

extension ServiceViewController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ServiceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.model = self.model[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(440)
    }
}
extension ServiceViewController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty");
    }
}
