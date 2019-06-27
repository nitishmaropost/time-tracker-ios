//
//  UsersVC.swift
//  Timely
//
//  Created by maropost on 27/06/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class UsersVC: UIViewController {
    
    @IBOutlet weak var tableUsers: UITableView!
    @IBOutlet weak var viewModel: AttendanceVM!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        self.tableUsers.register(TimeLogHistoryCell.self, forCellReuseIdentifier: "userCell")
        self.tableUsers.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
        self.viewModel.getAttendanceDetails { (result) in
            self.tableUsers.reloadData()
        }
    }
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}

extension UsersVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = self.viewModel.attendance?.rows!.count else {
            return 8
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        if self.viewModel.attendance != nil {
            cell.hideSkeleton()
            let row = self.viewModel.attendance?.rows![indexPath.section]
            if row?.userData.department == nil {
                cell.constraint_height_labelDepartment.constant = 0
                cell.constraint_top_labelDepartment.constant = 0
            } else {
                cell.labelDepartment.text = row?.userData.department
            }
            
            if row?.userData.position == nil {
                cell.constraint_height_labelPosition.constant = 0
                cell.constraint_top_labelPosition.constant = 0
            } else {
                cell.labelPosition.text = row?.userData.position
            }
            
            cell.labelName.text = row?.userData.fullName
            cell.labelCode.text = "Emp Code : \(row?.userData.employeeCode ?? 0)"
            cell.labelEmail.text = "Email : \(row?.userData.email ?? "-")"
        }
    
        return cell
    }
    
    
}
