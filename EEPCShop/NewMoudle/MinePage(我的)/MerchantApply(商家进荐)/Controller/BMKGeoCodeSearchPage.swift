//
//  BMKGeoCodeSearchPage.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/5/4.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

class BMKGeoCodeSearchPage:SNBaseViewController {
    
    var cell:AddressCell =  AddressCell()
    fileprivate let tableView:UITableView = UITableView().then{
        $0.backgroundColor = color_bg_gray_f5
        $0.register(AddressCell.self)
        $0.tableFooterView = UIView()
    }
    
    let mapView = BMKMapView().then{
        $0.zoomLevel = 12
        $0.showsUserLocation = true
        $0.showMapScaleBar = true;
    }
    
    
    var key:String = "店铺"
    var dataArray:[BMKPoiInfo] = []
    
    let nearbyOption = BMKPOINearbySearchOption()
    
    var annotations = [BMKPointAnnotation]()
    
    var userLocation: BMKUserLocation = BMKUserLocation()
    
    let annotation = BMKPointAnnotation()

    lazy var locationManager: BMKLocationManager = {
        let manager = BMKLocationManager()
        manager.coordinateType = BMKLocationCoordinateType.BMK09LL
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = CLActivityType.automotiveNavigation
        manager.pausesLocationUpdatesAutomatically = false
        manager.allowsBackgroundLocationUpdates = false
        manager.locationTimeout = 10
        return manager
    }()
    
    
    
    func setup(){
        
        self.title = "附近位置"
        self.view.backgroundColor = Color(0xf5f5f5)
        self.view.addSubview(tableView)
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.height.snEqualTo(500)
        }
        mapView.delegate = self
        locationManager.requestLocation(withReGeocode: true, withNetworkState: true) {[unowned self] (location, state, error) in
            CNLog(location)
            self.userLocation.location = location?.location
            //实现该方法，否则定位图标不出现
            self.mapView.updateLocationData(self.userLocation)
            self.mapView.centerCoordinate = self.userLocation.location.coordinate
            
            //初始化标注类BMKPointAnnotation的实例
            //设置标注的经纬度坐标
            self.annotation.coordinate = self.mapView.centerCoordinate
            //设置标注的标题
            //将一组标注添加到当前地图View中
            self.mapView.addAnnotation(self.annotation)

            self.nearbyOption.keywords = ["写字楼","小区","商家","街道","村庄"]
            self.nearbyOption.pageSize = 20
            self.nearbyOption.location = (location?.location?.coordinate)!
            self.searchData(self.nearbyOption)
        }
        mapView.showsUserLocation = true
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.emptyDataSetSource = self
        self.tableView.emptyDataSetDelegate = self
        
        tableView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(mapView.snp.bottom)
        }
        
    }
    
    override func setupView() {
        setup()
    }
    
    func setupDefaultData() {
        //初始化请求参数类BMKNearbySearchOption的实例
        //检索关键字
      
    }
    func searchData(_ option: BMKPOINearbySearchOption) {
        //初始化BMKPoiSearch实例
        let POISearch = BMKPoiSearch()
        //设置POI检索的代理
        POISearch.delegate = self
        //初始化请求参数类BMKNearbySearchOption的实例
        /**
         检索关键字，必选。
         在周边检索中关键字为数组类型，可以支持多个关键字并集检索，如银行和酒店。每个关键字对应数组一个元素。
         最多支持10个关键字。
         */
        nearbyOption.keywords = option.keywords
        //检索中心点的经纬度，必选
        nearbyOption.location = option.location
        /**
         检索半径，单位是米。
         当半径过大，超过中心点所在城市边界时，会变为城市范围检索，检索范围为中心点所在城市
         */
        nearbyOption.radius = option.radius
        /**
         检索分类，可选。
         该字段与keywords字段组合进行检索。
         支持多个分类，如美食和酒店。每个分类对应数组中一个元素
         */
        nearbyOption.tags = option.tags
        /**
         是否严格限定召回结果在设置检索半径范围内。默认值为false。
         值为true代表检索结果严格限定在半径范围内；值为false时不严格限定。
         注意：值为true时会影响返回结果中total准确性及每页召回poi数量，我们会逐步解决此类问题。
         */
        nearbyOption.isRadiusLimit = option.isRadiusLimit
        /**
         POI检索结果详细程度
         
         BMK_POI_SCOPE_BASIC_INFORMATION: 基本信息
         BMK_POI_SCOPE_DETAIL_INFORMATION: 详细信息
         */
        nearbyOption.scope = option.scope
        //检索过滤条件，scope字段为BMK_POI_SCOPE_DETAIL_INFORMATION时，filter字段才有效
        nearbyOption.filter = option.filter
        //分页页码，默认为0，0代表第一页，1代表第二页，以此类推
        nearbyOption.pageIndex = option.pageIndex
        //单次召回POI数量，默认为10条记录，最大返回20条。
        nearbyOption.pageSize = option.pageSize
        /**
         根据中心点、半径和检索词发起周边检索：异步方法，返回结果在BMKPoiSearchDelegate
         的onGetPoiResult里
         
         nearbyOption 周边搜索的搜索参数类
         成功返回YES，否则返回NO
         */
        let flag = POISearch.poiSearchNear(by: nearbyOption)
        if flag {
            NSLog("POI周边检索成功")
        } else {
            NSLog("POI周边检索失败")
        }
    }
    
    
}
extension BMKGeoCodeSearchPage:BMKPoiSearchDelegate,BMKMapViewDelegate{
    
    func onGetPoiResult(_ searcher: BMKPoiSearch!, result poiResult: BMKPOISearchResult!, errorCode: BMKSearchErrorCode) {
        /**
         移除一组标注
         
         @param annotations 要移除的标注数组
         */
        //BMKSearchErrorCode错误码，BMK_SEARCH_NO_ERROR：检索结果正常返回
        self.dataArray.removeAll()

        if errorCode == BMK_SEARCH_NO_ERROR {
            for index in 0..<poiResult.poiInfoList.count {
                //POI信息类的实例
                let POIInfo = poiResult.poiInfoList[index]
                self.dataArray.append(POIInfo)
            }
            
            //设置当前地图的中心点
            self.tableView.reloadData()
        }else{
            self.tableView.reloadData()

//            SZHUD("未找到结果", type:.error, callBack: nil)
            
        }
    }
    
    func mapView(_ mapView: BMKMapView!, onDrawMapFrame status: BMKMapStatus!) {
        self.annotation.coordinate = self.mapView.centerCoordinate
        self.nearbyOption.keywords = ["写字楼","小区","商家","街道","村庄"]
        nearbyOption.location = self.mapView.centerCoordinate
        nearbyOption.pageSize = 20
        searchData(nearbyOption)
    }
    
    func mapView(_ mapView: BMKMapView!, regionDidChangeAnimated animated: Bool) {
        self.annotation.coordinate = self.mapView.centerCoordinate
       
    }

}
extension BMKGeoCodeSearchPage:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:AddressCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        self.cell = cell
        cell.model = self.dataArray[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return fit(120)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let NotifMycation = NSNotification.Name(rawValue:"shopAddress")
        NotificationCenter.default.post(name: NotifMycation, object: self.dataArray[indexPath.row].address)
        self.navigationController?.popViewController(animated: true)
    }
}
extension BMKGeoCodeSearchPage:DZNEmptyDataSetSource,DZNEmptyDataSetDelegate{
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: "empty");
    }
}
