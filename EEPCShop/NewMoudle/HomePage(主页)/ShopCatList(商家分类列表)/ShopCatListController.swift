//
//  ShopCatListController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/25.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import DZNEmptyDataSet

class ShopCatListController:SNBaseViewController {
    var city:String?
    var cat:String?
    var selfTitle:String?
    
    var total :String = ""
    var num :String = ""
    
    var cellType :[searchPageType] = []
    var model :[HomePageModel] = []

    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(MerchantCell.self)
        $0.register(MerchantByGoodCell.self)
        $0.separatorStyle = .none
    }
    
    override func loadData() {
        
        let url = httpUrl + "/common/shopListByCat"
        let para:[String:String] = ["cat":cat!,"city":city!]
        SZHUD("加载中", type: .loading, callBack: nil)
        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                let jsonObj = jsonData["data"]
                self.model = jsonObj.arrayValue.compactMap { HomePageModel(jsonData: $0) }
                if self.model.count > 0{
                    
                    for item in self.model{
                        item.bouns = self.num
                        item.base =  self.total
                        
                        if item.goods.isEmpty {
                            self.cellType.append(.merchantType(item))
                        }else{
                            self.cellType.append(.merchantByGoodType(item))
                        }
                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }else{
                    SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                }
                
               SZHUDDismiss()
                
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }

    @objc func getCoupon() {
        SZHUD("请求中...", type: .loading, callBack: nil)
        
        let url = httpUrl + "/main/getDSCoupon"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                XKeyChain.set("1", key: UITOKEN_COUPOM)
                
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                
            }else if jsonData["code"].intValue == 1006 {
                SZHUDDismiss()
              let vc = LoginViewController()
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    override func setupView() {
        setupUI()
    }
    fileprivate func setupUI() {
        
        if XKeyChain.get(latitudeKey).isEmpty {
            XKeyChain.set("0", key: latitudeKey)
        }
        
        if XKeyChain.get(longiduteKey).isEmpty {
            XKeyChain.set("0", key: longiduteKey)
        }
        
        self.title = selfTitle!
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        tableView.isEditing = false
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: false)
    }
}
extension ShopCatListController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch self.cellType[indexPath.row] {
        case .merchantByGoodType(let model):
            let cell:MerchantByGoodCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent  = { [unowned self] in
                self.getCoupon()
            }
            cell.model = model
            return cell
        case .merchantType(let model):
            let cell:MerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent  = { [unowned self] in
                self.getCoupon()
            }
            cell.model = model
            return cell
        }
      
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .merchantType:
            return fit(220)
        case .merchantByGoodType:
            return fit(465)
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.cellType[indexPath.row] {
        case .merchantType(let model):
            
            if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
               let vc = LoginViewController()
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)
                return
            }
            
            let vc = ShopDetailWebController()
            vc.urlString = "http://shop.shijihema.cn/common/shoperShopDetail/" + XKeyChain.get(TOKEN) + "/" + XKeyChain.get(latitudeKey) +     "/" + XKeyChain.get(longiduteKey) + "/" + model.shop_id
            self.navigationController?.pushViewController(vc, animated: true)
            vc.addressDetail = model.address_detail
        case .merchantByGoodType(let model):
            
            if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                     let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            return
            }
            
            let vc = ShopDetailWebController()
            vc.urlString = "http://shop.shijihema.cn/common/shoperShopDetail/" + XKeyChain.get(TOKEN) + "/" + XKeyChain.get(latitudeKey) +     "/" + XKeyChain.get(longiduteKey) + "/" + model.shop_id
            vc.addressDetail = model.address_detail
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension ShopCatListController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty");
    }
}
