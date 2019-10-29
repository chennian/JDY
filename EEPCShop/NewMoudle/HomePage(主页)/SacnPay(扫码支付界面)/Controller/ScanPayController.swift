//
//  ScanPayController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/18.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ScanPayController: SNBaseViewController {
    
    fileprivate let couponPiker  = CustomPiker.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216),type:.couponType)

    var shop_id:String?
    var discount:String?
    
    var shop_img :String?
    var shop_name:String?
    var pay_num :String?
    
    var coupon_id:String?
    var coupon_name:String?

    
    var coupon:CouponModel?
    var userCoupon:[UserCouponModel] = []
    
    var isSelected:Bool = false
    
    let passwordView = PassWordField().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    
    let mask = UIView().then{
        $0.backgroundColor = Color(0x000000)
        $0.alpha = 0.3
    }
    
    let mainView = UIView().then{
        $0.backgroundColor = Color(0xffffff)
        $0.layer.cornerRadius = fit(8)
    }
    
    let deleteBtn = UIButton().then{
        $0.setImage(UIImage(named: "back_white"), for: .normal)
    }
    
    let notice = UILabel().then{
        $0.font = Font(36)
        $0.textColor = Color(0x2a3457)
        $0.text = "请输入支付密码"
    }
    
    
    let payLine = UIView().then{
        $0.backgroundColor = Color(0xd2d2d2)
    }
    
    let  pikerTextField = UITextField()
    
    let couponView = GetCouponView()
    

    //---------------------------------------------------------------------------//
    
    let shopImage = UIImageView().then{
        $0.layer.cornerRadius = fit(8)
        $0.layer.masksToBounds = true
    }
    
    let shopName = UILabel().then{
        $0.text = "假日酒店"
        $0.textColor = Color(0x2a3457)
        $0.font = BoldFont(40)
    }

    let payLable = UILabel().then{
        $0.text = "付款金额"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    
    let ￥ = UILabel().then{
        $0.text = "￥"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(60)
    }
    
    
    let moneyField = UITextField().then{
        $0.placeholder = "请输入金额"
        $0.font = Font(60)
        $0.textColor = Color(0x2a3457)
        $0.borderStyle = .none
        $0.keyboardToolbar.isHidden = true
        $0.keyboardType = .decimalPad
    }

    let line = UIView().then{
        $0.backgroundColor = Color(0xdcdcdc)
    }
    
    //** 优惠券 **/
    let discountLable = UILabel().then{
        $0.text = "折扣"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    
    let discountNum  = UILabel().then{
        $0.text = "9.8折"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }
    
    let couponLable = UILabel().then{
        $0.text = "优惠券"
        $0.textColor = Color(0x2a3457)
        $0.font = Font(30)
    }

    let couponButton = UIButton().then{
        $0.titleLabel?.font = Font(30)
        $0.setTitle("暂无可用", for: .normal)
        $0.setTitleColor(Color(0x2a3457), for: .normal)
    }
    
    
    let bottonView = UIView().then{
        $0.backgroundColor = ColorRGB(red: 49.0, green: 49.0, blue: 49.0)
    }
    
    let realPayButton = UIButton().then{
        $0.backgroundColor = Color(0x58c1e3)
        $0.setTitleColor(Color(0xffffff), for: .normal)
        $0.setTitle("确认支付", for: .normal)
        $0.titleLabel?.font = Font(40)
    }
    
    let realNum = UILabel().then{
        $0.text = "￥0.00"
        $0.textColor = Color(0xffffff)
        $0.font = BoldFont(45)
    }
    
    let discountDes = UILabel().then{
        $0.text = "|  已优惠0.00"
        $0.textColor = ColorRGB(red: 111.0 , green: 111.0  , blue: 111.0)
        $0.font = Font(26)
    }
    
    
    /**-------------------领劵----------------**/
    
    /**------------------------------------**/

    
    override func bindEvent() {
        realPayButton.addTarget(self, action: #selector(doneAction), for: .touchUpInside)
        deleteBtn.addTarget(self, action: #selector(deleteBack), for: .touchUpInside)

    }
    
    @objc func doneAction() {
        
        if moneyField.text! == "" {
            SZHUD("请输入支付金额", type: .info, callBack: nil)
            return
        }
        
        setPasswordView()
//        self.navigationController?.popToRootViewController(animated: true)
    
    }
    
    func setPasswordView(){
        self.view.addSubview(mask)
        mask.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        
        self.view.addSubview(mainView)
        
        mainView.addSubviews(views: [deleteBtn,notice,payLine,passwordView])
        
        passwordView.delegate = self
        passwordView.textField.becomeFirstResponder()
        
        
        mainView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.snEqualTo(343)
            make.bottom.equalToSuperview().offset(-(216 + LL_keyboard))
        }
        
        deleteBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(47)
            make.top.equalToSuperview().snOffset(40)
            make.width.snEqualTo(40)
            make.height.snEqualTo(40)
        }
        notice.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(deleteBtn.snp.centerY)
        }
        
        payLine.snp.makeConstraints { (make) in
            make.left.equalTo(mainView.snp.left)
            make.right.equalTo(mainView.snp.right)
            make.height.snEqualTo(1)
            make.top.equalTo(notice.snp.bottom).snOffset(40)
        }

        passwordView.snp.makeConstraints { (make) in
            make.width.snEqualTo(547)
            make.height.snEqualTo(88)
            make.top.equalTo(payLine.snp.bottom).snOffset(35)
            make.centerX.equalToSuperview()

        }
        
    }
    
    
    @objc func deleteBack(){
        passwordView.textField.resignFirstResponder()
        passwordView.textFieldText = ""
        passwordView.textField.text = ""
        passwordView.view1.isHidden = true
        passwordView.view2.isHidden = true
        passwordView.view3.isHidden = true
        passwordView.view4.isHidden = true
        passwordView.view5.isHidden = true
        passwordView.view6.isHidden = true
        mainView.removeFromSuperview()
        mask.removeFromSuperview()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.moneyField.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IQKeyboardManager.shared().isEnabled = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        IQKeyboardManager.shared().isEnabled = true
    }
    
    @objc func showCouponPiker(){
        self.pikerTextField.inputView = self.couponPiker
        self.pikerTextField.becomeFirstResponder()
        couponPiker.selectValue = {[unowned self] (name,id) in
            self.coupon_id = id
            self.coupon_name = name
            self.couponButton.setTitle(name, for: .normal)
            self.isSelected = true

        }
    }
    
    @objc func getCoupon(){
        self.view.addSubview(couponView)
        couponView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.snEqualTo(400)
        }
        
        couponView.tapBlock = {[unowned self] in
           self.getCouponAction()
        }
        couponView.closeBlock = {[unowned self] in
            self.couponView.removeFromSuperview()
        }
   
    }
    
    
     func getCouponAction() {
        SZHUD("请求中...", type: .loading, callBack: nil)

        let url = httpUrl + "/main/getcoupon"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                self.couponView.removeFromSuperview()
                
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)

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
    
    func getCoinNum(_ str:String){
        
        let discount = Float(self.discount!)!
        let payTotal =  Float(str)! * discount
        let discountNum = Float(str)! - payTotal
        
        if Float(str)! >= 100.0 {
            if  !self.userCoupon.isEmpty {
                if self.isSelected {
                }else{
                    self.couponButton.setTitle("选择代金券", for: .normal)
                    self.couponButton.setTitleColor(Color(0x3660fb), for: .normal)
                    self.couponButton.isEnabled = true
                    self.couponButton.addTarget(self, action: #selector(showCouponPiker), for: .touchUpInside)
                }
            }else{
                self.couponButton.setTitle("领取代金券", for: .normal)
                self.couponButton.setTitleColor(Color(0x3660fb), for: .normal)
                self.couponButton.isEnabled = true
                self.couponButton.addTarget(self, action: #selector(getCoupon), for: .touchUpInside)
            }
            
        }else{
            if self.isSelected {
                self.couponButton.setTitle(self.coupon_name, for: .normal)
            }else{
                self.couponButton.setTitleColor(Color(0x2a3457), for: .normal)
                self.couponButton.setTitle("暂无可用", for: .normal)
                self.couponButton.isEnabled = false
            }
        }
        
        
        self.realNum.text  = "￥" +  String(format: "%.2f", payTotal)
        self.discountDes.text = "|  已优惠 ￥\(String(format: "%.2f",discountNum))"
    }
    
    
    override func loadData() {
        let url = httpUrl + "/main/getpaymentdetail"
        let para:[String:String] = ["shop_id":shop_id!]
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                //登录成功数据解析
                
                DispatchQueue.main.async {
                    //装数据
                    let imgUrl = httpUrl + jsonData["data"]["shopdetail"]["main_img"].stringValue
                    self.shopImage.kf.setImage(with: URL(string:imgUrl))
                    self.discount  = jsonData["data"]["shopdetail"]["user_discount"].stringValue
                    self.discountNum.text =  String(format: "%.1f", Float(self.discount!)! * 10) + "折"
                    self.shop_name = jsonData["data"]["shopdetail"]["shop_name"].stringValue
                    self.shop_img =  httpUrl + jsonData["data"]["shopdetail"]["main_img"].stringValue
                    
                    
                    self.userCoupon = jsonData["data"]["usercoupon"].arrayValue.compactMap { UserCouponModel(jsonData: $0) }

                    self.coupon = CouponModel(jsonData:jsonData["data"]["usercoupon"])
                    
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
    

    
    func payAction(_ pay_pwd:String){
        
        let url = httpUrl + "/main/payAction"
        let para:[String:String] = ["shop_id":shop_id!,"num":self.moneyField.text!,"pay_pwd":pay_pwd]
        CNLog(para)
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                let vc = PaySuccessController()
                vc.shop_img = self.shop_img!
                
                vc.shop_name = self.shop_name!
                vc.pay_num = self.moneyField.text ?? "0"
                
                self.navigationController?.pushViewController(vc, animated: true)
                SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)

                for i in 0..<(self.navigationController?.viewControllers.count)! {
                    if self.navigationController?.viewControllers[i].isKind(of: HomePageController.self) == true {
                        _ = self.navigationController?.popToViewController(self.navigationController?.viewControllers[i] as! HomePageController, animated: true)
                        break
                    }
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
    

    
    override func setupView() {
        self.title = "付款"
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.addSubviews(views: [shopImage,shopName,payLable,￥,moneyField,discountLable,discountNum,couponLable,couponButton,line,bottonView,pikerTextField])
        
        bottonView.addSubviews(views: [realPayButton,realNum,discountDes])
        
        moneyField.delegate = self

        shopImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().snOffset(100)
            make.width.height.snEqualTo(200)
        }
        
        shopName.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(shopImage.snp.bottom).snOffset(25)
        }
        
        payLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(shopName.snp.bottom).snOffset(65)
        }
        
        
        ￥.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(payLable.snp.bottom).snOffset(47)
            make.width.snEqualTo(60)
        }
        
        moneyField.snp.makeConstraints { (make) in
            make.left.equalTo(￥.snp.right).snOffset(10)
            make.top.equalTo(payLable.snp.bottom).snOffset(47)
            make.right.equalToSuperview().snOffset(-48)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(49)
            make.right.equalToSuperview().snOffset(71)
            make.top.equalTo(moneyField.snp.bottom).snOffset(24)
            make.height.snEqualTo(1)
        }
    
        discountLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(line.snp.bottom).snOffset(30)
        }
        
        discountNum.snp.makeConstraints { (make) in
            make.right.equalToSuperview().snOffset(-60)
            make.centerY.equalTo(discountLable.snp.centerY)
        }
        
        couponLable.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(48)
            make.top.equalTo(discountLable.snp.bottom).snOffset(50)
        }
        
        couponButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(couponLable.snp.centerY)
            make.right.equalToSuperview().snOffset(-48)
            make.height.snEqualTo(50)
            make.width.snEqualTo(180)
        }
        
        bottonView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-LL_TabbarSafeBottomMargin)
            make.height.snEqualTo(120)
        }
        
        realNum.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(30)
            make.centerY.equalToSuperview()
        }
        
        discountDes.snp.makeConstraints { (make) in
            make.left.equalTo(realNum.snp.right).snOffset(20)
            make.centerY.equalTo(realNum.snp.centerY)
        }
        
        realPayButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalToSuperview()
            make.width.snEqualTo(250)
        }
    }
}
extension ScanPayController:PassWordFieldDelegate{
    func inputTradePasswordFinish(tradePasswordView: PassWordField, password: String) {
        
        CNLog(password)
        payAction(password)
        
    }
    
}
extension ScanPayController:UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let fullStr = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        CNLog(fullStr)
        
        if fullStr.count > 0 {
            getCoinNum(fullStr)
        }else{
            self.moneyField.text = ""
            self.moneyField.resignFirstResponder()
            self.realNum.text  = "0.00"
            self.discountDes.text = "|  已优惠 ￥0.00"
        }
        return true
    }
}
