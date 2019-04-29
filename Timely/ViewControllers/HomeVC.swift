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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Timely"
        self.configureChart()
        self.updateChartData()
    }
    
    func updateChartData() {
        self.setDataCount(5, range: 1)
    }
    
    func setDataCount(_ count: Int, range: UInt32) {
        let start = 1
        
        let yVals = (start..<start+count+1).map { (i) -> BarChartDataEntry in
            let mult = range + 1
            let val = Double(arc4random_uniform(mult))
            if arc4random_uniform(100) < 25 {
                return BarChartDataEntry(x: Double(i), y: val, icon: UIImage(named: "icon"))
            } else {
                return BarChartDataEntry(x: Double(i), y: val)
            }
        }
        
        var set1: BarChartDataSet! = nil
        if let set = barChartView.data?.dataSets.first as? BarChartDataSet {
            set1 = set
            set1.replaceEntries(yVals)
            barChartView.data?.notifyDataChanged()
            barChartView.notifyDataSetChanged()
        } else {
            set1 = BarChartDataSet(entries: yVals, label: "The year 2017")
            set1.colors = ChartColorTemplates.material()
            set1.drawValuesEnabled = false
            
            let data = BarChartData(dataSet: set1)
            data.setValueFont(UIFont(name: "HelveticaNeue-Light", size: 10)!)
            data.barWidth = 0.9
            barChartView.data = data
        }
        
        //        chartView.setNeedsDisplay()
    }
    
    func configureChart() {
        
        barChartView.chartDescription?.enabled = false
        
        barChartView.dragEnabled = true
        barChartView.setScaleEnabled(true)
        barChartView.pinchZoomEnabled = false
        
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
        
        let leftAxis = barChartView.leftAxis
        leftAxis.labelFont = .systemFont(ofSize: 10)
        leftAxis.labelCount = 8
        leftAxis.valueFormatter = DefaultAxisValueFormatter(formatter: leftAxisFormatter)
        leftAxis.labelPosition = .outsideChart
        leftAxis.spaceTop = 9
        leftAxis.axisMinimum = 0 // FIXME: HUH?? this replaces startAtZero = YES
        
//        let rightAxis = barChartView.rightAxis
//        rightAxis.enabled = true
//        rightAxis.labelFont = .systemFont(ofSize: 10)
//        rightAxis.labelCount = 8
//        rightAxis.valueFormatter = leftAxis.valueFormatter
//        rightAxis.spaceTop = 0.15
//        rightAxis.axisMinimum = 0
        
        let l = barChartView.legend
        l.horizontalAlignment = .left
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        l.form = .circle
        l.formSize = 9
        l.font = UIFont(name: "HelveticaNeue-Light", size: 11)!
        l.xEntrySpace = 4
        //        chartView.legend = l
        
        let marker = XYMarkerView(color: UIColor(white: 180/250, alpha: 1),
                                  font: .systemFont(ofSize: 12),
                                  textColor: .white,
                                  insets: UIEdgeInsets(top: 8, left: 8, bottom: 20, right: 8),
                                  xAxisValueFormatter: barChartView.xAxis.valueFormatter!)
        marker.chartView = barChartView
        marker.minimumSize = CGSize(width: 80, height: 40)
        barChartView.marker = marker
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
