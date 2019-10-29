//
//  MinePageController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/3.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class MinePageController:SNBaseViewController {
    
    var cellType :[MinePageType] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(MinePageHeadCell.self)
        $0.register(MinePageOneCell.self)
        $0.register(MinePageTwoCell.self)
        $0.register(SpaceCell.self)
        $0.register(LoginOutCell.self)
        $0.separatorStyle = .none
    }
    override func loadData() {
        self.cellType.append(.MineHeadType)
        self.cellType.append(.MineCellOne)
        self.cellType.append(.SpaceCell)
        self.cellType.append(.MineCellTwo)
        self.cellType.append(.LoginOut)
        
    }
    override func setupView() {

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

extension MinePageController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .MineHeadType:
            let cell:MinePageHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .MineCellOne:
            let cell:MinePageOneCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickBtnEvent = {(para) in
                if para == "1"{
                    self.navigationController?.pushViewController(MyInfoEditController(), animated: true)
                }else if para == "2"{
                    self.navigationController?.pushViewController(UpdatePwdController(), animated: true)
                }else if para == "3"{
                    self.navigationController?.pushViewController(UpdatePwdController(), animated: true)
                }
            }
            return cell
        case .MineCellTwo:
            let cell:MinePageTwoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case .SpaceCell:
            let cell:SpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case .LoginOut:
            let cell:LoginOutCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickBtnEvent = {[unowned self] in
                self.present(LoginViewController(), animated: true, completion: nil)
            }
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .MineHeadType:
            return fit(347)
        case .MineCellOne:
            return fit(362)
        case .MineCellTwo:
            return fit(252)
        case .SpaceCell:
            return fit(40)
        case .LoginOut:
            return fit(130)
        }
    }
}

