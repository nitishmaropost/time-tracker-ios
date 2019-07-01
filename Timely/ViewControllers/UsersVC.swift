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
    @IBOutlet weak var searchBarUsers: UISearchBar!
    @IBOutlet weak var viewModel: AttendanceVM!
    var searchActive : Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Users"
        self.tableUsers.register(TimeLogHistoryCell.self, forCellReuseIdentifier: "userCell")
        self.tableUsers.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "userCell")
        self.viewModel.getAttendanceDetails { (result) in
            self.tableUsers.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ShiftsVC
        vc.rowShift = self.viewModel.selectedRow
    }
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var row: RowsShift?
        if self.searchActive {
            row = self.viewModel.filteredUsers[indexPath.section]
        } else {
            row = self.viewModel.attendance?.rows![indexPath.section]
        }
        
        self.viewModel.selectedRow = row
        self.performSegue(withIdentifier: TimelyConstants.shared.segue_users_to_shifts, sender: nil)
    }
}

extension UsersVC: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if self.searchActive {
            return self.viewModel.filteredUsers.count
        } else {
            guard let count = self.viewModel.attendance?.rows!.count else {
                return 8
            }
            
            return count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as! UserCell
        if self.viewModel.attendance != nil {
            cell.hideSkeleton()
            
            var row: RowsShift?
            if self.searchActive {
                row = self.viewModel.filteredUsers[indexPath.section]
            } else {
                row = self.viewModel.attendance?.rows![indexPath.section]
            }
            
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

extension UsersVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.filteredUsers = (self.viewModel.attendance?.rows?.filter({ (rowShift) -> Bool in
            let tmp = rowShift.userData.fullName
           
            if tmp!.range(of: searchText, options: .caseInsensitive) != nil {
                return true
            } else {
                return false
            }
        }))!
        
        if self.viewModel.filteredUsers.count == 0 {
            self.searchActive = false
        } else {
            self.searchActive = true
        }
        
        self.tableUsers.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchActive = true;
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchActive = false;
    }
}
