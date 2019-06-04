//
//  TimeLogHistoryVC.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import SkeletonView
import HGPlaceholders
import FSCalendar

class TimeLogHistoryVC: UIViewController {
    
    @IBOutlet weak var tableLogs: TableView!
    @IBOutlet weak var viewModel: TimeLogHistoryVM!
    @IBOutlet weak var constraint_top_filter: NSLayoutConstraint!
    @IBOutlet weak var constraint_height_filter: NSLayoutConstraint!
    @IBOutlet weak var buttonFilterStartDate: UIButton!
    @IBOutlet weak var buttonFilterEndDate: UIButton!
    var viewBlackOverlay: UIView!
    var filterView: FilterView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.title = "Time Log"
        self.tableLogs.register(TimeLogHistoryCell.self, forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.register(UINib(nibName: "TimeLogHistoryCell", bundle: nil), forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.placeholderDelegate = self
        self.tableLogs.estimatedRowHeight = 130
        self.constraint_top_filter.constant = -80
        self.constraint_height_filter.constant = 0
        self.addFilterView()
        self.setDateButtonTexts()
        self.callTimeDetailsAPI()
        
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
    
    @IBAction func displayFilter(_ sender: UIBarButtonItem) {
        self.showFilter()
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
    
    func setDateButtonTexts() {
        self.filterView.buttonStartDate.setTitle("Start Date\n\(self.viewModel.startDateDisplayString ?? "")", for: .normal)
        self.filterView.buttonEndDate.setTitle("End Date\n\(self.viewModel.endDateDisplayString ?? "")", for: .normal)
    }
    
    func callTimeDetailsAPI() {
        self.viewModel.getTimeLogHistory(requestDict: ["start_date": self.viewModel.startDateString, "end_date": self.viewModel.endDateString]) { (result) in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.tableLogs.reloadData()
                    if self.viewModel.timeLogDetails.rows?.count == 0 {
                        self.tableLogs.showNoResultsPlaceholder()
                    }
                }
            case .error(let error):
                print(error)
            }
        }
    }
    
    @IBAction func showDatePicker(_ sender: UIButton) {
        if sender.tag == 1 {
            self.viewModel.selectedDate = .startDate
        } else {
            self.viewModel.selectedDate = .endDate
        }
    }
}

extension TimeLogHistoryVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        
        return 10
    }
}

extension TimeLogHistoryVC: SkeletonTableViewDataSource {
    
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "timeLogHistoryCell"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = self.viewModel.timeLogDetails?.rows!.count else {
            return 8
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeLogHistoryCell") as? TimeLogHistoryCell
        cell!.selectionStyle = .none
        if self.viewModel.timeLogDetails != nil && self.viewModel.timeLogDetails.rows!.count > 0 {
            cell?.hideSkeleton()
            cell?.labelHeader.backgroundColor = TimelyColors.shared.kColorThemeSplash
            cell?.labelHeader.alpha = 0.8
            let timeLog = self.viewModel.timeLogDetails?.rows![indexPath.section]
            let previousRow: TimeLog!
            if indexPath.section > 0 {
                previousRow = self.viewModel.timeLogDetails?.rows![indexPath.section - 1]
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
            if (timeLog?.pinType?.contains("In"))! {
                cell?.labelPinType.textColor = TimelyColors.shared.kInTint
            } else {
                cell?.labelPinType.textColor = TimelyColors.shared.kOutTint
            }
        } else {
            cell?.labelTime.showAnimatedGradientSkeleton()
            cell?.labelHeader.showAnimatedGradientSkeleton()
            cell?.labelPinType.showAnimatedGradientSkeleton()
        }
        
        
        return cell!
    }
}

extension TimeLogHistoryVC: PlaceholderDelegate {
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        self.callTimeDetailsAPI()
    }
}

extension TimeLogHistoryVC: FSCalendarDelegate {
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

extension TimeLogHistoryVC: FilterViewDelegate {
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
        self.callTimeDetailsAPI()
    }
    
    func applyFilter(_ sender: UIButton) {
        self.viewModel.startDateString = self.viewModel.startDateMilliSeconds(startDate: self.viewModel.startDate)
        self.viewModel.endDateString = self.viewModel.endDateMilliSeconds(endDate: self.viewModel.endDate)
        self.setDateButtonTexts()
        self.showFilter()
        self.callTimeDetailsAPI()
    }
}
