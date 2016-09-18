import UIKit
import SwiftCharts
import FirebaseDatabase

class ImportedJsonViewController: UIViewController {

    // Class Properties
	
	var dataRef: FIRDatabaseReference?
	var trumps = [Trump]()
	var clintons = [Clinton]()
	
	// MARK: - Setting Up The View
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.dataRef = FIRDatabase.database().reference().child("data")
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(true)
		
		self.pullDataFromFirebase()
	}
	
	func pullDataFromFirebase() {
		self.dataRef?.observe(.childAdded, with: { (snapshot) in
			if let dict = snapshot.value as? [String:Any] {
				if dict["id"] as! String == "trump" {
					let trump = Trump(id: dict["id"] as! String, score: dict["score"] as! Double, time: dict["time"] as! String)
					self.trumps.append(trump)
				} else {
					let clinton = Clinton(id: dict["id"] as! String, score: dict["score"] as! Double, time: dict["time"] as! String)
					self.clintons.append(clinton)
					print(self.clintons)
				}
			}
		})
	}
}


