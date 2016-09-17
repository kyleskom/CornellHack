import UIKit
import SwiftCharts
import Alamofire

class GraphViewController: UIViewController {
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
	
	func sendPostRequestToMicrosoft() {
		let url = "https://westus.api.cognitive.microsoft.com/text/analytics/v2.0/sentiment"
		
		let header = [
			"Content-Type": "application/json",
			"Ocp-Apim-Subscription-Key": "279e42df273d475d92337bd306daece3"
		]
		
		let json = [
			"documents": [
				"languge": "en",
				"id": "1",
				"text": "hello, how are you my friend?"
			]
		]
		
		// let json2 = "{'documents': [{'language': 'en','id': '1','text': 'sup bro'}]}" 

		Alamofire.request(url, method: .post, parameters: json, encoding: JSONEncoding.default, headers: header).responseJSON { response in
			
			switch response.result {
			case .success:
				print("Validation Successful")
				
				print(response.result.value)
				
			case .failure(let error):
				print(error)
			}
		}
	}
	
	// encoding: JSONEncoding.default,
	
	override func viewDidLoad() {
        super.viewDidLoad()

		self.setUpBarChart()
		self.sendPostRequestToMicrosoft()
    }
}


























