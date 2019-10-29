//
//  MyInfoEditController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import TOCropViewController


class MyInfoEditController: SNBaseViewController {
    
    fileprivate var cell:InfoEditCell = InfoEditCell()

    var croppingStyle:TOCropViewCroppingStyle?

    var cellType :[WalletInfoType] = []
    
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = Color(0xf5f5f5)
        $0.register(InfoEditCell.self)

        $0.separatorStyle = .none
    }
    override func loadData() {
        
    }
    
    
    override func setupView() {
        self.title = "编辑资料"
        
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

extension MyInfoEditController:UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell:InfoEditCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.cell = cell
        cell.clickEvent = {[unowned self] in
            self.pikerView()
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(700)

    }
}
extension MyInfoEditController : UIImagePickerControllerDelegate,UINavigationControllerDelegate{
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

extension  MyInfoEditController: TOCropViewControllerDelegate{
    
    func cropViewController(_ cropViewController: TOCropViewController, didCropTo image: UIImage, with cropRect: CGRect, angle: Int) {
        unowned let weakself = self
        
        cropViewController.dismiss(animated: true) {
            DispatchQueue.main.async {
                weakself.cell.imageImageView.setImage(image, for: .normal)
            }
        }
    }
    func uploadImg(_ url:String,_ image:UIImage,_ tag:Int,_ name:String){
        
    }
}



