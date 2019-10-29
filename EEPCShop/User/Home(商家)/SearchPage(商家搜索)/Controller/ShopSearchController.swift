//
//  ShopSearchController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit

class ShopSearchController: SNBaseViewController {
    var cellType :[searchPageType] = []
    var para:String = ""

    var searchBar = UISearchBar().then{
        $0.placeholder = "搜索店铺"
        $0.showsCancelButton = false
        $0.searchBarStyle = .minimal
        $0.barTintColor = Color(0xf5f5f5)
        $0.showsCancelButton = true;
    }

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(MerchantCell.self)
        $0.separatorStyle = .none
    }
    
    override func loadData() {
        self.cellType.append(.merchantType)
    }
    
    
    override func setupView() {
        setupUI()
        setSearchBar()
    }
    fileprivate func setupUI() {
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isEditing = false
        tableView.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
    }
    func setSearchBar(){
        self.navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
        // 创建搜索框
        searchBar.frame = CGRect(x: 0, y: 0, width:fit(493), height: 30)
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
        let cancelBtn:UIButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelBtn.setTitle("取消", for: .normal)
        cancelBtn.setTitleColor(.red, for: .normal)
        cancelBtn.addTarget(self, action: #selector(back), for: .touchUpInside)
    }
    
    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func getDate(_ para:String){
        self.cellType.append(.merchantType)
        self.tableView.reloadData()
    }

}
extension ShopSearchController:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case  .merchantType:
            let cell:MerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .merchantType:
            return fit(220)
        }
    }
}

extension ShopSearchController:UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.para = searchBar.text!
        getDate(searchBar.text!)
        
    }
    
}
