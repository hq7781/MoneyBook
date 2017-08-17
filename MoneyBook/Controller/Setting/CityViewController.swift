//
//  CityViewController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 7/25/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit
// cell Identifier 常量
let kCityCollectionViewCellId         = "CellID"
let kCityHeadCollectionReusableViewId = "HeadView"
let kCityFootCollectionReusableViewId = "FootView"

class CityViewController: UIViewController {
    var cityName: String?
    var collView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    lazy var domesticsCitys: NSMutableArray? = {
        let arr = NSMutableArray(array:["beijing","shanghai", "guangzhou"])
        return arr
    }()
    lazy var overseasCitys: NSMutableArray? = {
        let arr = NSMutableArray(array:["tokyo","soul", "taiwan"])
        return arr
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        AppUtils.googleTracking("CityView")
    }
    
    func setupUI() {
        self.showNavigationViewUI()
        self.showCollectionViewUI()
        
        let lastSelectedCityIndexPath = selectedCurrentCity()
        collView.selectItem(at: lastSelectedCityIndexPath as IndexPath, animated: true, scrollPosition: UICollectionViewScrollPosition.top)
    }
    
    private func selectedCurrentCity() -> NSIndexPath {
        if let currentCityName = self.cityName {
            for i in 0 ..< domesticsCitys!.count {
                if currentCityName == domesticsCitys?[i] as! String {
                    return IndexPath(item: i, section: 1) as NSIndexPath
                }
            }
            for i in 0 ..< overseasCitys!.count {
                if currentCityName == overseasCitys?[i] as! String {
                    return IndexPath(item: i, section: 1) as NSIndexPath
                }
            }
        }
        
        return IndexPath(item: 0, section: 0) as NSIndexPath
    }
    
    func showNavigationViewUI() {
        view.backgroundColor = theme.appBackgroundColor
        navigationItem.title = "Select a city"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title:"cancel",style: .done, target: self, action: #selector(onClickCancel))
    }
    
    func onClickCancel() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func showCollectionViewUI() {
        let itemW = (appWidth / 3.0) - 1.0
        let itemH: CGFloat = 50
        
        layout.itemSize = CGRect.CGSizeMake(itemW, itemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.headerReferenceSize = CGRect.CGSizeMake(view.width,60)
        
        // collectionView
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        collView.selectItem(at: IndexPath(item: 1, section: 1), animated: true, scrollPosition: UICollectionViewScrollPosition.top)
        collView.backgroundColor = UIColor.enixColorWith(247, 247, 247, alpha: 1)
        collView.register(CityCollectionViewCell.self, forCellWithReuseIdentifier: kCityCollectionViewCellId)
        collView.register(CityHeadCollectionReusableView.self,
                          forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                          withReuseIdentifier: kCityHeadCollectionReusableViewId)
        collView.register(CityFootCollectionReusableView.self,
                          forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                          withReuseIdentifier: kCityFootCollectionReusableViewId)
        collView.alwaysBounceVertical = true
        
        view.addSubview(collView)
    }
    
}

// MARK - UICollectionViewDelegate, UICollectionViewDataSource
extension CityViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    @available(iOS 6.0, *)
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return domesticsCitys!.count
        } else {
            return overseasCitys!.count
        }
    }
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collView.dequeueReusableCell(withReuseIdentifier: kCityCollectionViewCellId, for: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0 {
            cell.cityName = domesticsCitys!.object(at: indexPath.row) as? String
        } else {
            cell.cityName = overseasCitys!.object(at: indexPath.row) as? String
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            let footView = collectionView.dequeueReusableSupplementaryView(ofKind:
                UICollectionElementKindSectionFooter, withReuseIdentifier: kCityFootCollectionReusableViewId, for: indexPath) as! CityFootCollectionReusableView
            footView.frame.size.height = 80
            return footView
        }
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind:
            UICollectionElementKindSectionHeader, withReuseIdentifier: kCityHeadCollectionReusableViewId, for: indexPath) as! CityHeadCollectionReusableView
        if indexPath.section == 0 {
            headView.headTitle = "guonei"
        } else {
            headView.headTitle = "guowai"
        }
        return headView
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        let app = UIApplication.shared.delegate as! AppDelegate
        if app.appUserDefaultManager.setSelectedCity(city:currentCity) {
            NotificationCenter.default.post(name:kNotificationNameCurrentCityhasChanged, object: currentCity)
            //NSNotificationCenter.defaultCenter().postNotificationName(kNotificationNameCurrentCityhasChanged, object: currentCity)
            self.dismiss(animated: true, completion: nil)
        }

    }
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGRect.CGSizeZero()
        } else {
            return CGRect.CGSizeMake(view.width, 120)
        }
    }
}
