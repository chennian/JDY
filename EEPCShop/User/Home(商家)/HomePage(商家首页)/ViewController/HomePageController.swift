//
//  HomePageController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/1.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class HomePageController: SNBaseViewController {
    
    var cellType :[homePageType] = []
    
    var searchField = UITextField().then{
        $0.placeholder = "搜索商家"
        $0.borderStyle = .roundedRect
    }
    
    var leftBtn = UIButton().then{
        $0.setTitle("深圳市", for: .normal)
        $0.setTitleColor(Color(0xa9aebe), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setImage(UIImage(named: "drop"), for: .normal)
    }
    
    var rightBtn = UIButton().then{
        $0.setTitle("地图", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(22)
        $0.backgroundColor = Color(0x3660fb)
        $0.layer.cornerRadius = fit(25)
        $0.setImage(UIImage(named: "map"), for: .normal)
    }

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(BannerCell.self)
        $0.register(ClassCell.self)
        $0.register(MapViewCell.self)
        $0.register(MerchantHeadCell.self)
        $0.register(MerchantCell.self)
        $0.register(SpaceCell.self)

        $0.separatorStyle = .none
    }
    override func loadData() {
        self.cellType.append(.bannerType)
        self.cellType.append(.classType)
        self.cellType.append(.merchantHeadType)
        self.cellType.append(.merchantType)
        self.cellType.append(.merchantType)
        self.cellType.append(.spaceType)
    }
    override func setupView() {
        setTitleView()
        setNavigationBtn()
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchField.delegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    
    func setNavigationBtn(){
        self.rightBtn.width = fit(104)
        self.rightBtn.height = fit(50)
        
        self.leftBtn.width = fit(104)
        self.leftBtn.height = fit(50)
        
        self.rightBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: fit(70), bottom: 0, right: 0)
        self.rightBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: fit(-30), bottom: 0, right: 0)
        
        self.leftBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: fit(80), bottom: 0, right: 0)
        self.leftBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: fit(-50), bottom: 0, right: 0)

        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: leftBtn)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        self.rightBtn.addTarget(self, action: #selector(enterMap), for: .touchUpInside)
        
    }
    
    @objc func enterMap(){
        
        if self.rightBtn.title(for: .normal)! == "地图" {
            self.rightBtn.setImage(UIImage(named: "list"), for: .normal)
            self.rightBtn.setTitle("列表", for: .normal)
            
            self.cellType.removeAll()
            
            self.cellType.append(.mapType)
            self.cellType.append(.merchantType)
            self.cellType.append(.merchantType)
            
            self.tableView.reloadData()

        }else{
            self.rightBtn.setImage(UIImage(named: "map"), for: .normal)
            self.rightBtn.setTitle("地图", for: .normal)
            
            self.cellType.removeAll()
            
            self.cellType.append(.bannerType)
            self.cellType.append(.classType)
            self.cellType.append(.merchantHeadType)
            self.cellType.append(.merchantType)
            self.cellType.append(.merchantType)
            self.cellType.append(.spaceType)
            
            self.tableView.reloadData()

        }
  
        
        
    }
    
    func setTitleView(){
        
        self.navigationItem.titleView = self.searchField
        self.searchField.frame.size.width = fit(420)

        
    }
}

extension HomePageController:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        self.navigationController?.pushViewController(ShopSearchController(), animated: true)
        return false
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .spaceType:
            let cell:SpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .classType:
            let cell:ClassCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .merchantHeadType:
            let cell:MerchantHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .merchantType:
            let cell:MerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .bannerType:
            let cell:BannerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case .mapType:
            let cell:MapViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .bannerType:
            return fit(300)
        case .classType:
            return fit(282)
        case .merchantHeadType:
            return fit(80)
        case .merchantType:
            return fit(220)
        case .spaceType:
            return fit(20)
        case .mapType:
            return fit(505)
        }
    }
}
