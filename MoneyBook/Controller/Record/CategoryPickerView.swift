//
//  CategoryPickerView.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/05/04.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit

protocol CategoryPickerViewDelegate: UIPickerViewDelegate {
    /// Occurs when editing or creation of a evnet is completed.
//    func didFinishEditEvent(viewController: RecordsViewController,
//                            oldEvent: Event?,
//                            newEvent: Event) -> Void
//
//    func getCategoryPickerView(categoryPickerView: UIPickerView, //CategoryPickerView,
//                            inputView: UIPickerView, //CategoryPickerView,
//                            inputAccessoryView: UIToolbar) -> Bool

    func categoryPickerView(_ categoryPickerView: CategoryPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    func categoryPickerView(_ categoryPickerView: CategoryPickerView, didSelectRow row: Int, inComponent component: Int) -> Void
}

protocol CategoryPickerViewDataSource: UIPickerViewDataSource {
    /// Occurs when editing or creation of a evnet is completed.
    func numberOfComponents(in categoryPickerView: CategoryPickerView) -> Int
    func categoryPickerView(_ categoryPickerView: CategoryPickerView, numberOfRowsInComponent component: Int) -> Int
//    func didFinishEditEvent(viewController: RecordsViewController,
//                            oldEvent: Event?,
//                            newEvent: Event) -> Void
}

class CategoryPickerView: UIPickerView {
    //MARK: - ========== internal methods ==========
    
    //MARK: - ==========  var define ==========
    private var categoryDelegate: CategoryPickerViewDelegate? = nil
    override var delegate: UIPickerViewDelegate? {
        didSet { categoryDelegate = delegate as? CategoryPickerViewDelegate }
    }
    private var categoryDataSource: CategoryPickerViewDataSource? = nil
    override var dataSource: UIPickerViewDataSource? {
        didSet { categoryDataSource = dataSource as? CategoryPickerViewDataSource }
    }
    /// Category Picker
    var categoryPickerView: UIPickerView!
    
    //MARK: - ========== override Init methods ==========
    override init(frame: CGRect) {
        super.init(frame: frame)
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(self.someAction(_ :)))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        let gesture = UITapGestureRecognizer(target: self,
                                             action: #selector(self.someAction(_:)))
        self.addGestureRecognizer(gesture)
    }

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        self.setUpUI()
    }
    
    //MARK: - ========== Init methods ==========
    func setUpUI() {
        categoryPickerView = UIPickerView()
        categoryPickerView.showsSelectionIndicator = true;
        categoryPickerView.delegate = self as? UIPickerViewDelegate
        categoryPickerView.dataSource = self as? UIPickerViewDataSource
    }
    
//    func categoryPickerView(categoryPickerView: CategoryPickerView,
//                                    inputView: CategoryPickerView,
//                                    inputAccessoryView: UIToolbar) -> Bool{
//        return true
//    }
    
    func someAction(_ sender: UIGestureRecognizer){
        print ("CategoryPickerView someAction()")
    }
    
    //MARK: - ========== pickerView dataSource ==========
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return (self.categoryDataSource?.numberOfComponents(in: categoryPickerView as! CategoryPickerView))!
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return (self.categoryDataSource?.categoryPickerView(_: categoryPickerView as! CategoryPickerView, numberOfRowsInComponent: component))!
    }
    
    //MARK: - ========== pickerView delegate ==========
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (self.categoryDelegate?.categoryPickerView(_: categoryPickerView as! CategoryPickerView,
                                                             titleForRow: row,
                                                             forComponent: component))
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.categoryDelegate?.categoryPickerView(_: categoryPickerView as! CategoryPickerView,
                                                      didSelectRow: row,
                                                      inComponent: component)
    }
}
