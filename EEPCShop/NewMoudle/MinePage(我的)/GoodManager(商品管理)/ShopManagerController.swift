//
//  ShopManagerController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/8/30.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import DZNEmptyDataSet
import Alamofire
import SwiftyJSON
import TOCropViewController
import Kingfisher


class ShopManagerController: SNBaseViewController {
    
    var croppingStyle:TOCropViewCroppingStyle?
    
    var detail_img:String?
    var main_img:String?
    
    var tag:Int?

    fileprivate var cell:ShopManagerCell = ShopManagerCell()
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(ShopManagerCell.self)
        $0.separatorStyle = .none
    }
    
     func loadDataInfo() {
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                if jsonData["data"]["detail_img"].stringValue == ""{
                    self.cell.shopDetailImage.setImage(UIImage(named: "picture"), for: .normal)
                }else{
                    CNLog(httpUrl + jsonData["data"]["detail_img"].stringValue)
                    self.cell.shopDetailImage.kf.setImage(with: URL(string: httpUrl + jsonData["data"]["detail_img"].stringValue ), for: .normal)
                }
                
                self.cell.shopMainImage.kf.setImage(with: URL(string: httpUrl + jsonData["data"]["main_img"].stringValue ), for: .normal)

                
                self.cell.shopLableField.text = jsonData["data"]["lable"].stringValue
                self.cell.shopDesText.text = jsonData["data"]["description"].stringValue
                self.cell.shopPhoneField.text = jsonData["data"]["phone"].stringValue
                
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
    
    func upload(){
    
        
        if self.cell.shopPhoneField.text! == ""{
            SZHUD("请输入商家电话", type: .info, callBack: nil)
            return
        }
        
        if self.cell.shopLableField.text! == ""{
            SZHUD("请输入商家标签", type: .info, callBack: nil)
            return
        }
        
        if self.cell.shopDesText.text! == ""{
            SZHUD("请输入商家描述", type: .info, callBack: nil)
            return
        }
        
        guard let main_img = self.main_img  else {
            SZHUD("请上传商家主图", type: .info, callBack: nil)
            return
        }
        
        guard let detail_img = self.detail_img  else {
            SZHUD("请上传商家详情照片", type: .info, callBack: nil)
            return
        }
        
        
        let url = httpUrl + "/main/sumbitInfo2"
        let para:[String:String] = ["main_img":main_img,
                                    "detail_img":detail_img,
                                    "lable":self.cell.shopLableField.text!,
                                    "des":self.cell.shopDesText.text!,
                                    "phone":self.cell.shopPhoneField.text!]
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                SZHUD("上传成功" , type: .success, callBack: nil)
                self.navigationController?.popViewController(animated: false)
                
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
    
    
     func pikerView(){
        
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
    
    override func setupView() {
        
        self.loadDataInfo()
        
        self.title = "店铺管理"
        
        self.view.backgroundColor = Color(0xffffff)
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        tableView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
        
    }
    
}

extension ShopManagerController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:ShopManagerCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.cell = cell
        cell.clickEvent = {[unowned self] (para)in
            self.tag = para
            switch para {
            case 10,20:
                self.pikerView()
            case 30:
                self.upload()
            default:
                return
            }
        }
        
        
        return cell
        
    
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(1500);
    }
}
extension ShopManagerController:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty");
    }
}
extension ShopManagerController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let img = info[UIImagePickerController.InfoKey.originalImage]
        let cropVC = TOCropViewController(croppingStyle: .default, image: img as! UIImage)
        //        cropVC.customAspectRatio = CGSize(width:fit(483),height:fit(260))
        cropVC.delegate = self
        picker.dismiss(animated: true) {
            self.present(cropVC, animated: true, completion: nil)
        }
    }
}

extension  ShopManagerController: TOCropViewControllerDelegate{
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: true) {
            SZHUD("上传图片中", type:.loading, callBack: nil)
            let imageData =  image.compressImage(image: image)!
            let base64 = imageData.base64EncodedString()
            
 
            switch weakself.tag {
            case 10:
                self.main_img = base64
                DispatchQueue.main.async {
                    self.cell.shopMainImage.setImage(UIImage(data: imageData), for: .normal)
                    SZHUD("上传成功" , type: .success, callBack: nil)

                }
            case 20:
                self.detail_img = base64
                DispatchQueue.main.async {
                    self.cell.shopDetailImage.setImage(UIImage(data: imageData), for: .normal)
                    SZHUD("上传成功" , type: .success, callBack: nil)
                }
                
            default:
                return
            }
            
        }
    }
}



