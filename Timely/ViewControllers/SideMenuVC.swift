//
//  SideMenuVC.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit

class SideMenuVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.contentInset = UIEdgeInsets(top: 30, left: 5, bottom: 0, right: 0)
        
        let labelFooter = UILabel(frame: CGRect(x: 20, y: 10, width: 300, height: 20))
        labelFooter.text = "Version \(Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") ?? "")"
        labelFooter.textColor = UIColor.darkGray
       // labelFooter.textAlignment = .right
        self.tableView.tableFooterView = labelFooter
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260
        }
        
        return 80
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            let imageView = UIImageView(frame: CGRect(x: cell.frame.size.width/2 - 105, y: 0, width: 200, height: 200))
            imageView.image = UIImage(named: "test_user.png")
            imageView.layer.cornerRadius = (imageView.frame.size.width)/2
            imageView.layer.borderColor = UIColor.lightGray.cgColor
            imageView.layer.borderWidth = 2
            imageView.clipsToBounds = true
            cell.contentView.addSubview(imageView)
            
            let labeltitle = UILabel(frame: CGRect(x: 0, y: 210, width: self.view.frame.size.width, height: 25))
            labeltitle.text = "John Gloom"
            labeltitle.textColor = TimelyColors.shared.kColorRedTheme
            labeltitle.textAlignment = .center
            labeltitle.font = UIFont(name: "Lato", size: 24)
            cell.contentView.addSubview(labeltitle)
            
            let labelEmail = UILabel(frame: CGRect(x: 0, y: 240, width: self.view.frame.size.width, height: 25))
            labelEmail.text = "jgloom@gmail.com"
            labelEmail.textColor = UIColor.blue
            labelEmail.textAlignment = .center
            labelEmail.font = UIFont(name: "Lato", size: 20)
            cell.contentView.addSubview(labelEmail)
            
        case 1:
            cell.textLabel?.text = "Calendar"
            cell.imageView?.image = UIImage(named: "calendar.png")
        case 2:
            cell.textLabel?.text = "Terms"
            cell.imageView?.image = UIImage(named: "terms.png")
        case 3:
            cell.textLabel?.text = "Check-in"
            cell.imageView?.image = UIImage(named: "check_in.png")
        case 4:
            cell.textLabel?.text = "Leave"
            cell.imageView?.image = UIImage(named: "leave.png")
        case 5:
            cell.textLabel?.text = "About Us"
            cell.imageView?.image = UIImage(named: "about_us.png")
            
        default:
            print("")
        }
        
        cell.textLabel?.font = UIFont(name: "Lato", size: 20)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.textLabel?.textAlignment = .left
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
