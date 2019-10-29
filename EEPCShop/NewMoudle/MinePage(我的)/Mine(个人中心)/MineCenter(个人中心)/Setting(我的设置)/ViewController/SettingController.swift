//
//  MinePageController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/3.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

enum MinePageType{
    case MineCellOne
    case SpaceCell
    case LoginOut
    
}
class SettingController:SNBaseViewController {
    
    var cellType :[MinePageType] = []

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(MinePageOneCell.self)
        $0.register(SpaceCell.self)
        $0.register(LoginOutCell.self)
        $0.separatorStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    
    @objc func enterMyCenter() {
        self.navigationController?.popViewController(animated: false)
    }
    
    func receiveNotify(){
        let NotifyTwo = NSNotification.Name(rawValue:"enterMyCenter")
        NotificationCenter.default.addObserver(self, selector: #selector(enterMyCenter), name: NotifyTwo, object: nil)
    }
    
    override func setupView() {
        receiveNotify()
        self.title = "我的设置"
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.cellType.append(.SpaceCell)
        self.cellType.append(.MineCellOne)
        self.cellType.append(.SpaceCell)
        self.cellType.append(.LoginOut)
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func loadData() {

    }
}

extension SettingController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .MineCellOne:
            let cell:MinePageOneCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickBtnEvent = {[unowned self] (para) in
                if para == "1"{
                    self.navigationController?.pushViewController(UpdatePayPasswordController(), animated: true)
                }else if para == "2"{
                    self.navigationController?.pushViewController(UpdatePasswordController(), animated: true)
                }else if para == "3"{
                    self.navigationController?.pushViewController(DownLoadCodeController(), animated: true)
                }
            }
            return cell
  
        case .SpaceCell:
            let cell:SpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case .LoginOut:
            let cell:LoginOutCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickBtnEvent = {[unowned self] in
                
                let NotifMycation = NSNotification.Name(rawValue:"DELETE")
                NotificationCenter.default.post(name: NotifMycation, object:XKeyChain.get(UITOKEN_PHONE))
                
                XKeyChain.set("", key: UITOKEN_UID)
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .MineCellOne:
            return fit(362 - 125)
        case .SpaceCell:
            return fit(40)
        case .LoginOut:
            return fit(200)
        }
    }
}

