//
//  BusinessLogController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/19.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import DZNEmptyDataSet

class BusinessLogController: SNBaseViewController {
    
    var cellType :[BusinessLogType] = []
    
    var model :[BusinessLogModel] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(TitleCell.self)
        $0.register(BusinessLogCell.self)
        $0.separatorStyle = .none
    }

    override func setupView() {
        
        self.title = "营业记录"

        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    override func loadData() {
       
        let url = httpUrl + "/main/receiveLog"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                
                self.cellType.removeAll()
                
                self.cellType.append(.titleType)

                let jsonObj = jsonData["data"]
                self.model  = jsonObj.arrayValue.compactMap({BusinessLogModel(jsonData: $0)})
                
                if !self.model.isEmpty{
                    for item  in self.model{
                        self.cellType.append(.businessLogType(model: item))
                    }
                    
                }
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

extension BusinessLogController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .titleType:
            let cell:TitleCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .businessLogType(let model):
            let cell:BusinessLogCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.cellModel = model
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .titleType:
            return fit(105)
        case .businessLogType:
            return fit(97)
        }
    }
}
extension BusinessLogController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty");
    }
}
