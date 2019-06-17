//
//  LoginViewController.swift
//  GPA Tracker
//
//  Created by Hugo Courthias on 10/03/2019.
//  Copyright © 2019 Hugo Courthias. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    struct defaultsKeys {
        static let autoLog = "";
    }

    @IBOutlet weak var autoLoginTextField: UITextField!
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        let defaults = UserDefaults.standard
        defaults.set(autoLoginTextField.text, forKey: defaultsKeys.autoLog)
        performSegue(withIdentifier: "login", sender: self)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent } 
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard
        autoLoginTextField.delegate = self
        if let stringOne = defaults.string(forKey: defaultsKeys.autoLog) {
            autoLoginTextField.text = stringOne
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        autoLoginTextField.resignFirstResponder()
        return true
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let trackerVC = segue.destination as! TrackerViewController
            trackerVC.AUTOLOGIN_URL
                = autoLoginTextField.text!
        }
        if segue.identifier == "alreadyLogin" {
            let trackerVC = segue.destination as! TrackerViewController
            trackerVC.AUTOLOGIN_URL
                = autoLoginTextField.text!
        }
    }


}
