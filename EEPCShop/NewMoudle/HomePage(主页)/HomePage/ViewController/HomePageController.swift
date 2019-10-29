//
//  HomePageController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/1.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class HomePageController: SNBaseViewController {
    
    
    var total:String = ""
    
    var num :String = ""
    
    var cellType :[homePageType] = []
    
    var model:[HomePageModel] = []
    
    var arrMenu :[CatModel] = []
    
    var bannerModel :[BannerModel] = []
    
    var bannerArray:[BannerModel] = []
    
    var adArray : [BannerModel] = []
    
    var city:String?

    var leftBtn = UIButton().then{
        $0.setImage(UIImage(named: "Scan"), for: .normal)
    }
    
    var rightBtn = UIButton().then{
        $0.setImage(UIImage(named: "home_fold"), for: .normal)
        $0.backgroundColor = .clear
    }
    
    let backImageView = UIImageView().then{
        $0.image = UIImage(named: "home_bgtop1")
    }
    
    let couponImage = UIButton().then{
        $0.setImage(UIImage(named: "redmyn"), for: .normal)
    }
    
    let titleView = titleview().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
        $0.isUserInteractionEnabled = true
        $0.backgroundColor = .clear
    }

    
    let icon = UIImageView().then{
        $0.image = UIImage(named: "home_vatar")
        $0.backgroundColor = .clear
    }
    
    let cityButton = UIButton().then{
        $0.setTitle("深圳市", for: .normal)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.titleLabel?.font = Font(28)
        $0.setImage(UIImage(named: "home_city"), for: .normal)
        $0.backgroundColor = .clear
    }

    
    var searchField = UITextField().then{
        $0.backgroundColor = Color(0xffffff)
        $0.placeholder = "搜索商家"
        $0.borderStyle = .none
        $0.font = Font(28)
        $0.layer.cornerRadius = fit(8)
    }
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(BannerCell.self)
        $0.register(ClassCell.self)
        $0.register(ADModuleCell.self)
        $0.register(MerchantHeadCell.self)
        $0.register(MerchantCell.self)
        $0.register(EmptyTableSetCell.self)
        $0.register(SpaceCell.self)
        $0.register(TopFunctionCell.self)
        $0.register(TopFunction2Cell.self)
        $0.register(MerchantByGoodCell.self)
        $0.separatorStyle = .none
    }
    
    override func loadData() {
        
        SZHUD("请求中...", type: .loading, callBack: nil)
        let url = httpUrl + "/main/userMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
              
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
    
    
    func loadShopCatData(){
        let url = httpUrl + "/common/shopCat"
        Alamofire.request(url, method: .post, parameters:nil, headers:nil).responseJSON { [unowned self](res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                self.bannerArray.removeAll()
                self.adArray.removeAll()
                self.arrMenu.removeAll()
                self.bannerModel.removeAll()
                //登录成功数据解析
                self.arrMenu = jsonData["newData"]["cat"].arrayValue.compactMap { CatModel(jsonData: $0) }
                self.bannerModel = jsonData["newData"]["banner"].arrayValue.compactMap { BannerModel(jsonData: $0) }
                
                self.total = jsonData["newData"]["coupon"]["base"].stringValue
                self.num = jsonData["newData"]["coupon"]["bonus"].stringValue
                
                for item in self.bannerModel {
                    if item.type == "1"{
                        self.bannerArray.append(item)
                    }else{
                        self.adArray.append(item)
                    }
                }
                
                self.loadShopData(self.city!)
                
            }else{
                SZHUD(jsonData["msg"].stringValue , type: .error, callBack: nil)
            }
        }
    }
    
    func loadShopData(_ city:String) {
        
        self.searchField.resignFirstResponder()
        CNLog(city)
    
        if XKeyChain.get(latitudeKey).isEmpty {
            XKeyChain.set("0", key: latitudeKey)
        }
        
        if XKeyChain.get(longiduteKey).isEmpty {
            XKeyChain.set("0", key: longiduteKey)
        }
        
        let url = httpUrl + "/common/shopList/" +  XKeyChain.get(longiduteKey)  + "/" + XKeyChain.get(latitudeKey)
        let para:[String:String] = ["city":city]
        SZHUD("加载中.." , type: .loading, callBack: nil)

        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                let jsonObj = jsonData["data"]
                self.model = jsonObj.arrayValue.compactMap { HomePageModel(jsonData: $0) }
            
                self.cellType.removeAll()
                
                self.cellType.append(.bannerType)
//                self.cellType.append(.spaceType)
                self.cellType.append(.classType)
                self.cellType.append(.spaceType)
                self.cellType.append(.adType)
//                self.cellType.append(.spaceType)
                self.cellType.append(.merchantHeadType)
                
                if !self.model.isEmpty{
                    for item in self.model {
                        CNLog(item.goods)
                        item.base = self.total
                        item.bouns = self.num
                        
                        if item.goods.isEmpty {
                            self.cellType.append(.merchantType(item))
                        }else{
                            self.cellType.append(.merchantByGoodType(item))
                        }
                        
                    
                    }
                }
                
                if self.cellType.count <= 6 {
                    self.cellType.append(.emptyType)
                }
                
                self.tableView.reloadData()
                if !XKeyChain.get(UITOKEN_UID).isEmpty && XKeyChain.get(UITOKEN_UID) != ""{
                    CNLog(XKeyChain.get(UITOKEN_COUPOM))
                    if XKeyChain.get(UITOKEN_COUPOM) == "0" {
                        self.setCoupon()
                    }
                }
                
                SZHUDDismiss()
                
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
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let image =  self.imageFromColor(color: Color(0xf5f5f5), viewSize: CGSize.init(width: ScreenW, height: LL_StatusBarAndNavigationBarHeight))
        
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = self.imageFromColor(color: Color(0xd8dade), viewSize: CGSize.init(width: ScreenW, height: fit(1)))
        
    }
    
    func imageFromColor(color: UIColor, viewSize: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "home_bgtop1"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        setTableView()
  

//        self.navigationController?.navigationBar.shadowImage = self.imageFromColor(color: Color(0xd8dade), viewSize: CGSize.init(width: ScreenW, height: fit(1)))
    }
    
    //接受通知
    func receiveNotify(){
        let NotifyOne = NSNotification.Name(rawValue:"cityName")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopName(notify:)), name: NotifyOne, object: nil)
    }
    
    @objc func getShopName(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        var str:String = ""
        if text.count > 3 {
            str = text.prefix(2) + "..."
        }else{
            str = text
        }
        self.city = text
        self.cityButton.setTitle(str, for: .normal)
//        self.loadShopData(text)
    }
    
    func setCoupon(){
        self.tableView.isUserInteractionEnabled = false
        
        self.view.addSubview(couponImage)
        
        
        couponImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(350)
            make.width.snEqualTo(320)
            make.height.snEqualTo(417)
        }
        
        couponImage.addTarget(self, action: #selector(getCoupon), for: .touchUpInside)
        
    }
    
    @objc func getCoupon() {
        SZHUD("请求中...", type: .loading, callBack: nil)
        
        let url = httpUrl + "/main/getDSCoupon"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                XKeyChain.set("1", key: UITOKEN_COUPOM)
                
                self.couponImage.removeFromSuperview()
                self.tableView.isUserInteractionEnabled = true
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                
            }else if jsonData["code"].intValue == 1006 {
                SZHUDDismiss()
             let vc = LoginViewController()
             vc.modalPresentationStyle = .fullScreen
             self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    func setTableView(){
        self.view.addSubview(tableView)
        tableView.bounces = false
        tableView.backgroundColor = .clear
        tableView.delegate = self
        tableView.dataSource = self
        extendedLayoutIncludesOpaqueBars = true;
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        
        
        tableView.contentInset = UIEdgeInsets(top: LL_StatusBarAndNavigationBarHeight + fit(20), left: 0, bottom: LL_TabbarHeight, right: 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        
        backImageView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview().snOffset(-LL_StatusBarAndNavigationBarHeight)
            make.height.snEqualTo(350 + LL_Extra)
        }
        
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
        self.loadShopCatData()

    }
    
    func getCouponAction() {
        SZHUD("请求中...", type: .loading, callBack: nil)
        
        let url = httpUrl + "/main/getcoupon"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                
            }else if jsonData["code"].intValue == 1006 {
                SZHUDDismiss()
               let vc = LoginViewController()
               vc.modalPresentationStyle = .fullScreen
               self.present(vc, animated: true, completion: nil)
            }else if !jsonData["msg"].stringValue.isEmpty{
                SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                
            }else{
                SZHUD("网络异常" , type: .error, callBack: nil)
            }
        }
    }
    
    override func setupView() {
        
        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
        }
        
        receiveNotify()
        setTitleView()
        setNavigationBar()
        setNavigationBtn()
        self.view.backgroundColor = Color(0xf5f5f5)
        self.view.addSubview(backImageView)
        
        if XKeyChain.get(CITY).isEmpty {
            self.city = "未定位"
        }else{
            self.city = XKeyChain.get(CITY)
        }
        
    }
    func setNavigationBar(){
//        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "home_bgtop1"), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setNavigationBtn(){
        
        self.cityButton.addTarget(self, action: #selector(selectCity), for: .touchUpInside)
        
        
        if XKeyChain.get(CITY).isEmpty{
            self.cityButton.setTitle("未定位", for: .normal)
        }else{
            self.cityButton.setTitle(XKeyChain.get(CITY), for: .normal)
        }
//        self.loadShopCatData()
        
    }
    @objc func selectCity(){
//        self.navigationController?.pushViewController(CityListControlelr(), animated: true)
        self.navigationController?.pushViewController(CitySelectorViewController(), animated: true)

        
    }
    
    @objc func enterMap(_ sender:UIBarButtonItem){
        
        self.showXYMenu(sender: sender, type: .XYMenuRightNavBar, isNav: true)
        
    }
    
    @objc func scanAction(){
        let vc = SWQRCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    func setTitleView(){
        self.titleView.size = CGSize(width: fit(750), height: fit(70))
        self.navigationItem.titleView = self.titleView
    
        self.titleView.addSubview(self.icon)
        self.titleView.addSubview(self.cityButton)
        self.titleView.addSubview(self.rightBtn)
        self.rightBtn.addTarget(self, action: #selector(enterMap(_:)), for: .touchUpInside)
        cityButton.semanticContentAttribute = .forceRightToLeft
        
        
        self.titleView.addSubview(self.searchField)
        self.searchField.delegate = self
        let searchImg = UIImageView().then{
            $0.image = UIImage(named: "home_search")
            $0.contentMode = .center
        }
        searchImg.size = CGSize(width: fit(60), height: fit(40))
        self.searchField.leftView = searchImg
        self.searchField.leftViewMode = .always
        
        icon.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.snEqualTo(51)
            make.height.snEqualTo(46)
        }
        
        self.cityButton.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(120)
        }
        
        searchField.snp.makeConstraints { (make) in
            make.left.equalTo(cityButton.snp.right)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(480)
        }
        
        rightBtn.snp.makeConstraints { (make) in
            make.left.equalTo(searchField.snp.right).snOffset(10)
            make.top.bottom.equalToSuperview()
            make.width.snEqualTo(42)
        }
    }
}

extension HomePageController:UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        let vc  = ShopSearchController()
        vc.city = self.cityButton.title(for: .normal)!
        vc.total = self.total
        vc.num = self.num
        self.navigationController?.pushViewController(vc, animated: false)
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
            cell.model = self.arrMenu
            cell.clickEvent = {[unowned self] (index,catName) in
                let vc = ShopCatListController()
                vc.city = self.cityButton.title(for: .normal)!
                vc.cat = index
                vc.selfTitle = catName
                vc.total = self.total
                vc.num = self.num
                self.navigationController?.pushViewController(vc, animated: false)
            }
            return cell
        case  .adType:
            let cell:ADModuleCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEventOne = {[unowned self] in
                let jsonData =  self.adArray[0].url.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
                let json = JSON(data: jsonData)
                if json["type"].stringValue == "1"{
                    
                    let vc = ShopCatListController()
                    vc.city = json["data"]["city"].stringValue
                    vc.cat =  json["data"]["category"].stringValue
                    vc.selfTitle =  json["data"]["name"].stringValue
                    vc.total = self.total
                    vc.num = self.num
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                }
            }
            cell.clickEventTwo = {[unowned self] in
                let jsonData =  self.adArray[1].url.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
                let json = JSON(data: jsonData)
                if json["type"].stringValue == "1"{
                    
                    let vc = ShopCatListController()
                    vc.city = json["data"]["city"].stringValue
                    vc.cat =  json["data"]["category"].stringValue
                    vc.selfTitle =  json["data"]["name"].stringValue
                    vc.total = self.total
                    vc.num = self.num
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                }
            }
            cell.clickEventThree = {[unowned self] in
                let jsonData =  self.adArray[2].url.data(using: String.Encoding.utf8, allowLossyConversion: false) ?? Data()
                let json = JSON(data: jsonData)
                if json["type"].stringValue == "1"{
                    
                    let vc = ShopCatListController()
                    vc.city = json["data"]["city"].stringValue
                    vc.cat =  json["data"]["category"].stringValue
                    vc.selfTitle =  json["data"]["name"].stringValue
                    vc.total = self.total
                    vc.num = self.num
                    self.navigationController?.pushViewController(vc, animated: false)
                    
                }
            }
            cell.clickEventFour = {[unowned self] in
                if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                    SZHUD("请登录...", type: .info, callBack: nil)
                    return
                }
                
                self.navigationController?.pushViewController(RmdInfoViewController(), animated: true)
            }
            cell.models = self.adArray
            return cell
        case  .merchantHeadType:
            let cell:MerchantHeadCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        case  .merchantType(let model):
            let cell:MerchantCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.model = model
            cell.clickEvent  = { [unowned self] in
                self.getCoupon()
            }
            return cell
        case  .merchantByGoodType(let model):
            let cell:MerchantByGoodCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            cell.clickEvent  = { [unowned self] in
                self.getCoupon()
            }
            cell.model = model
            return cell
        case  .bannerType:
            if XKeyChain.get(ISSHOP) == "2" {
                let cell:TopFunctionCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                //            cell.models = self.bannerArray
                cell.clickEvent = { [unowned self] (para) in
                    
                    switch para {
                    case 1:
                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                            return
                        }
                        let vc = SWQRCodeViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        break
                    case 2:
                        let vc = ReceiveCodeViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 3:
                        let vc = MyCouponController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 4:
                        let vc = ShopListAndMapController()
                        vc.total = self.total
                        vc.num = self.num
                        vc.city = self.cityButton.title(for: .normal)!
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 5:
                        if XKeyChain.get(TOKEN).isEmpty || XKeyChain.get(TOKEN) == ""{
                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                            return
                        }
                        let vc = WebController()
                        vc.title = "火车票"
                        vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    default:
                        break
                    }
                    
                }
                return cell
 
            }else{
                let cell:TopFunction2Cell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                //            cell.models = self.bannerArray
                cell.clickEvent = { [unowned self] (para) in
                    
                    switch para {
                    case 1:
                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                            return
                        }
                        let vc = SWQRCodeViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                        break
                    case 2:
                        let vc = MyCouponController()
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 3:
                        let vc = ShopListAndMapController()
                        vc.total = self.total
                        vc.num = self.num
                        vc.city = self.cityButton.title(for: .normal)!
                        self.navigationController?.pushViewController(vc, animated: true)
                        break
                    case 4:
                        if XKeyChain.get(TOKEN).isEmpty || XKeyChain.get(TOKEN) == ""{
                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                            return
                        }
                        let vc = WebController()
                        vc.title = "火车票"
                        vc.urlString = "http://shop.shijihema.cn/common/train/" + XKeyChain.get(TOKEN)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    default:
                        break
                    }
                    
                    
                }
                return cell
            }
        
        case .emptyType:
            let cell:EmptyTableSetCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        default:
            let cell:SpaceCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.cellType[indexPath.row] {
        case .bannerType:
            return fit(180)
        case .classType:
            return fit(300)
        case .adType:
            return fit(480)
        case .merchantHeadType:
            return fit(80)
        case .merchantType:
            return fit(200)
        case .merchantByGoodType:
            return fit(465)
        case .spaceType:
            return fit(20)
        case .emptyType:
            return fit(450)
        default :
            return fit(20)
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch self.cellType[indexPath.row] {
        case .merchantType(let model):
            
            if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
            let vc = LoginViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
                return
            }

            let vc = ShopDetailWebController()
            vc.urlString = "http://shop.shijihema.cn/common/shoperShopDetail/" + XKeyChain.get(TOKEN) + "/" + XKeyChain.get(latitudeKey) +     "/" + XKeyChain.get(longiduteKey) + "/" + model.shop_id
            self.navigationController?.pushViewController(vc, animated: true)
            vc.addressDetail = model.address_detail
        case .merchantByGoodType(let model):
            
            if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                    let vc = LoginViewController()
          vc.modalPresentationStyle = .fullScreen
          self.present(vc, animated: true, completion: nil)
                return
            }

            let vc = ShopDetailWebController()
            vc.urlString = "http://shop.shijihema.cn/common/shoperShopDetail/" + XKeyChain.get(TOKEN) + "/" + XKeyChain.get(latitudeKey) +     "/" + XKeyChain.get(longiduteKey) + "/" + model.shop_id
            vc.addressDetail = model.address_detail
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        default:
            return
            
        }
    }
}
//extension HomePageController:UIScrollViewDelegate{
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView .isEqual(self.tableView) {
//            CNLog(self.tableView.contentOffset.y)
//            if self.tableView.contentOffset.y  > -LL_StatusBarAndNavigationBarHeight + fit(180){
//                tableView.backgroundColor = Color(0xffffff)
//
//                self.navigationController?.navigationBar.isTranslucent = false
//                let image =  self.imageFromColor(color: Color(0x5092FE), viewSize: CGSize.init(width: ScreenW, height: LL_StatusBarAndNavigationBarHeight))
//
//                self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
//                self.navigationController?.navigationBar.shadowImage = self.imageFromColor(color: Color(0xd8dade), viewSize: CGSize.init(width: ScreenW, height: fit(1)))
//
//            }else{
//                tableView.backgroundColor = .clear
//
//                self.navigationController?.navigationBar.isTranslucent = true
//                self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
//                self.navigationController?.navigationBar.shadowImage = UIImage()
//            }
//        }
//    }
//}


extension HomePageController {
    
    func showXYMenu(sender: UIBarButtonItem, type: XYMenuType, isNav: Bool) {
        var images :[String] = []
        var titles:[String] = []
        
        if XKeyChain.get(ISSHOP) == "0" || XKeyChain.get(ISSHOP).isEmpty{
            images = ["icon1","icon3","icon4"]
            titles = ["扫一扫","地图","客服"]
        }else{
            images = ["icon1", "icon2", "icon3","icon4"]
            titles = ["扫一扫", "收款码", "地图","客服"]
        }
        sender.xy_showXYMenu(images: images,
                             titles: titles,
                             currentNavVC: self.navigationController!,
                             type: type,
                             closure: { [unowned self] (index) in
                                if XKeyChain.get(ISSHOP) == "0" || XKeyChain.get(ISSHOP).isEmpty{
                                    if index == 1{
                                        
                                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                                            return
                                        }
                                        
                                        let vc = SWQRCodeViewController()
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else if index == 2{
                                        let vc = ShopListAndMapController()
                                        vc.total = self.total
                                        vc.num = self.num
                                        vc.city = self.cityButton.title(for: .normal)!
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        
                                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                                            return
                                        }
                                        self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                                    }
                                }else{
                                    if index == 1{
                                        
                                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                                            return
                                        }
                                        
                                        let vc = SWQRCodeViewController()
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else if index == 2{
                                        
                                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                                            return
                                        }
                                        self.navigationController?.pushViewController(ReceiveCodeViewController(), animated: true)
                                    }else if index == 3{
                                        let vc = ShopListAndMapController()
                                        vc.city = self.cityButton.title(for: .normal)!
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }else{
                                        
                                        if XKeyChain.get(UITOKEN_UID).isEmpty || XKeyChain.get(UITOKEN_UID) == ""{
                                            SZHUD("请登录后再使用", type: .info, callBack: nil)
                                            return
                                        }
                                        self.navigationController?.pushViewController(ServiceViewController(), animated: true)
                                    }
                                }
                                
                                
        })
    }
}
