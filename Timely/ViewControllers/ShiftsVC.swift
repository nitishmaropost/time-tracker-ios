//
//  ShiftsVC.swift
//  Timely
//
//  Created by maropost on 28/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import FSCalendar

class ShiftsVC: UIViewController {

    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelWorkTime: UILabel!
    @IBOutlet weak var labelPremisesTime: UILabel!
    @IBOutlet weak var labelPresents: UILabel!
    @IBOutlet weak var labelAbsents: UILabel!
    @IBOutlet weak var tableShifts: UITableView!
    @IBOutlet weak var viewModel: AttendanceVM!
    
    // Variables
    var rowShift: RowsShift!
    var selectedShift: Shift!
    var viewBlackOverlay: UIView!
    var filterView: FilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shifts"
        self.tableShifts.register(ShiftCell.self, forCellReuseIdentifier: "ShiftCell")
        self.tableShifts.register(UINib(nibName: "ShiftCell", bundle: nil), forCellReuseIdentifier: "ShiftCell")
        self.setUIValues()
        self.addFilterView()
        self.setDateButtonTexts()
    }
    
    func setUIValues() {
        self.labelUserName.text = self.rowShift.userData.fullName
        self.labelWorkTime.text = "Work Time :  \(self.rowShift.workTime!/3600) hrs"
        self.labelPremisesTime.text = "Premises Time : \(self.rowShift.onPremisesTime!/3600) hrs"
        self.labelPresents.text = "Presents : \(self.rowShift.presents ?? 0)"
        self.labelAbsents.text = "Absents : \(self.rowShift.absents ?? 0)"
    }
    
    func addFilterView() {
        self.viewBlackOverlay = UIView(frame: self.view.frame)
        self.viewBlackOverlay.backgroundColor = UIColor.black
        self.viewBlackOverlay.alpha = 0.6
        self.view.addSubview(self.viewBlackOverlay)
        let gestureDismissFilter = UITapGestureRecognizer(target: self, action: #selector(self.showFilter))
        self.viewBlackOverlay.addGestureRecognizer(gestureDismissFilter)
        self.viewBlackOverlay.isHidden = true
        
        self.filterView = (FilterView.instanceFromNib() as! FilterView)
        self.filterView.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height + self.filterView.frame.size.height/2)
        self.filterView.buttonStartDate.backgroundColor = TimelyColors.shared.kColorFilterButtonSelected
        self.view.addSubview(self.filterView)
        self.filterView.delegate = self
        self.filterView.calendarFilter.delegate = self
        self.filterView.buttonStartDate?.titleLabel!.textAlignment = .center
        self.filterView.buttonEndDate?.titleLabel!.textAlignment = .center
        self.filterView.calendarFilter.select(self.viewModel.startDate, scrollToDate: true)
    }
    
    @IBAction func openLogs(_ sender: UIBarButtonItem) {
       // self.performSegue(withIdentifier: TimelyConstants.shared.segue_shifts_to_logs, sender: nil)
    }
    
    @IBAction func displayFilter(_ sender: UIBarButtonItem) {
        self.showFilter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TimeLogHistoryVC
        vc.viewModel.startDateString = self.selectedShift.dateString?.components(separatedBy: "T")[0]
        vc.viewModel.endDateString = self.selectedShift.dateString?.components(separatedBy: "T")[0]
        vc.viewModel.navType = .custom
        vc.viewModel.setInitialDates()
        vc.viewModel.empCode = "\(self.rowShift.shifts?[0].empCode ?? 0)"
    }
    
    func setDateButtonTexts() {
        self.filterView.buttonStartDate.setTitle("Start Date\n\(self.viewModel.startDateDisplayString ?? "")", for: .normal)
        self.filterView.buttonEndDate.setTitle("End Date\n\(self.viewModel.endDateDisplayString ?? "")", for: .normal)
    }
    
    @objc func showFilter() {
        if self.viewBlackOverlay.isHidden {
            self.viewBlackOverlay.isHidden = false
            UIView.animate(withDuration: 0.6) {
                self.filterView.center = CGPoint(x: self.filterView.center.x, y: self.view.frame.size.height - self.filterView.frame.size.height/2)
            }
        } else {
            self.viewBlackOverlay.isHidden = true
            UIView.animate(withDuration: 0.6) {
                self.filterView.center = CGPoint(x: self.view.center.x, y: self.view.frame.size.height + self.filterView.frame.size.height/2)
            }
        }
    }
}

extension ShiftsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shift = self.rowShift.shifts![indexPath.section]
        if shift.status == "present" {
            self.selectedShift = shift
            self.performSegue(withIdentifier: TimelyConstants.shared.segue_shifts_to_logs, sender: nil)
        } else if shift.status == "absent" {
            UIView.hr_setToastThemeColor(color: UIColor(red: 246.0/255.0, green: 96.0/255.0, blue: 102.0/255.0, alpha: 1.0))
            if shift.empCode == UserDefaults.standard.object(forKey: "emp_code") as? Int {
                self.view.makeToast(message: "You were on leave this day")
            } else {
                self.view.makeToast(message: "\(rowShift.userData.fullName ?? "-") was on leave this day")
            }
        } else {
            UIView.hr_setToastThemeColor(color: UIColor(red: 246.0/255.0, green: 96.0/255.0, blue: 102.0/255.0, alpha: 1.0))
            self.view.makeToast(message: "This day was a holiday")
        }
    }
}

extension ShiftsVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = self.rowShift.shifts?.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShiftCell", for: indexPath) as! ShiftCell
        let shift = self.rowShift.shifts![indexPath.section]
        cell.labelDate.text = shift.dateString?.components(separatedBy: "T")[0]
        if shift.status == "present" {
            cell.labelWorkTime.text = "Work Time : \(shift.workTime!/3600 ) hrs"
            cell.labelPremisesTime.text = "Premises Time : \(shift.onPremisesTime!/3600 ) hrs"
        } else if shift.status == "absent" {
            cell.constraint_height_labelWorkTime.constant = 80
            cell.constraint_height_labelPremisesTime.constant = 0
            cell.labelWorkTime.text = "Absent"
            cell.labelWorkTime.textColor = UIColor.red
        } else if shift.status == "holiday" {
            cell.constraint_height_labelWorkTime.constant = 80
            cell.constraint_height_labelPremisesTime.constant = 0
            cell.labelWorkTime.text = "Holiday"
            cell.labelWorkTime.textColor = UIColor.blue
        }
        
        return cell
    }
    
    
}

extension ShiftsVC: FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if self.viewModel.selectedDate == .startDate {
            // Start date
            self.viewModel.startDate = date
            self.viewModel.setDisplayStrings()
        } else {
            self.viewModel.endDate = date
            self.viewModel.setDisplayStrings()
        }
        
        self.setDateButtonTexts()
    }
}

extension ShiftsVC: FilterViewDelegate {
    func dateButtonAction(_ sender: RoundedButton) {
        if sender.tag == 1 {
            sender.backgroundColor = TimelyColors.shared.kColorFilterButtonSelected
            self.filterView.buttonEndDate.backgroundColor = TimelyColors.shared.kColorFilterButtonNormal
            self.viewModel.selectedDate = .startDate
            self.filterView.calendarFilter.select(self.viewModel.startDate, scrollToDate: true)
        } else {
            sender.backgroundColor = TimelyColors.shared.kColorFilterButtonSelected
            self.filterView.buttonStartDate.backgroundColor = TimelyColors.shared.kColorFilterButtonNormal
            self.viewModel.selectedDate = .endDate
            self.filterView.calendarFilter.select(self.viewModel.endDate, scrollToDate: true)
        }
    }
    
    func clearFilter(_ sender: UIButton) {
        self.viewModel.setDefaultFilter()
        self.setDateButtonTexts()
        self.filterView.clearSelectables()
        self.filterView.calendarFilter.select(self.viewModel.startDate, scrollToDate: true)
    }
    
    func applyFilter(_ sender: UIButton) {
        self.viewModel.startDateString = self.viewModel.startDateMilliSeconds(startDate: self.viewModel.startDate)
        self.viewModel.endDateString = self.viewModel.endDateMilliSeconds(endDate: self.viewModel.endDate)
        self.setDateButtonTexts()
        self.showFilter()
    }
}
