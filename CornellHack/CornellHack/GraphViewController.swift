import UIKit
import SwiftCharts
import FirebaseDatabase

class GraphViewController: UIViewController {
	
	var tweetsRef: FIRDatabaseReference?
	var trumpScores = [Double]()
	var clintonScores = [Double]()
	
	// MARK: - Setting Up The View
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setUpBarChart()
		
		self.tweetsRef = FIRDatabase.database().reference().child("tweets")
	}

	func pullFromTrump() {
		self.tweetsRef?.child("trump").observe(.childAdded, with: { (snapshot) in
			if let sentimentScoreDict = snapshot.value as? [String: Any] {
				
				if let score = sentimentScoreDict["sentimentScore"] as? Double {
					
					self.trumpScores.append(score)
				}
				
				print(self.trumpScores)
			} else {
				print("doesnt work")
			}
		})
	}
	
//	func pullFromClinton() {
//		self.tweetsRef?.child("clinton").observe(.childAdded, with: { (snapshot) in
//			
//		})
//	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		
		self.pullFromTrump()
		//self.pullFromClinton()
	}
	
	
	
	func setUpLineChart() {
		let chartConfig = ChartConfigXY(
			xAxisConfig: ChartAxisConfig(from: 2, to: 14, by: 2),
			yAxisConfig: ChartAxisConfig(from: 0, to: 14, by: 2)
		)
		
		let chart = LineChart(
			frame: CGRect(x: 0, y: 70, width: 300, height: 500),
			chartConfig: chartConfig,
			xTitle: "X axis",
			yTitle: "Y axis",
			lines: [
				(chartPoints: [(2.0, 10.6), (4.2, 5.1), (7.3, 3.0), (8.1, 5.5), (14.0, 8.0)], color: UIColor.red),
				(chartPoints: [(2.0, 2.6), (4.2, 4.1), (7.3, 1.0), (8.1, 11.5), (14.0, 3.0)], color: UIColor.blue)
			]
		)
		
		self.view.addSubview(chart.view)
	}
	
	func setUpBarChart() {
		let chartConfig = BarsChartConfig(
			valsAxisConfig: ChartAxisConfig(from: 0, to: 8, by: 2)
		)
		
		let chart = BarsChart(
			frame: CGRect(x: 0, y: 70, width: 300, height: 500),
			chartConfig: chartConfig,
			xTitle: "X axis",
			yTitle: "Y axis",
			bars: [
				("A", 2),
				("B", 4.5),
				("C", 3),
				("D", 5.4),
				("E", 6.8),
				("F", 0.5)
			],
			color: UIColor.red,
			barWidth: 20
		)
		
		self.view.addSubview(chart.view)
	}
	
}
























