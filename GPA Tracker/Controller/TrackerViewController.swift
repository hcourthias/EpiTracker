//
//  TrackerViewController.swift
//  GPA Tracker
//
//  Created by Hugo Courthias on 10/03/2019.
//  Copyright © 2019 Hugo Courthias. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import UICircularProgressRing

class TrackerViewController: UIViewController {
    
    var AUTOLOGIN_URL = ""
    let studentDataModel = StudentDataModel()
    
    @IBOutlet weak var promoLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gpaLabel: UILabel!
    @IBOutlet weak var logTimeLabel: UILabel!
    @IBOutlet weak var creditsLabel: UILabel!
    @IBOutlet weak var logTimeProgressBar: UICircularProgressRing!
    @IBOutlet weak var creditsProgressBar: UICircularProgressRing!
    @IBOutlet weak var gpaProgressBar: UICircularProgressRing!
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent } 
    override func viewDidLoad() {
        super.viewDidLoad()
        

        getUserInformation();
    }
    
    func getUserInformation() {
        Alamofire.request(AUTOLOGIN_URL + "/user/?format=json", method: .get).responseJSON { response in
            if response.result.isSuccess {
                let stat: JSON = JSON(response.result.value!)
                print(stat)
                self.updateUserInformation(json: stat)
            }
            else {
            }
        }
    }
    
    func updateUserInformation(json: JSON) {
        studentDataModel.gpa = json["gpa"][0]["gpa"].doubleValue
        studentDataModel.logTime = json["nsstat"]["active"].doubleValue
        studentDataModel.credits = json["credits"].intValue
        studentDataModel.name = json["title"].stringValue
        studentDataModel.promo = json["promo"].intValue


        updateUI()
    }
    
    func updateUI() {
        nameLabel.text = studentDataModel.name
        promoLabel.text = "Promo " + String(studentDataModel.promo)
        gpaLabel.text = String(studentDataModel.gpa)
        logTimeLabel.text = String(studentDataModel.logTime)
        creditsLabel.text = String(studentDataModel.credits)
        logTimeProgressBar.startProgress (to: CGFloat(studentDataModel.logTime),duration:  1)
        creditsProgressBar.startProgress(to: CGFloat(studentDataModel.credits),duration:  1)
        gpaProgressBar.startProgress (to:CGFloat(studentDataModel.gpa),duration:  1)


        
    }
}
