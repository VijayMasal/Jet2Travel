//
//  EmployeeDetailView.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 06/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import UIKit

class EmployeeDetailView: UIViewController {
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var empAge: UILabel!
    @IBOutlet weak var empSalary: UILabel!
    @IBOutlet weak var empName: UILabel!
    var employeeModel : Employee!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Employee Details"
        backView.layer.shadowColor = UIColor.lightGray.cgColor
        backView.layer.shadowOpacity = 1
        backView.layer.shadowOffset = CGSize.zero
        backView.layer.shadowRadius = 5
        backView.layer.cornerRadius = 5
    }
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(true)
        empName.text = employeeModel.employee_name
        empSalary.text = employeeModel.employee_salary
        empAge.text = (employeeModel.employee_age)
    }
    

   

}
