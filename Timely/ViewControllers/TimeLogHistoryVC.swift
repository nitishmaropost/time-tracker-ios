//
//  TimeLogHistoryVC.swift
//  Timely
//
//  Created by maropost on 21/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import SkeletonView

class TimeLogHistoryVC: UIViewController {

    @IBOutlet weak var tableLogs: UITableView!
    @IBOutlet weak var viewModel: TimeLogHistoryVM!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI() {
        self.title = "Time Log"
        self.tableLogs.register(TimeLogHistoryCell.self, forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.register(UINib(nibName: "TimeLogHistoryCell", bundle: nil), forCellReuseIdentifier: "timeLogHistoryCell")
        self.tableLogs.estimatedRowHeight = 80
        self.viewModel.getTimeLogHistory { (result) in
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
}

extension TimeLogHistoryVC: UITableViewDelegate {
    
}

extension TimeLogHistoryVC: UITableViewDataSource {
    
  
//    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return "timeLogHistoryCell"
//    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = self.viewModel.timeLogDetails?.rows!.count else {
            return 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "timeLogHistoryCell") as? TimeLogHistoryCell
        cell!.selectionStyle = .none
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
        cell?.labelPinType.text = self.viewModel.returnPinTypeString(pinType: "\(timeLog?.pinType ?? 0)")
    
        return cell!
    }
}
