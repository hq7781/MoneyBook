//
//  CalendarViewController.swift
//  MoneyBook
//
//  Created by HONGQUAN on 8/22/17.
//  Copyright © 2017 Roan.Hong. All rights reserved.
//

import UIKit
import CVCalendar

class CalendarViewController : UIViewController {
    
    struct Color {
        static let selectedText = UIColor.darkGray
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = UIColor.enixColorWith( 20, 20, 100, alpha: 1.0)
        static let sundayText = UIColor.enixColorWith( 100, 20, 100, alpha: 1.0)
        static let sundayTextDisabled = UIColor.enixColorWith( 100, 100, 100, alpha: 1.0)
        static let sundayBackground = UIColor.enixColorWith( 20, 200, 100, alpha: 1.0)
        static let sundaySelectionBackground = UIColor.enixColorWith( 120, 120, 100, alpha: 1.0)
        
    }
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var daysOutSwitch: UISwitch!
//    @IBOutlet weak var listButton: TextImageButton!
    
    fileprivate var randomNumberOfDotmarkersForDay = [Int]()
    var shouldShowDaysOut = true
    var animationFinished = true
    
    var selectedDay: DayView!
    var currentCalendar: Calendar?
    
    override func awakeFromNib() {
        let timeZoneBias = 480 // (UIC+08:00)
        currentCalendar = Calendar.init(identifier: .gregorian)
        if let timeZone = TimeZone.init(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCalendarViewUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setToolbarHidden(false, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }
    func setupCalendarViewUI() {

        if let currentCalendar = currentCalendar {
            monthLabel.text = CVDate(date: Date(), calendar: currentCalendar).globalDescription
        }
        randomizeDotmarkers()
        
        //showListViewUI()
    }
    ////
    /*
    func showListViewUI() {
        listButton = TextImageButton(frame: CGRect.CGRectMake(40, 300, 80, 44))
        listButton.setTitle("List", for: .normal)
        listButton.titleLabel?.font = theme.appNaviItemFont
        listButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        listButton.setImage(UIImage(named:"home_down"), for: .normal)
        listButton.addTarget(self, action: #selector(onClickPushListView),
                             for:UIControlEvents.touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: listButton)
    }
    
    func onClickPushListView() {
        let listViewVC = HistoryMasterViewController()
        let nav = MainNavigationController(rootViewController: listViewVC)
        present(nav, animated:true, completion:nil)
    }
     */
    
    private func randomizeDotmarkers() {
        randomNumberOfDotmarkersForDay = [Int]()
        for _ in 0...31 {
            randomNumberOfDotmarkersForDay.append(Int(arc4random_uniform(3) + 1))
        }
    }
    
    @IBAction func removeCircleAndDot(sender: AnyObject) {
        if let dayView = selectedDay {
            //calendarView.contentController.removeCircleLabel(dayView) // ????
            if dayView.date.day < randomNumberOfDotmarkersForDay.count {
                randomNumberOfDotmarkersForDay[dayView.date.day] = 0
            }
            
            calendarView.contentController.refreshPresentedMonth()
        }
    }
    @IBAction func refreshmonth(sender: AnyObject) {
        calendarView.contentController.refreshPresentedMonth()
        randomizeDotmarkers()
    }
}

// MARK: - CVCalendarViewDelegate & CVCalendarMenuViewDelegate
extension CalendarViewController: CVCalendarViewDelegate, CVCalendarMenuViewDelegate {
    // Required method
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    // Required method
    func firstWeekday() -> Weekday {
        return .sunday
    }

    // Optional methoeds
    func calendar() -> Calendar? {
        return currentCalendar
    }
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor.green : UIColor.white
    }
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    func shouldSelectDayView(_ dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ?  true : false
    }
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
    }
    func shouldSelectRange() -> Bool {
        return true
    }
    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
        print("RANGE SELECTED: ")
    }
    func presentedDateUpdated(_ date: CVDate) {
        if monthLabel.text != date.globalDescription && self.animationFinished {
            let updatedMonthLabel = UILabel()
            updatedMonthLabel.textColor = monthLabel.textColor
            updatedMonthLabel.font = monthLabel.font
            updatedMonthLabel.textAlignment = .center
            updatedMonthLabel.text = date.globalDescription
            updatedMonthLabel.sizeToFit()
            updatedMonthLabel.alpha = 0
            updatedMonthLabel.center = self.monthLabel.center
            
            let offset = CGFloat(48)
            updatedMonthLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedMonthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.monthLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.monthLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.monthLabel.alpha = 0
                
                updatedMonthLabel.alpha = 1
                updatedMonthLabel.transform = CGAffineTransform.identity
            }) { _ in
                self.animationFinished = true
                self.monthLabel.frame = updatedMonthLabel.frame
                self.monthLabel.text = updatedMonthLabel.text
                self.monthLabel.transform = CGAffineTransform.identity
                self.monthLabel.alpha = 1
                updatedMonthLabel.removeFromSuperview()
            }
            self.view.insertSubview(updatedMonthLabel, aboveSubview: self.monthLabel)
        }
    }

    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if dayView.isCurrentDay {
            return true
        }
        return false
    }
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        dayView.setNeedsLayout()
        dayView.layoutIfNeeded()
        
        let π = Double.pi
        let ringLayer = CAShapeLayer()
        let ringLineWidth: CGFloat = 4.0
        let ringLineColor = UIColor.blue
        let newView = UIView(frame: dayView.frame)
        let diameter = min(newView.bounds.width, newView.bounds.height)
        let radius = diameter / 2.0 - ringLineWidth
        
        newView.layer.addSublayer(ringLayer)
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColor.cgColor
        
        let centrePoint = CGPoint(x: newView.bounds.width / 2.0, y: newView.bounds.height / 2.0)
        let startAngle = CGFloat(-π / 2.0)
        let endAngle = CGFloat(π * 2.0) + startAngle
        let ringPath = UIBezierPath(arcCenter: centrePoint,
                                    radius: radius,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        return newView
    }
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        guard let currentCalendar = currentCalendar else {
            return false
        }
        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
        
        if dayView.date.year == components.year &&
            dayView.date.month == components.month {
            
            if dayView.date.day == 3 || dayView.date.day == 13 || dayView.date.day == 23 {
                print("Circle should appear on" + dayView.date.commonDescription)
                return true
            }
            return false
        } else {
            if Int(arc4random_uniform(3)) == 1 {
                return true
            }
            return false
        }
    }
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.white
    }
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.orange
    }
    func disableScrollingBeforeDate() -> Date {
        return Date()
    }
    func maxSelectableRange() -> Int {
        return 14
    }
    func earliestSelectableDate() -> Date {
        return Date()
    }
    func latestSelectableDate() -> Date {
        var dayComponents = DateComponents()
        dayComponents.day = 70
        let calendar = Calendar(identifier: .gregorian)
        
        if let lastDate = calendar.date(byAdding: dayComponents, to: Date()) {
            return lastDate
        } else {
            return Date()
        }
    }
}
// MARK: - CVCalendarViewAppearanceDelegate
extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont {
        return UIFont.systemFont(ofSize: 14)
    }
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _):
            return Color.selectedText
        case (.sunday, .in, _):
            return Color.sundayText
        case (.sunday, _, _):
            return Color.sundayTextDisabled
        case (_, .in, _):
            return Color.text
        default:
            return Color.textDisabled
        }
    }
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _):
            return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _):
            return Color.selectionBackground
        default:
            return nil
        }
    }
    
}
// MARK: - IB Actions
extension CalendarViewController {
    @IBAction func switchChanged(sender: UISwitch) {
        calendarView.changeDaysOutShowingState(shouldShow: sender.isOn)
    }
    @IBAction func todayMonthView() {
        calendarView.toggleCurrentDayView()
    }
    @IBAction func toWeekView(sender: AnyObject) {
        calendarView.changeMode(.weekView)
    }
    @IBAction func toMonthView(sender: AnyObject) {
        calendarView.changeMode(.monthView)
    }
    @IBAction func loadPrevious(sender: AnyObject) {
        calendarView.loadPreviousView()
    }
    @IBAction func loadNext(sender: AnyObject) {
        calendarView.loadNextView()
    }
}

extension CalendarViewController {
    func toggleMonthViewWithMonthOffset(offset: Int) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        var components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
        components.month! += offset
        
        let resultDate = currentCalendar.date(from: components)!
        self.calendarView.toggleViewWithDate(resultDate)
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        
        let components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
        print("Showing Month: \(components.month!)")
    }
    
    func didShowNextMonthView(_ date: Date) {
        guard let currentCalendar = currentCalendar else {
            return
        }
        
        let components = Manager.componentsForDate(Foundation.Date(), calendar: currentCalendar)
        print("Showing Month: \(components.month!)")
    }
    
}
// MARK: - Conveniuence API

