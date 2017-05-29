//
//  RecordsViewController.swift
//  MoneyBook
//
//  Created by HongQuan on 2017/04/30.
//  Copyright © 2017年 Roan.Hong. All rights reserved.
//

import UIKit
import UserNotifications

protocol RecordsViewControllerDelegate {
    func sendValue (value : String, view : String)
    
    /// Occurs when editing or creation of a evnet is completed.
    func didFinishEditEvent(viewController: RecordsViewController,
                           oldEvent: Event?,
                           newEvent: Event) -> Void
}

class RecordsViewController: UIViewController,
    UIApplicationDelegate,
    RecordsViewControllerDelegate,
    CategoryPickerViewDelegate,
    CategoryPickerViewDataSource
    {

    //MARK: - ========== internal methods ==========
    internal func sendValue (value : String, view : String) {
        print(value, view)
        switch view {
        case D_calVC_name :
            lblMoney.text = value
        case D_spentVC_name :
            lblSpent.text = value
        case D_statusVC_name :
            lblStatus.text = value
        default:
            lblMoney.text = value
        }
    }
    /// Occurs when editing or creation of a evnet is completed.
    func didFinishEditEvent(viewController: RecordsViewController, oldEvent: Event?, newEvent: Event) {
        print("didFinishEditEvent ")
        let service   = self.eventService()
        var success = false;
        if (newEvent.eventId == Event.EventIdNone) {
            success = service.add(event: newEvent)
        } else {
            success = service.update(oldEvent: oldEvent!, newEvent: newEvent)
        }
        
        if success {
            //  self.tableView.reloadData()
            //showMessage("Saving success! Fade", type: .success, options: [.animation(.fade)])
            //showMessage("Saving success! Endless", type: .success, options: [.autoHide(true), .hideOnTap(true)])
            //showMessage("Saving success! autoHide", type: .success, options: [.autoHideDelay(1)])
            showMessage("This will be a very long message that someone wanna show in a high message",
                        type: .success, options: [.textNumberOfLines(2), .height(80.0)])
            
            //hideMessage()
        } else {
            showMessage("Saving failed!", type: .error, options: [.autoHideDelay(1)])
        }
    }

//MARK: - ==========  var define ==========
    /// Events to edit, if it is created nil.
    weak var originalEvent: Event?
    /// Notify the editing status of the event.
    var deletate: RecordsViewControllerDelegate?
    
    @IBOutlet var eventSpentView: BaseView!
    @IBOutlet var spentForView: BaseView!
    @IBOutlet var dateView:     UIView!
    @IBOutlet var fromAccView:  BaseView!
    @IBOutlet var statusView:   BaseView!
    @IBOutlet var spentView:    BaseView!
    @IBOutlet var calView:      BaseView!
    
    @IBOutlet var lblSpent:     UILabel!
    @IBOutlet var lblStatus:    UILabel!
    @IBOutlet var lblFromAcc:   UILabel!
    @IBOutlet var lblDate:      UILabel!
    @IBOutlet var lblMoney:     UILabel!
    @IBOutlet var lblSpentFor:  UILabel!
    @IBOutlet var lblEvent:     UILabel!
    @IBOutlet var btnSpentFor:  UIButton!
    @IBOutlet var btnEvent:     UIButton!
    var tfSpentFor: UITextField! = nil
    var tfEvent: UITextField! = nil
    
    // DatePicker to the edit of release date.
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    // Category Picker
    var categoryPicker: CategoryPickerView!
    // Dynamic barButton
    var actionItem: UIBarButtonItem!

    var eventList = ["inCome","OutCome","other"]
    var pickerListIncome = ["inCome1","inCome2","inCome3","inCome4","inCome5"]
    var pickerListIncomeSecend = ["Baseball", "Football", "Basketball", "Hockey"]
    var pickerListOutcome = ["OutCome1","OutCome2","OutCome3","OutCome4"]
    var pickerListOutcomeSecend = ["Baseball", "Football", "Basketball", "Hockey"]
    var pickerListOther = ["Other1","Other2","Other3"]
    var pickerListOtherSecend = ["Baseball", "Football", "Basketball", "Hockey"]
    
    var eventSeason = ["2013", "2014", "2015"] //multi-season
    var activeDataArray = [""]
    
//MARK: - ========== override methods ==========
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        
        self.view.setNeedsDisplay()
        self.hideKeyboard()
        self.setUpUserNotification()
        self.setUpUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        //fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        //发送通知
        //NotificationCenter.default.post(name:kNotificationNameAgreementViewWillShow, object: nil, userInfo: notification.userInfo)
        //接受通知监听
        NotificationCenter.default.addObserver(self, selector: #selector(onAgreementViewWillShow),
                                               name: kNotificationNameAgreementViewWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onAgreementViewWillHide),
                                               name: kNotificationNameAgreementViewWillHide, object: nil)
    }
    deinit {
        
        NotificationCenter.default.removeObserver(self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onAgreementViewWillShow() {
        let story_agree = UIStoryboard(name: "Startup", bundle: nil)
        //let story_agree: UIStoryboard = self.storyboard!
        let agreementVC = story_agree.instantiateViewController(withIdentifier:"Agreement") as! AgreementViewController
        //self.present(agreementVC, animated: true, completion: nil)
        self.show(agreementVC, sender: true)
    }
    
    func onAgreementViewWillHide() {
    }
    
//MARK: - ========== Init methods ==========
    func defaultInfo() {
        lblMoney.text = "1000"
        lblSpent.text = "Spent"
        lblStatus.text = "Status"
        lblFromAcc.text = "Account"
        lblDate.text = "Date"
    }
    
    func setUpUI() {
        defaultInfo()
        self.calView.name = D_calVC_name;
        self.spentView.name = D_spentVC_name;
        self.statusView.name = D_statusVC_name;
        self.fromAccView.name = D_fromAccVC_name;

        self.setUpCategoryPickerView()
        self.showCurrentDate()
    }
    func setUpCategoryPickerView() {
        categoryPicker = CategoryPickerView()
        categoryPicker.showsSelectionIndicator = true;
        categoryPicker.delegate = self as CategoryPickerViewDelegate// as? UIPickerViewDelegate
        categoryPicker.dataSource = self as CategoryPickerViewDataSource //as? UIPickerViewDataSource
        let toolbar = UIToolbar(frame: CGRectMake(0, 0, 0, 35))
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self,
                                       action: #selector(RecordsViewController.done))
        let cancelItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self,
                                         action: #selector(RecordsViewController.cancel))
        
        actionItem = UIBarButtonItem(title: eventList[0], style: .plain, target: self,
                                     action: #selector(RecordsViewController.tapAction))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: self, action: nil)
        // pickerが下から出てくるToolbarの作成
        toolbar.setItems([cancelItem, actionItem, flexibleSpace, doneItem], animated: true)
        
        self.tfSpentFor = UITextField(frame: CGRectMake(0, 0, 0, 0))
        self.tfEvent = UITextField(frame: CGRectMake(0, 0, 0, 0))
        self.view.addSubview(tfSpentFor)
        self.view.addSubview(tfEvent)
        
        tfSpentFor.inputView = categoryPicker
        tfSpentFor.inputAccessoryView = toolbar
        tfEvent.inputView = categoryPicker
        tfEvent.inputAccessoryView = toolbar
    }
    
    func showCurrentDate() {
        let currentDateTime = Date()
        // get the user's calendar
        let userCalendar = Calendar.current
        // choose which date and time components are needed
        let requestedComponents: Set<Calendar.Component> = [
            .year, .month, .day, .hour, .minute, .second
        ]
        let dateTimeComponents = userCalendar.dateComponents(requestedComponents, from: currentDateTime)
        print(dateTimeComponents.year!)
        lblDate.text = "\(dateTimeComponents.year!)/\(dateTimeComponents.month!)/\(dateTimeComponents.day!)"
    }

    func setUpUserNotification() {
        let center:UNUserNotificationCenter = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .sound, .alert, .carPlay],
                                    completionHandler: {(permit, error) in
            if permit {
                self.showMessage("通知が許可されました", type: .success, options: [.autoHideDelay(2)])
            } else {
                self.showMessage("通知が拒否されました", type: .error, options: [.autoHideDelay(2)])
            }
        })
    }
//MARK: - ========== IBACtions ==========
    
    @IBAction func MoneyInputButtonDidTap(_ sender: UIButton) {
        
    }
    @IBAction func AccountSelcetButtonDidTap(_ sender: UIButton) {
        
    }
    @IBAction func DatePikerButtonDidTap(_ sender: UIButton) {
        
    }
    // SpentFor Button taped
    @IBAction func SpentForButtonDidTap(_ sender: UIButton) {
        self.tfSpentFor.becomeFirstResponder()
    }
    // Event Button taped
    @IBAction func EventButtonDidTap(_ sender: UIButton) {
        self.tfEvent.becomeFirstResponder()
    }
    
    // Save taped
    @IBAction func writeDidTap(_ sender: UIButton) {
        if check() {
         /*   let record = Record()
            record.money = Int(lblMoney.text!)!
            record.spent = lblSpent.text!
            record.date = lblDate.text!
            record.spentFor = tfSpentFor.text!
            record.event = tfEvent.text!
            record.status = lblStatus.text!
            DB.share().saveRecord(record) */
            

            let saveConformAlert = UIAlertController(title: "アラート表示", message: "保存してもいいですか？", preferredStyle:  UIAlertControllerStyle.actionSheet)
            saveConformAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {
                (action: UIAlertAction!) -> Void in
                // It's new DB inteface!
                let newEvent = Event(eventId: (self.originalEvent != nil) ?
                                self.originalEvent!.eventId: Event.EventIdNone,
                                                    author: "testAuthor",//self.authorTextField.text!,
                                                    title: "testtitle", //self.titleTextField.text!,
                                                    releaseDate: self.releaseDatePicker.date)
                self.didFinishEditEvent(viewController: self, oldEvent: self.originalEvent, newEvent: newEvent)
                
                if UIApplication.shared.applicationIconBadgeNumber > 9 {
                    UIApplication.shared.applicationIconBadgeNumber = 0
                } else {
                    UIApplication.shared.applicationIconBadgeNumber += 1
                }
                
            }))
            saveConformAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(saveConformAlert, animated: true, completion: nil)
            
        } else {
            let warningAlert = UIAlertController(title: "Warning", message: "Data is null!", preferredStyle: UIAlertControllerStyle.alert)
            warningAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(warningAlert, animated: true, completion: nil)
        }
    }
    //MARK: - ========== privete methods ==========
    func check() -> Bool {
        var boo : Bool = false
        if(Int(lblMoney.text!)! > 0 && lblFromAcc.text != "" ){
            boo = true
        }
        return boo
    }
    
    // MARK: - Get the event data
    /// - Returns: Instance of the event Service.
    func eventService() -> EventService {
        let app = UIApplication.shared.delegate as! AppDelegate
        return app.appDatabaseManager.eventService
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        activeDataArray = [] //clear out the clicked field data array
        if textField == tfEvent {
            activeDataArray = eventSeason
        } else if textField == tfSpentFor {
            activeDataArray = pickerListIncome
        }
        categoryPicker.reloadAllComponents()
        categoryPicker.resignFirstResponder()
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return activeDataArray.count
/*        if actionItem.title == eventList[0] {
            return pickerListIncome.count
        } else if actionItem.title == eventList[1] {
            return pickerListOutcome.count
        } else if actionItem.title == eventList[2] {
            return pickerListOther.count
        } else {
            return pickerListIncome.count
        } */
    }
    //MARK: - ========== pickerView delegate ==========
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return activeDataArray[row] 
/*
        if actionItem.title == eventList[0] {
            return pickerListIncome[row]
        } else if actionItem.title == eventList[1] {
            return pickerListOutcome[row]
        } else if actionItem.title == eventList[2] {
            return pickerListOther[row]
        } else {
            return pickerListIncome[row]
        } */
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        if textField == tfEvent {
//            activeDataArray = eventSeason
//        } else if textField == tfSpentFor {
//            activeDataArray = pickerListIncome
//        }
/*
        if actionItem.title == eventList[0] {
            self.tfSpentFor.text = pickerListIncome[row]
        } else if actionItem.title == eventList[1] {
            self.tfSpentFor.text = pickerListOutcome[row]
        } else if actionItem.title == eventList[2] {
            self.tfSpentFor.text = pickerListOther[row]
        } else {
            self.tfSpentFor.text = pickerListIncome[row]
        } */
    }
    
    // MARK: - categoryPickerViewDataSource
    func numberOfComponents(in categoryPickerView: CategoryPickerView) -> Int {
        return 1
    }
    func categoryPickerView(_ categoryPickerView: CategoryPickerView, numberOfRowsInComponent component: Int) -> Int {
        if actionItem.title == eventList[0] {
            return pickerListIncome.count
        } else if actionItem.title == eventList[1] {
            return pickerListOutcome.count
        } else if actionItem.title == eventList[2] {
            return pickerListOther.count
        } else {
            return pickerListIncome.count
        }
    }
    // MARK: - categoryPickerViewDelegate
    func categoryPickerView(_ categoryPickerView: CategoryPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if actionItem.title == eventList[0] {
            return pickerListIncome[row]
        } else if actionItem.title == eventList[1] {
            return pickerListOutcome[row]
        } else if actionItem.title == eventList[2] {
            return pickerListOther[row]
        } else {
            return pickerListIncome[row]
        }
    }
    func categoryPickerView(_ categoryPickerView: CategoryPickerView, didSelectRow row: Int, inComponent component: Int) -> Void {
    }
    
    func cancel() -> Void {
        self.tfSpentFor.text = ""
        //trying to hide the dataPicker
        self.tfEvent.resignFirstResponder()
        self.tfSpentFor.resignFirstResponder()
    }
    
    func done() -> Void {
        //trying to hide the dataPicker
        self.tfEvent.resignFirstResponder()
        self.tfSpentFor.resignFirstResponder()
    }
    
    func tapAction() -> Void {
        if actionItem.title == eventList[0] {
            actionItem.title = eventList[1]
        } else if actionItem.title == eventList[1] {
            actionItem.title = eventList[2]
        } else if actionItem.title == eventList[eventList.count - 1] {
            actionItem.title = eventList[0]
        } else {
            actionItem.title = eventList[0]
        }
    }
}

extension UIViewController {
    func hideKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
}
