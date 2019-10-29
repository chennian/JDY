//
//  MyInfoStepTwoController.swift
//  seven
//
//  Created by Mac Pro on 2018/12/17.
//  Copyright © 2018年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController
import Alamofire
import SwiftyJSON


class MyInfoStepTwoController: SNBaseViewController {
    
    var model:ShopMsgModel?
    fileprivate var cell:MyInfoStepTwoCell = MyInfoStepTwoCell()
    
    fileprivate let addressPiker = AddressPiker(frame: CGRect(x: 0, y: 0, width: ScreenW, height: 216))
    fileprivate var bank_province:String = ""
    fileprivate var bank_city:String = ""
    var tag:Int?
    var croppingStyle:TOCropViewCroppingStyle?

    
    var apliy_receiev_code:String = ""
    var wexin_receive_code:String = ""
    var ID_front:String = ""
    var ID_back:String  = ""
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(MyInfoStepTwoCell.self)
        $0.register(TopGuideCell.self)
        $0.separatorStyle = .none
    }
    
    override func setupView() {
        loadShopData()
        self.title = "银行卡信息"
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
    func loadShopData() {
        let url = httpUrl + "/main/shopMsg"
        Alamofire.request(url, method: .post, parameters:nil, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                self.model = ShopMsgModel.init(jsonData: jsonData["data"])
                
                if let m = self.model {
                    self.bank_province = m.bank_province
                    self.bank_city = m.bank_city
                    
                    self.apliy_receiev_code = m.apliy_receiev_code
                    self.wexin_receive_code = m.wexin_receive_code
                    self.ID_front = m.legal_id_front
                    self.ID_back = m.legal_id_back
                    
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
        if cell.pay_pwd.textfield.text! == "" {
            SZHUD("请输入支付密码", type: .info, callBack: nil)
            return
        }
        
        if cell.pay_pwd.textfield.text?.count != 6 {
            SZHUD("支付密码必须为6位数", type: .info, callBack: nil)
            return
        }
    
        let url = httpUrl + "/member/applyFinance/1"

        let para:[String:String] = [
                                    "bank_no":cell.bank_no.textfield.text!,
                                    "bank_name":cell.bank_name.textfield.text!,
                                    "bank_type":cell.bank_type.textfield.text!,
                                    "bank_branch":cell.bank_branch.textfield.text! ,
                                    
                                    "open_bank_no":cell.open_bank_no.textfield.text!,
                                    "open_bank_name":cell.open_bank_name.textfield.text!,
                                    "open_bank_type":cell.open_bank_type.textfield.text!,
                                    "open_bank_branch":cell.open_bank_branch.textfield.text!,
                                    
                                    "bank_province":self.bank_province,
                                    "bank_city":self.bank_city,
                                    "apliy_receiev_code":self.apliy_receiev_code,
                                    "wexin_receive_code":self.wexin_receive_code,
                                    "legal_id_front":self.ID_front,
                                    "legal_id_back":self.ID_back,
                                    "pay_pwd":cell.pay_pwd.textfield.text!]
        
        SZHUD("上传中.." , type: .loading, callBack: nil)
        
        Alamofire.request(url, method: .post, parameters:para, headers:["X-AUTH-TOKEN":XKeyChain.get(TOKEN)] ).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            if  jsonData["code"].intValue == 1000{
                self.navigationController?.popViewController(animated: true)
                SZHUD("提交成功" , type: .success, callBack: nil)

            }else{
                if !jsonData["msg"].stringValue.isEmpty{
                    SZHUD(jsonData["msg"].stringValue , type: .info, callBack: nil)
                }else{
                    SZHUD("请求错误" , type: .error, callBack: nil)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
extension MyInfoStepTwoController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MyInfoStepTwoCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.cell = cell
        cell.model = self.model
        
        cell.bank_address.textfield.inputView = self.addressPiker
        addressPiker.selectValue = {[unowned self] (province,city,county) in
            cell.bank_address.textfield.text = province + city
            self.bank_province = province
            self.bank_city = city
        }
        cell.clickBtnEvent = {[unowned self] (para)in
            self.tag = para
            CNLog(para)
            switch para {
            case 10,20,30,40:
                self.pikerView()
            default:
                self.check()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
       return fit(2980)
    }
}
extension MyInfoStepTwoController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

extension  MyInfoStepTwoController: TOCropViewControllerDelegate{
    
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        SZHUD("上传中...", type:.loading, callBack: nil)

        cropViewController.dismiss(animated: true) {


            let imageData =  image.compressImage(image: image)!
            let base64 = imageData.base64EncodedString()
            
            switch weakself.tag {
            case 10:
                self.apliy_receiev_code = base64
                DispatchQueue.main.async {
                    self.cell.apliy_receiev_code.imageView.setImage(UIImage(data: imageData), for: .normal)
                }
                SZHUD("上传成功" , type: .success, callBack: nil)

            case 20:
                self.wexin_receive_code = base64
                DispatchQueue.main.async {
                    self.cell.wexin_receive_code.imageView.setImage(UIImage(data: imageData), for: .normal)
                }
                SZHUD("上传成功" , type: .success, callBack: nil)
            case 30:
                self.ID_front = base64
                DispatchQueue.main.async {
                    self.cell.ID_front.imageView.setImage(UIImage(data: imageData), for: .normal)
                }
                SZHUD("上传成功" , type: .success, callBack: nil)
            case 40:
                self.ID_back = base64
                DispatchQueue.main.async {
                    self.cell.ID_back.imageView.setImage(UIImage(data: imageData), for: .normal)
                }
                SZHUD("上传成功" , type: .success, callBack: nil)

            default:
                return
            }
            
        }
    }

    
    func uploadImg(_ url:String,_ image:UIImage,_ tag:Int,_ name:String){
        
        
        //        let imageData =  image.compressImage(image: image)!
        
        
        switch tag {
        case 10:
            DispatchQueue.main.async {
                self.cell.apliy_receiev_code.imageView.setImage(image, for: .normal)
            }
        case 20:
            DispatchQueue.main.async {
                self.cell.wexin_receive_code.imageView.setImage(image, for: .normal)
            }
        case 30:
            DispatchQueue.main.async {
                self.cell.ID_front.imageView.setImage(image, for: .normal)
            }
        case 40:
            DispatchQueue.main.async {
                self.cell.ID_back.imageView.setImage(image, for: .normal)
            }
       
        default:
            return
        }
        
    }
}



