//
//  ViewController.swift
//  SwiftCollectionView
//
//  Created by 栗子 on 2017/8/22.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher


class FindViewController: UIViewController{
    var images:[UIImage] = []
    var hratio:[Float] = []
    var collectionView:UICollectionView!
    
    var model:[FindModel] = []
    let layout = FindLayout()

    //MARK: --life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        automaticallyAdjustsScrollViewInsets = false
        self.view.backgroundColor = Color(0xf5f5f5)
        
        style.scaleTitle = true
        style.scrollTitle = true
        style.showLine = true
        style.scrollLineColor = Color(0x3660fb)
        let topView = ScrollSegmentView(frame: CGRect(x: 0, y:0, width: self.view.frame.width, height: fit(100)), segmentStyle: style, titles: ["精选","网红打卡","旅行","酒店","美食","电影"])
        self.view.addSubview(topView)
        
        
        topView.clickEvent = {[unowned self] (para) in
            self.loadData(String(para))
        }
        
        self.setUpView()
        
        self.loadData("0")

        
    }
    var style = SegmentStyle()


    func loadData(_ cat:String){
        
        SZHUD("加载数据中...", type: .loading, callBack: nil)
        
        let url = httpUrl + "/common/getdiscoverlist"
        
        let para:[String:String] = ["catId":cat]
        
        Alamofire.request(url, method: .post, parameters:para, headers:nil).responseJSON {[unowned self] (res) in
            let jsonData = JSON(data: res.data!)
            self.model.removeAll()
            self.hratio.removeAll()
            CNLog(jsonData)
            if  jsonData["code"].intValue == 1000{
                
                self.model = jsonData["data"].arrayValue.compactMap { FindModel(jsonData: $0) }
                CNLog(self.model.count)
                if !self.model.isEmpty {
                    for item in self.model{
                        self.hratio.append(item.hratio)
                    }
                }
                
                DispatchQueue.main.async {
                    
                    self.layout.setSize = {
                        return self.hratio
                    }
                    self.collectionView.reloadData()
//                    self.setUpView()
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    
    private func setUpView() {
    
        
        collectionView = UICollectionView(frame:CGRect(x: 0, y: fit(100), width: ScreenW, height: ScreenH - fit(360) - LL_TabbarSafeBottomMargin), collectionViewLayout:layout)
        collectionView.register(FindCell.self, forCellWithReuseIdentifier: "newCell")
        collectionView.backgroundColor = Color(0xf5f5f5)
        collectionView.alwaysBounceVertical = true
        
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
    }
}

extension FindViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    //MARK: --UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.model.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as! FindCell
        cell.model = self.model[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = FindWebController()
        vc.para = self.model[indexPath.row].id
        vc.title = self.model[indexPath.row].title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
