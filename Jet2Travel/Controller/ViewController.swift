//
//  ViewController.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 05/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
@IBOutlet weak var employeeTable: UITableView!
    var employeeArray = [Employee]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = "Employee"
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        NetworkClass.sharedInstance.excuteNetworkCall { employee,error  in
            print("employee \(employee)")
            self.employeeArray = employee
            DispatchQueue.main.async {
                self.employeeTable.reloadData()
            }
                                 

        }
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmployeeCell
        let  emoployee = employeeArray[indexPath.row]
        
        cell.employeeName.text = emoployee.employee_name
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailView") as! EmployeeDetailView
        detailView.employeeModel = employeeArray[indexPath.row]
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


