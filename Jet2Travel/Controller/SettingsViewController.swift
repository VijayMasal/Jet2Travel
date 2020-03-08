//
//  SettingsViewController.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 08/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var ageSwitch: UISwitch!
    @IBOutlet weak var nameSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Settings"
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 5
        backView.layer.cornerRadius = 5
        
        //get name sort flag
        let isName = UserDefaults.standard.bool(forKey: "namesort")
        
        if isName {
            nameSwitch.isOn = true
        }else{
            nameSwitch.isOn = false
        }
        
        //get age sort flag
        let isage = UserDefaults.standard.bool(forKey: "agesort")
        if isage {
                   ageSwitch.isOn = true
               }else{
                   ageSwitch.isOn = false
               }
    }
    
    //sort by name method
    @IBAction func nameSort(_ sender: UISwitch) {
        if (sender.isOn) {
            ageSwitch.isOn = false
             UserDefaults.standard.set(false, forKey: "agesort")
            UserDefaults.standard.set(true, forKey: "namesort")
        }else{
            
            UserDefaults.standard.set(false, forKey: "namesort")
        }
    }
    
    //sort by age method
    @IBAction func ageSort(_ sender: UISwitch) {
        
        if (sender.isOn) {
            nameSwitch.isOn = false
             UserDefaults.standard.set(false, forKey: "namesort")
                   UserDefaults.standard.set(true, forKey: "agesort")
               }else{
                   
                   UserDefaults.standard.set(false, forKey: "agesort")
               }
    }
    

}
