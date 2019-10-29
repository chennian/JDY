//
//  WalletDetailController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/4.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class WalletDetailController:SNBaseViewController {
    
    var cellType :[WalletDetailType] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(WalletDetailHeadCell.self)
        $0.register(WalletDetailInfoCell.self)
        $0.register(SpaceCell.self)
        $0.separatorStyle = .none
    }
    override func loadData() {
        self.cellType.append(.WalletDetailHead)
        self.cellType.append(.WalletDetailInfo)
        self.cellType.append(.WalletDetailInfo)
        self.cellType.append(.WalletDetailInfo)
        self.cellType.append(.WalletDetailInfo)

    }
    override func setupView() {
        
        self.title = "USDT"
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
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true

    }
}

extension WalletDetailController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .WalletDetailHead:
            let cell:WalletDetailHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .WalletDetailInfo:
            let cell:WalletDetailInfoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .WalletDetailHead:
            return fit(480)
        case .WalletDetailInfo:
            return fit(158)
        }
    }
}
