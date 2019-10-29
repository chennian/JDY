//
//  MapViewCell.swift
//  EEPCShop
//
//  Created by Mac Pro on 2019/4/19.
//  Copyright © 2019年 CHENNIAN. All rights reserved.
//

import UIKit


class MapViewCell: SNBaseTableViewCell {
    
    var mapView = BMKMapView().then{
        $0.backgroundColor = .red
        $0.zoomLevel = 16
        $0.baseIndoorMapEnabled = true
        $0.showsUserLocation = false
        $0.userTrackingMode = BMKUserTrackingModeFollow
        $0.showsUserLocation = true
        $0.isZoomEnabledWithTap = true
    }
    
    
    override func setupView() {
        
        self.addSubview(mapView)
        mapView.delegate = self
        
        mapView.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }

    }

}
extension MapViewCell:BMKMapViewDelegate{
    
}
