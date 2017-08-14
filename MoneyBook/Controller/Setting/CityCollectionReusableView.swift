//
//  CityCollectionReusableView.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class CityHeadCollectionReusableView: UICollectionReusableView {
    var headTitleLabel: UILabel = UILabel()
    var headTitle: String? {
        didSet {
            headTitleLabel.text = headTitle
            headTitleLabel.font = UIFont.systemFont(ofSize: 18)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        headTitleLabel.textAlignment = .center
        headTitleLabel.font = UIFont.systemFont(ofSize:22)
        headTitleLabel.textColor = UIColor.black
        addSubview(headTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.headTitleLabel.frame = self.bounds
    }
}

class CityFootCollectionReusableView: UICollectionReusableView {
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel?.text = "more city.."
        titleLabel?.textAlignment = .center
        titleLabel?.textColor = UIColor.darkGray
        titleLabel?.font = UIFont.systemFont(ofSize:16)
        addSubview(titleLabel!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = self.bounds
    }
    
}

