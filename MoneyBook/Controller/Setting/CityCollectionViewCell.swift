//
//  CityCollectionViewCell.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit

class CityCollectionViewCell: UICollectionViewCell {
    private var textLabel: UILabel = UILabel()
    
    var cityName: String? {
        didSet {
            textLabel.text = cityName
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel.textColor = UIColor.black
        textLabel.highlightedTextColor = UIColor.red
        textLabel.textAlignment = .center
        textLabel.backgroundColor = UIColor.white
        
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented!")
    }
    
    // relayout
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = self.bounds
    }

}
