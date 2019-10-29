//
//  UpdateApplyController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import Alamofire
import SwiftyJSON

class UpdateApplyController: SNBaseViewController {
    var model:ShopMsgModel?
    
    fileprivate var cell:UpdateApplyCell = UpdateApplyCell()
    
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
    
    fileprivate var lng:String = ""
    fileprivate var lat:String = ""

    
    let searcher = BMKGeoCodeSearch()
    let searcherOption = BMKGeoCodeSearchOption()
    var location:CLLocationCoordinate2D?
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(UpdateApplyCell.self)
        $0.separatorStyle = .none
    }
    
    
    override func setupView() {
        loadShopData()
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
    
    func loadShopData() {
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                self.model = ShopMsgModel.init(jsonData: jsonData["data"])
                
                if let m = self.model{
                    self.main_img = m.main_img
                    self.license_img = m.license_img
                    
                    self.cat_id = m.cat
                    self.discount_id = m.discount_id
                
                    self.province = m.province
                    self.city = m.city
                    
                    self.lat = m.lat
                    self.lng = m.lng
                    
                }
            
                DispatchQueue.main.async {
                    self.tableView.reloadData()
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
    
    func check(){
        //        if cell.parentPhone.textfield.text! == "" {
        //            SZHUD("请填写姓名", type: .info, callBack: nil)
        //            return
        //        }
        
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
//
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
        
        
    
        if  XKeyChain.get(ISSHOP) == "4" {
            if (self.location == nil) {
                SZHUD("请定位商家", type: .info, callBack: nil)
                return
            }
        }
        
         if self.main_img == "" {
             SZHUD("请上传商家图片", type: .info, callBack: nil)
             return
         }
         

        let  url = httpUrl + "/member/applyShop/0"
        let para:[String:String] = ["license_no":cell.license_no.textfield.text!,
                                    "province":self.province,
                                    "city":self.city,
                                    "area":self.area,
                                    "address_detail":cell.addressDetail.textfield.text!,
                                    "legal_person":cell.legal_person.textfield.text!,
                                    "legal_id":cell.legal_id.textfield.text!,
                                    "categroy_id":self.cat_id,
                                    "discount_id":self.discount_id,
                                    "lng": self.lng,
                                    "lat":self.lat,
                                    "main_img":main_img,
                                    "license_img":license_img]
        
        CNLog(para)
        
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
extension UpdateApplyController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UpdateApplyCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.cell = cell
        cell.model = self.model
 
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
        return fit(1870)
    }
}
extension UpdateApplyController:BMKGeoCodeSearchDelegate{
    func onGetGeoCodeResult(_ searcher: BMKGeoCodeSearch!, result: BMKGeoCodeSearchResult!, errorCode error: BMKSearchErrorCode) {
        if error == BMK_SEARCH_NO_ERROR {
            self.location = result.location
            
            self.lng =  "\(self.location?.longitude ?? 0.0)"
            self.lat =    "\(self.location?.latitude ?? 0.0)"

        }else{
            self.lng =   "0.0"
            self.lat =   "0.0"
        }
    }
}
extension UpdateApplyController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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


extension  UpdateApplyController: TOCropViewControllerDelegate{
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



