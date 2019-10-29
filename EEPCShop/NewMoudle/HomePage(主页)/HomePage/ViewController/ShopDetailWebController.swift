//
//  ShopDetailWebController.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/9/17.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import WebKit
import MapKit

class ShopDetailWebController: SNBaseViewController {
    
    var urlString:String = ""
    var addressDetail:String = ""
    
    let web = WKWebView().then{
        $0.backgroundColor = .clear
    }

    override func setupView() {
        
        self.view.addSubview(web)
        web.navigationDelegate = self
        
        web.snp.makeConstraints { (make) in
            make.left.top.right.bottom.equalToSuperview()
        }
        web.load(URLRequest(url:URL(string: urlString)!))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    

}

extension ShopDetailWebController:WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url
        let urlString:String = (url?.absoluteString)!
        
        if urlString.contains("scheme://close"){
            self.navigationController?.popViewController(animated: false)
        }
        
        if urlString.contains("scheme://nav"){
            
            self.jumpToMapClicked(Double(XKeyChain.get(latitudeKey))!,Double(XKeyChain.get(longiduteKey))!,addressDetail)

        }
        
        decisionHandler(.allow)
    }
    
    

}
extension ShopDetailWebController{
    func jumpToMapClicked(_ latitute:Double,_ longitute:Double,_ endAddress:String) {
        
        let alter = UIAlertController.init(title: "请选择导航应用程序", message: "", preferredStyle: UIAlertController.Style.actionSheet)
        
        let cancle = UIAlertAction.init(title: "取消", style: UIAlertAction.Style.cancel) { (a) in
        }
        
        let action1 = UIAlertAction.init(title: "苹果地图", style: UIAlertAction.Style.default) { (b) in
            self.appleMap(lat: latitute, lng: longitute, destination: endAddress)
        }
        
        let action2 = UIAlertAction.init(title: "高德地图", style: UIAlertAction.Style.default) { (b) in
            self.amap(dlat: latitute, dlon: longitute, dname: endAddress, way: 0)
        }
        
        let action3 = UIAlertAction.init(title: "百度地图", style: UIAlertAction.Style.default) { (b) in
            self.baidumap(endAddress: endAddress, way: "driving", lat: latitute,lng: longitute)
        }
        
        alter.addAction(action1)
        alter.addAction(action2)
        alter.addAction(action3)
        alter.addAction(cancle)
        
        self.present(alter, animated: true, completion: nil)
    }
    
    // 打开苹果地图
    func appleMap(lat:Double,lng:Double,destination:String){
        
        let loc = CLLocationCoordinate2DMake(lat - 0.006, lng - 0.0065)
        let currentLocation = MKMapItem.forCurrentLocation()
        let toLocation = MKMapItem(placemark:MKPlacemark(coordinate:loc,addressDictionary:nil))
        toLocation.name = destination
        let launchOptions:[String:Any] = [MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving ,
                                          MKLaunchOptionsShowsTrafficKey:true,
                                          MKLaunchOptionsMapTypeKey:MKMapType.standard.rawValue]
        MKMapItem.openMaps(with: [currentLocation,toLocation],
                           launchOptions:launchOptions )
        
    }
    
    // 打开高德地图
    func amap(dlat:Double,dlon:Double,dname:String,way:Int) {
        let appName = "UIT"
        
        //        let baidu_coordinate = getBaiDuCoordinateByGaoDeCoordinate(coordinate: coordinate)
        
        let urlString = "iosamap://path?sourceApplication=\(appName)&dname=\(dname)&dlat=\(dlat - 0.006)&dlon=\(dlon - 0.0065)&t=\(way)" as NSString
        
        if self.openMap(urlString) == false {
            SZHUD("您还未安装高德地图", type: .info, callBack: nil)
            return
        }
    }
    
    // 打开百度地图
    func baidumap(endAddress:String,way:String,lat:Double,lng:Double) {
        
        let coordinate = CLLocationCoordinate2DMake(lat, lng)
        
        let destination = "\(coordinate.latitude),\(coordinate.longitude)"
        
        
        let urlString = "baidumap://map/direction?" + "&destination=" + endAddress + "&mode=" + way + "&destination=" + destination
        
        let str = urlString as NSString
        
        if self.openMap(str) == false {
            SZHUD("您还未安装百度地图", type: .info, callBack: nil)
            return
            
        }
    }
    
    // 打开第三方地图
    private func openMap(_ urlString: NSString) -> Bool {
        
        //        let url = NSURL(string:urlString.addingPercentEscapes(using: String.Encoding.utf8.rawValue)!)
        let url = URL(string: urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        
        if UIApplication.shared.canOpenURL(url! as URL) == true {
            UIApplication.shared.openURL(url! as URL)
            return true
        } else {
            return false
        }
    }
    
    // 高德经纬度转为百度地图经纬度
    // 百度经纬度转为高德经纬度，减掉相应的值就可以了。
    func getBaiDuCoordinateByGaoDeCoordinate(coordinate:CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(coordinate.latitude - 0.006, coordinate.longitude - 0.0065)
    }
}
