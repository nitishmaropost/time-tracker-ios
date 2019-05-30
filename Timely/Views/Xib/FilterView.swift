//
//  FilterView.swift
//  Timely
//
//  Created by maropost on 29/05/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

class FilterView: UIView{
    
    @IBOutlet weak var buttonStartDate: RoundedButton!
    @IBOutlet weak var buttonEndDate: RoundedButton!
    @IBOutlet weak var buttonClear: UIButton!
    @IBOutlet weak var buttonApply: UIButton!
    @IBOutlet weak var calendarFilter: FSCalendar!
    var delegate: FilterViewDelegate!
    
    static func instanceFromNib() -> UIView {
        return UINib(nibName: "FilterView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBAction func dateButtonTapped(_ sender: RoundedButton) {
        guard let del = self.delegate else {
            return
        }
        
        del.dateButtonAction(sender)
    }
    
    @IBAction func clearFilter(_ sender: UIButton) {
        guard let del = self.delegate else {
            return
        }
        
        del.clearFilter(sender)
    }
    
    @IBAction func applyilter(_ sender: UIButton) {
        guard let del = self.delegate else {
            return
        }
        
        del.applyFilter(sender)
    }
    
    func setButtonSelectColor(color: UIColor) {
        self.buttonStartDate.setBackgroundColor(color, for: .highlighted)
        self.buttonEndDate.setBackgroundColor(color, for: .highlighted)
    }
    
    func clearSelectables() {
        self.buttonStartDate.backgroundColor = TimelyColors.shared.kColorFilterButtonSelected
        self.buttonEndDate.backgroundColor = TimelyColors.shared.kColorFilterButtonNormal
    }
}

protocol FilterViewDelegate {
    func dateButtonAction(_ sender: RoundedButton)
    func clearFilter(_ sender: UIButton)
    func applyFilter(_ sender: UIButton)
}
