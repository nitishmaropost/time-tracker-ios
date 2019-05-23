//
//  HomeVC.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
import DateTimePicker
import Charts

class HomeVC: UIViewController, ChartViewDelegate {
    
    // IBOutlets
    @IBOutlet weak var barChartView: BarChartView!
    @IBOutlet weak var collectionViewInOut: UICollectionView!
    @IBOutlet weak var buttonHistory: RoundedButton!
    @IBOutlet weak var scrollViewHome: UIScrollView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageViewIn: UIImageView!
    @IBOutlet weak var imageViewOut: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.title = "Timely"
        self.collectionViewInOut.register(InOutCollectionCell.self, forCellWithReuseIdentifier: "inOutCell")
        self.collectionViewInOut.register(UINib(nibName: "InOutCollectionCell", bundle: Bundle.main), forCellWithReuseIdentifier: "inOutCell")
        self.collectionViewInOut.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        TimelyColorsUtility.shared.changeTint(forImage: self.imageViewIn, color: TimelyColors.shared.kInTint)
        TimelyColorsUtility.shared.changeTint(forImage: self.imageViewOut, color: TimelyColors.shared.kOutTint)
        self.configureChart()
        self.setDataCount()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //self.scrollViewHome.contentSize = self.containerView.frame.size
        self.scrollViewHome.contentSize = CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height + 88)
    }
    
    @IBAction func showHistory(_ sender: RoundedButton) {
        self.performSegue(withIdentifier: TimelyConstants.shared.segue_home_to_history, sender: nil)
    }
    
    func setDataCount() {
        
        let entry1 = BarChartDataEntry(x: 1, y: 8)
        let entry2 = BarChartDataEntry(x: 2, y: 9)
        let entry3 = BarChartDataEntry(x: 3, y: 6)
        let entry4 = BarChartDataEntry(x: 4, y: 4)
        let entry5 = BarChartDataEntry(x: 5, y: 9)
        let entry6 = BarChartDataEntry(x: 6, y: 8)
        let entry7 = BarChartDataEntry(x: 7, y: 7)
        
        let set11 = BarChartDataSet(entries: [entry1, entry2, entry3, entry4, entry5, entry6, entry7], label: "")
        
        set11.colors = ChartColorTemplates.material()
        set11.drawValuesEnabled = false
        let data = BarChartData(dataSet: set11)
        data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
        data.barWidth = 0.9
        barChartView.data = data
        barChartView.leftAxis.axisMaximum = 10
        barChartView.animate(yAxisDuration: 2, easingOption: .easeInBounce)
    }
    
    func configureChart() {
        
        barChartView.chartDescription?.enabled = false
        
        barChartView.dragEnabled = false
        barChartView.setScaleEnabled(false)
        barChartView.pinchZoomEnabled = false
        barChartView.highlightFullBarEnabled = false
        barChartView.highlightPerTapEnabled = false
        var xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        
        barChartView.rightAxis.enabled = false
        
        barChartView.drawBarShadowEnabled = false
        barChartView.drawValueAboveBarEnabled = false
        
        barChartView.maxVisibleCount = 60
        
        xAxis.drawAxisLineEnabled = false
        xAxis.drawGridLinesEnabled = false
        xAxis = barChartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 10)
        xAxis.granularity = 1
        xAxis.labelCount = 7
        xAxis.valueFormatter = DayAxisValueFormatter(chart: barChartView)
        
        barChartView.xAxis.gridColor = .clear
        barChartView.leftAxis.gridColor = .clear
        barChartView.rightAxis.gridColor = .clear
        
        
        let leftAxisFormatter = NumberFormatter()
        leftAxisFormatter.minimumFractionDigits = 0
        leftAxisFormatter.maximumFractionDigits = 9
        //
        let leftAxis = barChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 9
        leftAxis.axisMinimum = 0
        
        barChartView.legend.enabled = false
    }
    
    @IBAction func showDatePicker(_ sender: UIBarButtonItem) {
        let min = Date()
        let max = Date().addingTimeInterval(60 * 60 * 24 * 1000)
        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
        
        picker.highlightColor = TimelyColors.shared.kColorOrangeTheme
        picker.doneBackgroundColor = TimelyColors.shared.kColorOrangeTheme
        picker.isDatePickerOnly = true
        picker.dateFormat = "dd/MM/YYYY"
        picker.completionHandler = { date in
            // do something after tapping done
        }
        
        picker.show()
    }
}

extension HomeVC: UICollectionViewDelegate {
    
}

extension HomeVC: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inOutCell", for: indexPath) as! InOutCollectionCell
        
//        switch indexPath.row {
//        case 0:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[0]
//        case 1:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[1]
//        case 2:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[2]
//        case 3:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[3]
//        case 4:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[4]
//        case 5:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[2]
//        case 6:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[0]
//        case 7:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[4]
//        case 8:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[1]
//        case 9:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[3]
//        default:
//            cell.backgroundColor = TimelyColors.shared.kColorArray[0]
//        }
        
        
        return cell
    }
    
    
}
