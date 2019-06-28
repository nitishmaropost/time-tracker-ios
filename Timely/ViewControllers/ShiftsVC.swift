//
//  ShiftsVC.swift
//  Timely
//
//  Created by maropost on 28/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class ShiftsVC: UIViewController {

    @IBOutlet weak var labelUserName: UILabel!
    @IBOutlet weak var labelWorkTime: UILabel!
    @IBOutlet weak var labelPremisesTime: UILabel!
    @IBOutlet weak var labelPresents: UILabel!
    @IBOutlet weak var labelAbsents: UILabel!
    @IBOutlet weak var tableShifts: UITableView!
    
    // Variables
    var rowShift: RowsShift!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Shifts"
        self.tableShifts.register(ShiftCell.self, forCellReuseIdentifier: "ShiftCell")
        self.tableShifts.register(UINib(nibName: "ShiftCell", bundle: nil), forCellReuseIdentifier: "ShiftCell")
        self.setUIValues()
    }
    
    func setUIValues() {
        self.labelUserName.text = self.rowShift.userData.fullName
        self.labelWorkTime.text = "Work Time :  \(self.rowShift.workTime!/3600) hrs"
        self.labelPremisesTime.text = "Premises Time : \(self.rowShift.onPremisesTime!/3600) hrs"
        self.labelPresents.text = "Presents : \(self.rowShift.presents ?? 0)"
        self.labelAbsents.text = "Absents : \(self.rowShift.absents ?? 0)"
    }
    
    @IBAction func openLogs(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: TimelyConstants.shared.segue_shifts_to_logs, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! TimeLogHistoryVC
        vc.viewModel.navType = .today
        vc.viewModel.setInitialDates()
        vc.viewModel.empCode = "\(self.rowShift.shifts?[0].empCode ?? 0)"
    }
}

extension ShiftsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
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
