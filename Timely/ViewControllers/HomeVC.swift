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
    
    enum Navigations {
     case today
    case week
    case month
    }
    
    var navType: Navigations!
    
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
        self.addViewGestures()
    }
    
    func addViewGestures() {
        var tap = UITapGestureRecognizer(target: self, action: #selector(self.checkLogDetails(_:)))
        self.viewTodayHours.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.checkLogDetails(_:)))
        self.viewWeekHours.addGestureRecognizer(tap)
        tap = UITapGestureRecognizer(target: self, action: #selector(self.checkLogDetails(_:)))
        self.viewMonthHours.addGestureRecognizer(tap)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        let vc = segue.destination as! TimeLogHistoryVC
        switch self.navType {
        case .today?:
            vc.viewModel.startDate = Date()
            vc.viewModel.endDate = Date()
        case .week?:
            vc.viewModel.startDate = Date().startOfWeek
            vc.viewModel.endDate = Date().endOfWeek
        case .month?:
            vc.viewModel.startDate = Date().startOfMonth
            vc.viewModel.endDate = Date().endOfMonth
        default:
            print("Error")
        }
    }
    
   @objc func checkLogDetails(_ gesture: UITapGestureRecognizer) {
        let view = gesture.view
        switch view?.tag {
        case 1:
            self.navType = .today
        case 2:
            self.navType = .week
        case 3:
            self.navType = .month
        default:
            print("Error showing the log details")
        }
        
        self.performSegue(withIdentifier: TimelyConstants.shared.segue_home_to_history, sender: nil)
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

    }
}
