//
//  HomeVC.swift
//  Timely
//
//  Created by maropost on 25/04/19.
//  Copyright © 2019 maropost. All rights reserved.
//

import UIKit
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
    @IBOutlet weak var viewTodayHours: UIView!
    @IBOutlet weak var viewWeekHours: RoundedView!
    @IBOutlet weak var viewMonthHours: RoundedView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Timely"
        TimelyColorsUtility.shared.changeTint(forImage: self.imageViewIn, color: TimelyColors.shared.kInTint)
        TimelyColorsUtility.shared.changeTint(forImage: self.imageViewOut, color: TimelyColors.shared.kOutTint)
        
        self.configureChart()
        self.setDataCount()
        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
        loadingView.tintColor = UIColor.white
        scrollViewHome.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            self?.scrollViewHome.dg_stopLoading()
            }, loadingView: loadingView)
        scrollViewHome.dg_setPullToRefreshFillColor(TimelyColors.shared.kColorNavTitleColor)
        scrollViewHome.dg_setPullToRefreshBackgroundColor(UIColor.white)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.viewTodayHours.setNeedsLayout()
        self.viewTodayHours.layoutIfNeeded()
        self.viewWeekHours.setNeedsLayout()
        self.viewWeekHours.layoutIfNeeded()
        self.viewMonthHours.setNeedsLayout()
        self.viewMonthHours.layoutIfNeeded()
        self.viewTodayHours.setGradientColor(topColor: UIColor(hexString: "#DF342E"), bottomColor: UIColor(hexString: "#ee9491"), cornerRadius: 10, shadowRadius: 4, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 3, shadowColor: UIColor.lightGray, parentView: self.viewTodayHours)
        self.viewWeekHours.setGradientColor(topColor: UIColor(hexString: "#428B28"), bottomColor: UIColor(hexString: "#8fd775"), cornerRadius: 10, shadowRadius: 4, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 3, shadowColor: UIColor.lightGray, parentView: self.viewWeekHours)
        self.viewMonthHours.setGradientColor(topColor: UIColor(hexString: "#007AFF"), bottomColor: UIColor(hexString: "#80bdff"), cornerRadius: 10, shadowRadius: 4, shadowOffset: CGSize(width: 1, height: 1), shadowOpacity: 3, shadowColor: UIColor.lightGray, parentView: self.viewMonthHours)
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
//        let min = Date()
//        let max = Date().addingTimeInterval(60 * 60 * 24 * 1000)
//        let picker = DateTimePicker.create(minimumDate: min, maximumDate: max)
//
//        picker.highlightColor = TimelyColors.shared.kColorNavTitleColor
//        picker.doneBackgroundColor = TimelyColors.shared.kColorNavTitleColor
//        picker.isDatePickerOnly = true
//        picker.dateFormat = "dd/MM/YYYY"
//        picker.completionHandler = { date in
//            // do something after tapping done
//        }
//
//        picker.show()
    }
}

//extension HomeVC: UICollectionViewDelegate {
//
//}
//
//extension HomeVC: UICollectionViewDataSource {
//
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "inOutCell", for: indexPath) as! InOutCollectionCell
//        return cell
//    }
//
//
//}
