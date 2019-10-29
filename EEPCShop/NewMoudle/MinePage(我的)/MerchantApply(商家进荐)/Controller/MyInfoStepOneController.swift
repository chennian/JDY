//
//  MyInfoController.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import Alamofire
import SwiftyJSON

class MyInfoStepOneController: SNBaseViewController {
    var model = UserAuthModel()
    
    fileprivate var cell:MyInfoStepOneCell = MyInfoStepOneCell()

    fileprivate let catPiker = CustomPiker.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216),type:.shopCat)
    fileprivate let discountPiker  = CustomPiker.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216),type:.shopDiscount)
    fileprivate let addressPiker   = AddressPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
    fileprivate let rmdTypePiker   = CustomPiker.init(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216),type:.rmdType)


    var tag:Int?
    var croppingStyle:TOCropViewCroppingStyle?
    
    
    var main_img:String = ""
    var license_img:String = ""

    var cat_id:String = ""
    var discount_id:String = ""
    var cmd_type:String = ""
    
    fileprivate var province:String = ""
    fileprivate var city:String = ""
    fileprivate var area:String = ""
    
    let searcher = BMKGeoCodeSearch()
    let searcherOption = BMKGeoCodeSearchOption()
    var location:CLLocationCoordinate2D?

    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(MyInfoStepOneCell.self)
        $0.register(TopGuideCell.self)
        $0.separatorStyle = .none
    }

    
    override func setupView() {
        
        self.receiveNotify()
        
        self.title = "申请商家"
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(tableView)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    //接受通知
    func receiveNotify(){
        let notify = NSNotification.Name(rawValue:"shopAddress")
        NotificationCenter.default.addObserver(self, selector: #selector(getShopAddress(notify:)), name: notify, object: nil)
    }
    @objc func getShopAddress(notify: NSNotification) {
        guard let text: String = notify.object as! String? else { return }
        self.cell.location.textfield.text = text
        
        //地理编码
        geoCode(text)
        
    }
    func geoCode(_ address:String){
        searcher.delegate = self
        searcherOption.address = address
        searcherOption.city = XKeyChain.get(CITY)
        let flag: Bool = searcher.geoCode(searcherOption)
        if flag {
            print("geo检索发送成功")
        } else {
            print("geo检索发送失败")
        }
    }
    deinit {
        //移除通知
        NotificationCenter.default.removeObserver(self)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        //定位
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func check(){
//        if cell.parentPhone.textfield.text! == "" {
//            SZHUD("请填写姓名", type: .info, callBack: nil)
//            return
//        }
        
        
        if  cell.parentPhone.textfield.text != ""{
            if cell.selectType.textfield.text == ""{
                SZHUD("请填写进驻邀请人类型", type: .info, callBack: nil)
                return
            }
        }
        
        if  cell.selectType.textfield.text! != ""{
            if cell.parentPhone.textfield.text == ""{
                SZHUD("请填写进驻邀请人手机号", type: .info, callBack: nil)
                return
            }
        }
        
        if cell.shop_name.textfield.text! == "" {
            SZHUD("请填写店铺名称", type: .info, callBack: nil)
            return
        }
//        if cell.license_no.textfield.text! == "" {
//            SZHUD("请填写营业执照号码", type: .info, callBack: nil)
//            return
//        }
        if cell.address.textfield.text! == "" {
            SZHUD("请填写详细地址", type: .info, callBack: nil)
            return
        }
        if cell.addressDetail.textfield.text! == "" {
            SZHUD("请填写详细地址", type: .info, callBack: nil)
            return
        }
//        if cell.legal_person.textfield.text! == "" {
//            SZHUD("请填写法人姓名", type: .info, callBack: nil)
//            return
//        }
        
//        if cell.legal_id.textfield.text! == "" {
//            SZHUD("请填写法人身份证ID", type: .info, callBack: nil)
//            return
//        }
//
        if cell.cat.textfield.text! == "" {
            SZHUD("请填写商家分类", type: .info, callBack: nil)
            return
        }
        
        if cell.discount.textfield.text! == "" {
            SZHUD("请填写商家折扣", type: .info, callBack: nil)
            return
        }
        
        if (self.location == nil) {
            SZHUD("请定位商家", type: .info, callBack: nil)
            return
        }
        
        
        if self.main_img  == "" {
            SZHUD("请上传商家图片", type: .info, callBack: nil)
            return
        }
        
        
        let longidute = self.location?.longitude
        let latitude  = self.location?.latitude
        
        model.longiduteKey = "\(longidute ?? 0.0)"
        model.latitudeKey  = "\(latitude ?? 0.0)"
        
        var  url:String = ""
        if XKeyChain.get(ISSHOP) == "0"{
             url = httpUrl + "/member/applyShop/1"
        }else{
             url = httpUrl + "/member/applyShop/0"
        }
        let para:[String:String] = ["parent_name":cell.parentPhone.textfield.text!,
                                    "rcm_type":self.cmd_type,
                                    "shop_name":cell.shop_name.textfield.text!,
                                    "license_no":cell.license_no.textfield.text!,
                                    "province":self.province,
                                    "city":self.city,
                                    "area":self.area,
                                    "address_detail":cell.addressDetail.textfield.text!,
                                    "legal_person":cell.legal_person.textfield.text!,
                                    "legal_id":cell.legal_id.textfield.text!,
                                    "categroy_id":self.cat_id,
                                    "discount_id":self.discount_id,
                                    "lng": "\(self.location?.longitude ?? 0.0)",
                                    "lat":"\(self.location?.latitude ?? 0.0)",
                                    "main_img":main_img,
                                    "license_img":license_img]
        
        
        SZHUD("上传中.." , type: .loading, callBack: nil)
        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                SZHUD(jsonData["msg"].stringValue , type: .success, callBack: nil)
                self.navigationController?.popViewController(animated: true)
                
            }else{
                if !jsonData["msg"].stringValue.isEmpty{
                    SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                }else{
                    SZHUD("请求错误" , type: .error, callBack: nil)
                }
            }
            
        }
    }
    fileprivate func pikerView(){
        
        let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle:.actionSheet)
        let defaultAction = UIAlertAction.init(title: "相册", style: .default, handler: { (UIAlertAction) in
            self.croppingStyle = .default
            let standardPicker = UIImagePickerController.init()
            standardPicker.sourceType = .photoLibrary
            standardPicker.allowsEditing = false
            standardPicker.delegate = self
            self.present(standardPicker, animated: true, completion: nil)
        })
        
        
        let profileAction = UIAlertAction.init(title: "相机", style: .default, handler: { (UIAlertAction) in
            self.croppingStyle = .default
            let profilePicker = UIImagePickerController.init()
            profilePicker.sourceType = .camera
            profilePicker.allowsEditing = false
            profilePicker.delegate = self
            self.present(profilePicker, animated: true, completion: nil)
        })
        
        let acancel = UIAlertAction.init(title: "取消", style: .cancel, handler: nil)
        
        alertController.addAction(defaultAction)
        alertController.addAction(profileAction)
        alertController.addAction(acancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
extension MyInfoStepOneController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
            let cell:MyInfoStepOneCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
            self.cell = cell
            cell.selectType.textfield.inputView = self.rmdTypePiker
            rmdTypePiker.selectValue = { [unowned self] (name,id) in
                cell.selectType.textfield.text = name
                self.cmd_type = id
            }
            
            cell.cat.textfield.inputView = self.catPiker
            catPiker.selectValue = {[unowned self] (name,id) in
                cell.cat.textfield.text = name
                self.cat_id = id
            }
            cell.discount.textfield.inputView = self.discountPiker
            discountPiker.selectValue = {[unowned self] (name,id) in
                cell.discount.textfield.text = name
                self.discount_id = id
            }
            
            cell.address.textfield.inputView = self.addressPiker
            addressPiker.selectValue = {[unowned self] (province,city,county) in
                cell.address.textfield.text = province + city + county
                self.province = province
                self.city = city
                self.area = county
            }
            
            cell.clickBtnEvent = { [unowned self] in
                self.check()
            }
            
            cell.location.clickEvent = { [unowned self] in
                if  CLLocationManager.authorizationStatus() == CLAuthorizationStatus.denied{
                    SZHUD("请开启定位", type: .info, callBack: nil)
                }else{
                    self.navigationController?.pushViewController(BMKGeoCodeSearchPage(), animated: true)
                }
            }
            
            cell.clickEvent = {[unowned self] (para)in
                self.tag = para
                switch para {
                case 1,2:
                    self.pikerView()
                default:
                    return
                }
            }
            
            return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
        return fit(2170)
    }
}
extension MyInfoStepOneController:BMKGeoCodeSearchDelegate{
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeSearchResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            self.location = result.location
        }else{
            CNLog("未找到结果")
        }
    }
}
extension MyInfoStepOneController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage]
        let cropVC = TOCropViewController(croppingStyle: .default, image: img as! UIImage)
        if self.tag == 1{
            cropVC.customAspectRatio = CGSize(width:fit(400),height:fit(400))
        }
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}


extension  MyInfoStepOneController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传图片中", type:.loading, callBack: nil)
        cropViewController.dismiss(animated: true) {
            let imageData =  image.compressImage(image: image)!
            let base64 = imageData.base64EncodedString()
            
            SZHUD("上传成功" , type: .success, callBack: nil)
            
            switch weakself.tag {
            case 1:
                self.main_img = base64
                DispatchQueue.main.async {
                    self.cell.main_img.imageView.setImage(UIImage(data: imageData), for: .normal)
                }
            case 2:
                self.license_img = base64
                DispatchQueue.main.async {
                    self.cell.license_img.imageView.setImage(UIImage(data: imageData), for: .normal)
                }

            default:
                return
            }
            
        }
    }
}



