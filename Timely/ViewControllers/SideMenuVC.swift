//
//  SideMenuVC.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {

    var items: [MenuItem]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupMenuItems()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 0)
        
        let labelFooter = UILabel(frame: CGRect(x: 20, y: self.view.frame.size.height - 80, width: 300, height: 20))
        labelFooter.text = "Version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "")"
        labelFooter.textColor = UIColor.darkGray
        self.view.addSubview(labelFooter)
    }
    
    func setupMenuItems() {
        self.items = [MenuItem]()
        self.items?.append(MenuItem(title: "Home", image: UIImage(named: "home.png")!))
        self.items?.append(MenuItem(title: "Attendance", image: UIImage(named: "attendance.png")!))
        self.items?.append(MenuItem(title: "Timesheet", image: UIImage(named: "timesheet.png")!))
        self.items?.append(MenuItem(title: "Settings", image: UIImage(named: "settings.png")!))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items!.count + 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 200
        }
        
        return 60
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.selectionStyle = .none
        if indexPath.row == 0 {
            let imageView = UIImageView(frame: CGRect(x: cell.frame.size.width/2 - 106, y: 0, width: 212, height: 143))
            imageView.image = UIImage(named: "logo.png")
            cell.contentView.addSubview(imageView)
            
            let labeltitle = UILabel(frame: CGRect(x: 0, y: 150, width: self.view.frame.size.width, height: 25))
            labeltitle.text = UserDefaults.standard.object(forKey: "fullName") as? String
            labeltitle.textColor = TimelyColors.shared.kColorRedTheme
            labeltitle.textAlignment = .center
            labeltitle.font = UIFont(name: "Lato", size: 22)
            cell.contentView.addSubview(labeltitle)
            
            let labelEmail = UILabel(frame: CGRect(x: 0, y: 180, width: self.view.frame.size.width, height: 25))
            labelEmail.text = UserDefaults.standard.object(forKey: "email") as? String
            labelEmail.textColor = UIColor.blue
            labelEmail.textAlignment = .center
            labelEmail.font = UIFont(name: "Lato", size: 18)
            cell.contentView.addSubview(labelEmail)
        } else {
            let item = self.items![indexPath.row - 1]
            cell.textLabel?.text = item.title
            cell.imageView?.image = item.image
        }
        
        cell.textLabel?.font = UIFont(name: "Lato", size: 20)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.textAlignment = .left
        
        return cell
    }
}
