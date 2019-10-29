//
//  WalletInfoController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/2.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class WalletInfoController: SNBaseViewController {
    
    var cellType :[WalletInfoType] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(WalletInfoCell.self)
        $0.register(WalletHeadInfoCell.self)
        $0.register(SpaceCell.self)
        $0.separatorStyle = .none
    }
    override func loadData() {
        self.cellType.append(.walletHeadType)
        self.cellType.append(.walletInfoType(img:UIImage(named: "usdt")!, name: "USDT", num: "25388.3675"))
           self.cellType.append(.walletInfoType(img:UIImage(named: "eepc")!, name: "EEPC", num: "25388.3675"))
           self.cellType.append(.walletInfoType(img:UIImage(named: "cbd")!, name: "CBD", num: "25388.3675"))
           self.cellType.append(.walletInfoType(img:UIImage(named: "ido")!, name: "IDO", num: "25388.3675"))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.isTranslucent = false
    }

    override func setupView() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
    
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

        tableView.contentInset = UIEdgeInsets(top: -LL_StatusBarHeight, left: 0, bottom: 0, right: 0)
    }
    
    fileprivate func startScan(){
        self.navigationController?.pushViewController(SWQRCodeViewController(), animated: true)
    }
}

extension WalletInfoController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .walletHeadType:
            let cell:WalletHeadInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent = { [unowned self]  in
                self.startScan()
            }
            return cell
        case  .walletInfoType(let img,let name ,let num):
            let cell:WalletInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.set(img: img, name: name, num: num)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .walletHeadType:
            return fit(460)
        case .walletInfoType:
            return fit(180)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.cellType[indexPath.row] {
        case  .walletInfoType:
            self.navigationController?.pushViewController(WalletDetailController(), animated: true)

        case .walletHeadType:
            return
        }

    }
}


