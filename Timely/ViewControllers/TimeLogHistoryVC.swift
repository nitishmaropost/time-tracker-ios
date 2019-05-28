//
//  TimeLogHistoryVC.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import SkeletonView
import DateTimePicker

class TimeLogHistoryVC: UIViewController {

    @IBOutlet weak var tableLogs: UITableView!
    @IBOutlet weak var viewModel: TimeLogHistoryVM!
    @IBOutlet weak var constraint_top_filter: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_filter: NSLayoutConstraint!
    @IBOutlet weak var buttonFilterStartDate: UIButton!
    @IBOutlet weak var buttonFilterEndDate: UIButton!
    var picker: DateTimePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.title = "Time Log"
        self.tableLogs.register(TimeLogHistoryCell.self, forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.register(UINib(nibName: "TimeLogHistoryCell", bundle: nil), forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.estimatedRowHeight = 80
        self.constraint_top_filter.constant = -80
        self.constraint_height_filter.constant = 0
        self.setDateButtonTexts()
        self.viewModel.getTimeLogHistory(requestDict: ["start_date": self.viewModel.startDateString, "end_date": self.viewModel.endDateString]) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableLogs.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    @IBAction func displayFilter(_ sender: UIBarButtonItem) {
        
        UIView.animate(withDuration: 0.5) {
            if self.constraint_height_filter.constant == 0 {
                self.constraint_height_filter.constant = 105
                self.constraint_top_filter.constant = 20
            } else {
                self.constraint_height_filter.constant = 0
                self.constraint_top_filter.constant = -80
            }
            
            self.view.layoutIfNeeded()
        }
    }
    
    func setDateButtonTexts() {
        self.buttonFilterStartDate.setTitle("Start Date\n\(self.viewModel.startDateDisplayString ?? "")", for: .normal)
        self.buttonFilterEndDate.setTitle("End Date\n\(self.viewModel.endDateDisplayString ?? "")", for: .normal)
    }
    
    @IBAction func applyFilter(_ sender: UIButton) {
        self.viewModel.startDateString = self.viewModel.startDateMilliSeconds(startDate: self.viewModel.startDate)
        self.viewModel.endDateString = self.viewModel.endDateMilliSeconds(endDate: self.viewModel.endDate)
        self.setDateButtonTexts()
        self.viewModel.getTimeLogHistory(requestDict: ["start_date": self.viewModel.startDateString, "end_date": self.viewModel.endDateString]) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableLogs.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    @IBAction func clearFilter(_ sender: UIButton) {
        self.viewModel.setDefaultFilter()
        self.setDateButtonTexts()
        self.viewModel.getTimeLogHistory(requestDict: ["start_date": self.viewModel.startDateString, "end_date": self.viewModel.endDateString]) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableLogs.reloadData()
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
//        let min = Date()
        let min = Calendar.current.date(
            byAdding: .year,
            value: -1,
            to: Date())
        let max = Date().addingTimeInterval(60 * 60 * 24 * 1000)
        self.picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.highlightColor = TimelyColors.shared.kColorNavTitleColor
        picker.doneBackgroundColor = TimelyColors.shared.kColorNavTitleColor
       // picker.isDatePickerOnly = true
        picker.dateFormat = "dd/MM/YYYY"
        picker.completionHandler = { date in
            // do something after tapping done
            if sender.tag == 1 {
                // Start date
                self.viewModel.startDate = date
                self.viewModel.setDisplayStrings()
            } else {
                self.viewModel.endDate = date
                self.buttonFilterEndDate.setTitle("Start Date\n\(self.picker.selectedDateString)", for: .normal)
                self.viewModel.setDisplayStrings()
            }
            
            self.setDateButtonTexts()
        }
        
        picker.show()
    }
}

extension TimeLogHistoryVC: UITableViewDelegate {
    
}

extension TimeLogHistoryVC: SkeletonTableViewDataSource {
    
  
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "timeLogHistoryCell"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel.timeLogDetails?.rows!.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeLogHistoryCell") as? TimeLogHistoryCell
        cell!.selectionStyle = .none
        cell?.hideSkeleton()
        cell?.contentView.backgroundColor = UIColor(hexString: "#E8E8E8")
        cell?.labelTime.backgroundColor = UIColor(hexString: "#E8E8E8")
        cell?.labelPinType.backgroundColor = UIColor(hexString: "#E8E8E8")
        let timeLog = self.viewModel.timeLogDetails?.rows![indexPath.row]
        let previousRow: TimeLog!
        if indexPath.row > 0 {
            previousRow = self.viewModel.timeLogDetails?.rows![indexPath.row - 1]
            let datesSame = self.viewModel.dateStringDifferent(currentRowDateString: timeLog!.punchTime!, previousRowDateString: previousRow.punchTime!)
            if datesSame == false{
                cell?.constrint_height_header.constant = 0
            } else {
                cell?.labelHeader.text = "  \(timeLog?.punchTime?.components(separatedBy: "T")[0] ?? "")"
            }
        } else {
            cell?.labelHeader.text = "  \(timeLog?.punchTime?.components(separatedBy: "T")[0] ?? "")"
            cell?.constrint_height_header.constant = 50
        }
        
        cell?.labelTime.text = self.viewModel.getTimeString(dateString: timeLog!.punchTime!)
        cell?.labelPinType.text = timeLog?.pinType
    
        return cell!
    }
}
