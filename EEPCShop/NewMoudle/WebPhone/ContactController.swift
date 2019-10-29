//
//  ContactController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/12.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ContactController: UIViewController {
    
    var tableView: UITableView!
    /// 所有联系人信息的字典
    var addressBookSouce = [String:[PPPersonModel]]()
    /// 所有分组的key值
    var keysArray = [String]()
    
    var allPeopleArr:[PPPersonModel] = []
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    let searchImg = UIImageView().then{
        $0.image = UIImage(named: "home_search")
        $0.contentMode = .center
    }
    
    var searchField = UITextField().then{
        $0.backgroundColor = Color(0xffffff)
//        $0.textAlignment = .center
        $0.placeholder = "搜索联系人"
        $0.borderStyle = .none
        $0.font = Font(30)
        $0.layer.cornerRadius = fit(8)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "A~Z联系人分组排序"
        
        self.view.addSubview(searchField)
        
        searchField.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(40)
        }
        self.searchField.delegate = self
   
        searchImg.size = CGSize(width: fit(60), height: fit(40))
        self.searchField.leftView = searchImg
        self.searchField.leftViewMode = .always
        
        tableView = UITableView.init(frame: CGRect(x: 0, y: 40, width: ScreenW, height: ScreenH - LL_TabbarHeight - LL_StatusBarAndNavigationBarHeight), style: UITableView.Style.plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60.0
        view.addSubview(tableView)
        
        
        // MARK: - 获取A~Z分组顺序的通讯录
        PPGetAddressBook.getOrderAddressBook(addressBookInfo: { (addressBookDict, nameKeys) in
            
            CNLog(addressBookDict)
            CNLog(nameKeys)
            
            self.addressBookSouce = addressBookDict  // 所有联系人信息的字典
            self.keysArray = nameKeys       // 所有分组的key值
            
            // 刷新tableView
            self.tableView.reloadData()
            
        }, authorizationFailure: {
            
            let alertView = UIAlertController.init(title: "提示", message: "请在iPhone的“设置-隐私-通讯录”选项中，允许筋斗云访问您的通讯录", preferredStyle: UIAlertController.Style.alert)
            let confirm = UIAlertAction.init(title: "知道啦", style: UIAlertAction.Style.cancel, handler:nil)
            alertView.addAction(confirm)
            self.present(alertView, animated: true, completion: nil)
        })
        
    }
    
    deinit{
        print("挂了")
    }
    
}

extension ContactController: UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate{
 
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        CNLog(self.addressBookSouce)
        CNLog(self.keysArray)

        self.tableView.reloadData()
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return keysArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let key = keysArray[section]
        let array = addressBookSouce[key]
        
        return (array?.count)!
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return keysArray[section]
    }
    
    // 右侧索引
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return keysArray
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            
            cell = UITableViewCell.init(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        }
        
        let modelArray = addressBookSouce[keysArray[indexPath.section]]
        let model = modelArray![indexPath.row]
        
        
        cell?.textLabel?.text = model.name
//        cell?.imageView?.image = model.headerImage ?? UIImage.init(named: "defult")
        cell?.imageView?.layer.cornerRadius = 30
        cell?.imageView?.clipsToBounds = true
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let modelArray = addressBookSouce[keysArray[indexPath.section]]
        let model = modelArray![indexPath.row]
//
        self.callAction(model.mobileArray[0])
        
        
        let alertViewVC = UIAlertController.init(title: model.name, message:"\(model.mobileArray)", preferredStyle: UIAlertController.Style.alert)
        let confirm = UIAlertAction.init(title: "确定", style: UIAlertAction.Style.cancel, handler:nil)
        alertViewVC.addAction(confirm)
        self.present(alertViewVC, animated: true, completion: nil)
        
    }
    
    func callAction(_ text:String){
        
        CNLog(text)
        let url = httpUrl + "/main/callPhone"
        let para:[String:String] = ["to":text]
        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1{
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                
                let vc = CallUIViewController()
                vc.phoneNum = text
                self.navigationController?.pushViewController(vc, animated: true)
                
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
