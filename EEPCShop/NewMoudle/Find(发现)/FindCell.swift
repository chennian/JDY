//
//  CollectionViewCell.swift
//  SwiftCollectionView
//
//  Created by 栗子 on 2017/8/22.
//  Copyright © 2017年 http://www.cnblogs.com/Lrx-lizi/. All rights reserved.
//

import UIKit



class FindCell: UICollectionViewCell {
    
    var model:FindModel?{
        didSet{
            guard let cellModel = model else {return}
            self.imageView.kf.setImage(with: URL(string: httpUrl + cellModel.img))
            self.title.text = cellModel.title

        }
    }

    var  imageView = UIImageView().then{
        $0.backgroundColor = Color(0xffffff)
    }
    
    var title = UILabel().then{
        $0.text = ""
        $0.textColor = Color((0x313131))
        $0.font = Font(28)
        $0.numberOfLines = 0
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.creareUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creareUI(){
        self.contentView.backgroundColor = Color(0xffffff)
        self.contentView.addSubview(self.imageView)
        self.contentView.layer.cornerRadius = fit(5)
        self.contentView.addSubview(self.title)
       imageView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
            make.bottom.equalToSuperview().snOffset(-90)
        }
        title.snp.makeConstraints { (make) in
            make.left.equalToSuperview().snOffset(20)
            make.right.equalToSuperview().snOffset(-20)
            make.top.equalTo(imageView.snp.bottom).snOffset(20)
        }
//        self.imageView.frame = self.bounds;
        self.imageView.backgroundColor = UIColor.clear
        
    }
}
