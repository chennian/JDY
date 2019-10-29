//
//  BindingTypeController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/21.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class BindingTypeController: SNBaseViewController {
    
    var cellType :[BindType] = []
    
    var model:BindingModel?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(BankTypeCell.self)
        $0.register(AlipayTypeCell.self)
        $0.register(WexinTypeCell.self)
        $0.register(OpenBankCell.self)
        $0.separatorStyle = .none
    }
 
    override func loadData() {
        
    
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            
            if  jsonData["code"].intValue == 1000{
                self.cellType.removeAll()
                //登录成功数据解析
                self.model =  BindingModel.init(jsonData:jsonData["data"])
                self.cellType.append(.bankType(self.model!))
                self.cellType.append(.alipayType(self.model!))
                self.cellType.append(.wexinType(self.model!))
                
                if self.model?.open_bank_no != "" &&  self.model?.open_bank_name != "" && self.model?.open_bank_type != "" &&  self.model?.open_bank_branch != ""{
                    self.cellType.append(.openBankType(self.model!))

                }
                
                
                self.tableView.reloadData()

            
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
        
        self.title = "绑定方式"
        navigationController?.navigationBar.isHidden = false

        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
}

extension BindingTypeController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .bankType(let model):
            let cell:BankTypeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellModel = model
            return cell
        case  .alipayType(let model):
            let cell:AlipayTypeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellModel = model
            return cell
        case  .wexinType(let model):
            let cell:WexinTypeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellModel = model
            return cell
        case .openBankType(let model):
            let cell:OpenBankCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellModel = model
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .bankType:
            return fit(515)
        case .alipayType:
            return fit(515)
        case .wexinType:
            return fit(515)
        case .openBankType:
            return fit(515)
        }
    }
}
