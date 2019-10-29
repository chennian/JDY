//
//  MineCenterController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/16.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class MineCenterController: SNBaseViewController {
    
    var cellType :[MineType] = []
    
    var model :ShopMsgModel?
    var userModel :UserModel?
    
    var balance:String = ""

    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(TwoCell.self)
        $0.register(OneCell.self)
        $0.register(ZeroCell.self)
        $0.register(ThreeCell.self)
        $0.register(FourCell.self)
        $0.register(MIneBanner.self)


        $0.separatorStyle = .none
    }
    override func setupView() {
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(-LL_StatusBarHeight)
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

    
     func setUpView() {
        
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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = true
        self.tableView.setContentOffset(CGPoint(x: 0, y: -LL_StatusBarHeight), animated: false)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
        
//        navigationController?.navigationBar.isTranslucent = false
    }
    
    override func loadData() {
        
        SZHUD("请求中...", type: .loading, callBack: nil)
        let url = httpUrl + "/main/userMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                self.userModel = UserModel.init(jsonData: jsonData["data"])

                let is_shop = jsonData["data"]["is_shop"].stringValue
                self.balance = jsonData["data"]["money"].stringValue
                XKeyChain.set(is_shop, key: ISSHOP)
                
                self.loadShopMsg(is_shop)
            }else if jsonData["code"].intValue == 1006 {
              let vc = LoginViewController()
              vc.modalPresentationStyle = .fullScreen
              self.present(vc, animated: true, completion: nil)
             
                
              SZHUDDismiss()

            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
                SZHUDDismiss()

                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
                SZHUDDismiss()
            }
        }
    }
    
    func loadShopMsg(_ is_shop:String) {
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                self.cellType.removeAll()
                
                self.model = ShopMsgModel.init(jsonData: jsonData["data"])
                self.model!.balance  = self.balance

                //登录成功数据解析
                if is_shop == "0"{ //普通用户
                    
                    DispatchQueue.main.async {
                        self.cellType.append(.zeroCell)
//                        self.cellType.append(.banner)
//                        self.setUpView()
                        self.tableView.reloadData()
                    }
                    
                }else if is_shop == "1"{
                    DispatchQueue.main.async {
                        self.cellType.append(.oneCell)
//                        self.cellType.append(.banner)
//                        self.setUpView()

                        self.tableView.reloadData()

                        // 待审核
                    }
                }else if is_shop == "2"{
                    DispatchQueue.main.async {
                        self.cellType.append(.twoCell)
//                        self.cellType.append(.banner)
//                        self.setUpView()

                        self.tableView.reloadData()

                        // 入驻成功
                    }
                }else if is_shop == "3"{
                    DispatchQueue.main.async {
                        self.cellType.append(.threeCell)
//                        self.cellType.append(.banner)
//                        self.setUpView()

                        self.tableView.reloadData()

                        // 审核失败
                    }
                }else{
                    DispatchQueue.main.async {
                        self.cellType.append(.fourCell)
//                        self.cellType.append(.banner)
//                        self.setUpView()

                        self.tableView.reloadData()

                        //待完善
                    }
                }
                SZHUDDismiss()
            }else if jsonData["code"].intValue == 1006 {
                let vc = LoginViewController()
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
                SZHUDDismiss()

            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)

                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)

            }
        }
    }
    
}

extension MineCenterController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellType.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.cellType[indexPath.row] {
        case .fourCell:
            let cell:FourCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.shopfuncView.clickEventPara = {[unowned self] (para)in
                if para == 1{
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(MyCouponController(), animated: true)
                }else if para == 3{
                    self.navigationController?.pushViewController(UpdateApplyController(), animated: true)
                }else if para == 4{
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                }
            }
            
            cell.rmdToolView.clickEvent = {[unowned self] para in
                //                SZHUD("暂停使用", type: .info, callBack: nil)
                switch para {
                case 1:
                    let vc = WebController()
                    vc.title = "火车票"
                    vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "电影票"
                    vc.urlString = "http://shop.shijihema.cn/common/ticket/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 3:
                    let vc = WebController()
                    vc.title = "飞机票"
                    vc.urlString = "http://shop.shijihema.cn/common/plane/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    let vc = WebController()
                    vc.title = "手机充值"
                    vc.urlString = "http://shop.shijihema.cn/common/chongzhi/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 5:
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                    
                    break
                default:
                    break
                }
            }
            cell.model = self.model
            cell.clickBtnEvent = {[unowned self] in
                self.navigationController?.pushViewController(UpdateApplyController(), animated: true)
            }
            cell.clickEvent = {[unowned self] para in
                switch para {
                case 1:
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                    
                }
            }
            cell.shopHeadView.clickEvent = {[unowned self] in
                self.navigationController?.pushViewController(SettingController(), animated: true)
            }
            cell.shopHeadView.clickEvent2 = {[unowned self] in
                self.navigationController?.pushViewController(ServiceViewController(), animated: true)
            }
            cell.toolView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                }else if para == 2{
                    self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                }else if para == 3{
                    let vc = ShopListAndMapController()
                    vc.total = "100"
                    vc.num = "7"
                    vc.city = XKeyChain.get(CITY)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 4{
                    let vc = WebController()
                    vc.title = "视频会员"
                    vc.urlString = "http://shop.shijihema.cn/common/mm/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return cell
        case .threeCell:
            let cell:ThreeCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.shopfuncView.clickEventPara = {[unowned self] (para)in
                if para == 1{
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(MyCouponController(), animated: true)
                }else if para == 3{
                    self.navigationController?.pushViewController(UpdateApplyController(), animated: true)
                }else if para == 4{
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                }
            }

            cell.rmdToolView.clickEvent = {[unowned self] para in
                //                SZHUD("暂停使用", type: .info, callBack: nil)
                switch para {
                case 1:
                    let vc = WebController()
                    vc.title = "火车票"
                    vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "电影票"
                    vc.urlString = "http://shop.shijihema.cn/common/ticket/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                    
                case 3:
                    let vc = WebController()
                    vc.title = "飞机票"
                    vc.urlString = "http://shop.shijihema.cn/common/plane/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    let vc = WebController()
                    vc.title = "手机充值"
                    vc.urlString = "http://shop.shijihema.cn/common/chongzhi/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 5:
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                    
                    break
                default:
                    break
                }
            }
            cell.model = self.model
            cell.clickEvent = {[unowned self] para in
                switch para {
                case 1:
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                    
                }
            }
            /**  审核失败重新进件**/
            cell.clickBtnEvent = {[unowned self] in
                self.navigationController?.pushViewController(UpdateApplyController(), animated: true)
            }
            cell.shopHeadView.clickEvent = {[unowned self] in
                self.navigationController?.pushViewController(SettingController(), animated: true)
            }
            cell.shopHeadView.clickEvent2 = {[unowned self] in
                self.navigationController?.pushViewController(ServiceViewController(), animated: true)
            }
            cell.toolView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                }else if para == 2{
                    self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                }else if para == 3{
                    let vc = ShopListAndMapController()
                    vc.total = "100"
                    vc.num = "7"
                    vc.city = XKeyChain.get(CITY)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 4{
                    let vc = WebController()
                    vc.title = "视频会员"
                    vc.urlString = "http://shop.shijihema.cn/common/mm/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            return cell
        case  .twoCell:
            let cell:TwoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.rmdToolView.clickEvent = {[unowned self] para in
                //                SZHUD("暂停使用", type: .info, callBack: nil)
                switch para {
                case 1:
                    let vc = WebController()
                    vc.title = "火车票"
                    vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "电影票"
                    vc.urlString = "http://shop.shijihema.cn/common/plane/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 3:
                    let vc = WebController()
                    vc.title = "飞机票"
                    vc.urlString = "http://shop.shijihema.cn/common/ticket/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    let vc = WebController()
                    vc.title = "手机充值"
                    vc.urlString = "http://shop.shijihema.cn/common/chongzhi/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                }
            }
            cell.model = self.model
            cell.shopHeadView.clickEvent = {[unowned self] in
                self.navigationController?.pushViewController(SettingController(), animated: true)
            }
            cell.shopHeadView.clickEvent2 = {[unowned self] in
                self.navigationController?.pushViewController(ServiceViewController(), animated: true)
            }
            cell.shopProfitView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    self.navigationController?.pushViewController(BusinessLogController(), animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(RectProfitController(), animated: true)
                }else if para == 3{
                    self.navigationController?.pushViewController(RmdProfitLogController(), animated: true)
                }else{
                    self.navigationController?.pushViewController(ExtractCashController(), animated: true)
                }
            }
            
            cell.toolView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    self.navigationController?.pushViewController(MyCouponController(), animated: true)
                }else if para == 2{
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                }else if para == 3{
                    self.navigationController?.pushViewController(ShopManagerController(), animated: true)
                }else if para == 4{
                    self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                }

            }
            cell.clickEvent = {[unowned self] para in
                switch para {
                case 1:
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                    
                }
            }
            cell.shopfuncView.clickEventPara = {[unowned self] (para)in
                if para == 1{
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 2{
                    let vc = GoodManagerController()
                    vc.title = "商品管理"
                    vc.urlString = "http://shop.shijihema.cn/common/shopManger/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 3{
                    self.navigationController?.pushViewController(ReceiveCodeViewController(), animated: true)

                }else if para == 4{
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                }
            }
            
            return cell
            
        case .oneCell:
            let cell:OneCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = self.model
            cell.rmdToolView.clickEvent = {[unowned self] para in
                //                SZHUD("暂停使用", type: .info, callBack: nil)
                switch para {
                case 1:
                    let vc = WebController()
                    vc.title = "火车票"
                    vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "电影票"
                    vc.urlString = "http://shop.shijihema.cn/common/plane/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 3:
                    let vc = WebController()
                    vc.title = "飞机票"
                    vc.urlString = "http://shop.shijihema.cn/common/ticket/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    let vc = WebController()
                    vc.title = "手机充值"
                    vc.urlString = "http://shop.shijihema.cn/common/chongzhi/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                }
            }
            cell.clickEvent = {[unowned self] para in
                switch para {
                case 1:
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                    
                }
            }
            cell.shopHeadView.clickEvent = {[unowned self] in
                self.navigationController?.pushViewController(SettingController(), animated: true)
            }
            cell.shopHeadView.clickEvent2 = {[unowned self] in
                self.navigationController?.pushViewController(ServiceViewController(), animated: true)
            }
            cell.toolView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                }else if para == 2{
                    self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                }else if para == 3{
                    let vc = ShopListAndMapController()
                    vc.total = "100"
                    vc.num = "7"
                    vc.city = XKeyChain.get(CITY)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 4{
                    let vc = WebController()
                    vc.title = "视频会员"
                    vc.urlString = "http://shop.shijihema.cn/common/mm/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            
            cell.shopfuncView.clickEventPara = {[unowned self] (para)in
                if para == 1{
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(MyCouponController(), animated: true)
                }else if para == 3{
//                    self.navigationController?.pushViewController(MyInfoStepOneController(), animated: true)
                }else if para == 4{
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                }
            }

            return cell

        case .zeroCell:
            let cell:ZeroCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = self.userModel
            cell.rmdToolView.clickEvent = {[unowned self] para in
//                SZHUD("暂停使用", type: .info, callBack: nil)
                switch para {
                case 1:
                    let vc = WebController()
                    vc.title = "火车票"
                    vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "电影票"
                    vc.urlString = "http://shop.shijihema.cn/common/ticket/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
               
                case 3:
                    let vc = WebController()
                    vc.title = "飞机票"
                    vc.urlString = "http://shop.shijihema.cn/common/plane/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 4:
                    let vc = WebController()
                    vc.title = "手机充值"
                    vc.urlString = "http://shop.shijihema.cn/common/chongzhi/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                case 5:
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }

                    break
                default:
                    break
                }
            }
         
            cell.userHeadView.clickEvent = {[unowned self] in
                self.navigationController?.pushViewController(SettingController(), animated: true)
            }
            cell.userHeadView.clickEvent2 = {[unowned self] in
                self.navigationController?.pushViewController(ServiceViewController(), animated: true)
            }

            cell.userHeadView.clickEventPara = {[unowned self] (para)in
                if para == 1{
                    self.navigationController?.pushViewController(RmdProfitLogController(), animated: true)
                }else if para == 2{
                    self.navigationController?.pushViewController(ExtractCashController(), animated: true)
                }else if para == 3{
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 4{
                     self.navigationController?.pushViewController(MyCouponController(), animated: true)
                }else if para == 5{
                    self.navigationController?.pushViewController(MyInfoStepOneController(), animated: true)
                }else if para == 6{
                     self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                }
            }
            
            
            cell.userToolView.clickEvent = {[unowned self] (para)in
                if para == 1{
                    let app = UIApplication.shared
                    let url = URL(string: "ds.ui-token.com://")
                    if app.canOpenURL(url!) {
                        app.openURL(url!)
                    }else{
                        app.openURL(URL(string: "https://apps.apple.com/cn/app/%E5%A4%A7%E5%9C%A3%E7%94%B5%E5%95%86/id1474192681")!)
                    }
                }else if para == 2{
                    self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                }else if para == 3{
                    let vc = ShopListAndMapController()
                    vc.total = "100"
                    vc.num = "7"
                    vc.city = XKeyChain.get(CITY)
                    self.navigationController?.pushViewController(vc, animated: true)
                }else if para == 4{
                    let vc = WebController()
                    vc.title = "视频会员"
                    vc.urlString = "http://shop.shijihema.cn/common/mm/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
            cell.clickEvent = {[unowned self] para in
                switch para {
                case 1:
                    self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
                    break
                case 2:
                    let vc = WebController()
                    vc.title = "推荐好友"
                    vc.urlString = "http://shop.shijihema.cn/common/shareFriend/" + XKeyChain.get(TOKEN)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    break
                default:
                    break
                    
                }
            }
            return cell
        case .banner:
            let cell:MIneBanner = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .twoCell:
            return fit(1200 + 150 + 30 + 120)
        case .zeroCell:
            return fit(1000 + 150 + 180 + 160 )
        case .oneCell:
            return fit(1150 + 150 + 100)
        case .threeCell:
            return fit(1150 + 150 + 50)
        case .fourCell:
            return fit(1150 + 150 + 50)
        case .banner:
            return fit(180)
        }
    }
}

