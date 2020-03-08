//
//  ViewController.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 05/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating {
    
    
@IBOutlet weak var employeeTable: UITableView!
   var employeeArray = [Employee]()
    var sortEmployeeArray = [Employee]()
   var filteredEmployeeArray = [Employee]()
    var resultSearchController = UISearchController()
    override func viewDidLoad() {
            super.viewDidLoad()
        self.title = "Employee"
        //add setting button on navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: self, action: #selector(settingTapped))
        
            //UISearchController controller
            resultSearchController = ({
                   let controller = UISearchController(searchResultsController: nil)
                   controller.searchResultsUpdater = self
                controller.obscuresBackgroundDuringPresentation = false
                   controller.searchBar.sizeToFit()
                   employeeTable.tableHeaderView = controller.searchBar

                   return controller
               })()
            self.employeeTable.alpha = 0.0
            
        //call network method for retriving data from api
            NetworkClass.sharedInstance.excuteNetworkCall { employee,error  in
                if let employess = employee{
                    self.sortEmployeeArray = employess
                    self.employeeArray = employess
                DispatchQueue.main.async {
                    self.employeeTable.alpha = 1.0
                    self.employeeTable.reloadData()
                }
                }
                else{
                     DispatchQueue.main.async {
                    self.showAlert(error: error! as NSError)
                    }
                }
                                     

            }
            
           
        }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        let isName = UserDefaults.standard.bool(forKey: "namesort")
        let isage = UserDefaults.standard.bool(forKey: "agesort")
        //Sort employee by name alphabetically
         if(isName == true && isage == false){
           self.employeeArray = sortEmployeeArray.sorted(by: { ($0.employee_name < $1.employee_name) } )
        }////Sort employee by age numerically
        else if((isName == false && isage == true)){
            
        self.employeeArray = sortEmployeeArray.sorted(by: {  ($0.employee_age < $1.employee_age)} )
            
        }else{//show normal data
             self.employeeArray = sortEmployeeArray
        }
        
        DispatchQueue.main.async {
            self.employeeTable.alpha = 1.0
            self.employeeTable.reloadData()
        }
    }
    

    //navigate on setting view 
    @objc func settingTapped(){
        
        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
           self.navigationController?.pushViewController(detailView, animated: true)
                 
              }
           
    
    //show error alert message
        func showAlert(error : NSError)  {
            let alert = UIAlertController(title: error.localizedDescription, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            }))

            self.present(alert, animated: true)
        }
        
    ////Tableview Datasource method
        func numberOfSections(in tableView: UITableView) -> Int {
           return 1
        }
        
    ///Tableview Datasource method
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               if  (resultSearchController.isActive) {
                   return filteredEmployeeArray.count
               } else {
                   return employeeArray.count
               }
           }
           
    ///Tableview Datasource method
           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! EmployeeCell
            
            cell.deleteButton.addTarget(self, action: #selector(deleteEmployee(sender:)), for: .touchUpInside)
            cell.deleteButton.tag = indexPath.row
            
            cell.moveNextButton.addTarget(self, action: #selector(moveEmployeeDetailView(sender:)), for: .touchUpInside)
            cell.moveNextButton.tag = indexPath.row

               if (resultSearchController.isActive) {
                cell.deleteButton.isHidden = true
                let employee = filteredEmployeeArray[indexPath.row]
                cell.employeeName.text = employee.employee_name
                   return cell
               }
               else {
                cell.deleteButton.isHidden = false
                let employee = employeeArray[indexPath.row]
                cell.employeeName.text = employee.employee_name
                   //print(employeeArray[indexPath.row])
                   return cell
               }
           }
        //UISearchResultsUpdating delegate method
        func updateSearchResults(for searchController: UISearchController) {
            self.filteredEmployeeArray.removeAll(keepingCapacity: false)
            let filtered = employeeArray.filter{ $0.employee_name.contains(searchController.searchBar.text!)  || $0.employee_age.contains(searchController.searchBar.text!)}
                  self.filteredEmployeeArray = filtered
                  self.employeeTable.reloadData()
                

        }
        
    //Tableview delegate method
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            moveNext(indexPath: indexPath)
           }
        //Delete employee from employee list
        @objc func deleteEmployee(sender: UIButton){
                if (!resultSearchController.isActive) {
                    showDeleteAlert(sender: sender)
                }
               
           }
    //Show delete employee alert message
    func showDeleteAlert(sender : UIButton)  {
        let employee = employeeArray[sender.tag]
        
        let alert = UIAlertController(title: "Are you sure to delete employee \(employee.employee_name)?", message:nil , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.employeeArray.remove(at: sender.tag)
            DispatchQueue.main.async {
            self.employeeTable.reloadData()
            }
               }))

               self.present(alert, animated: true)
           }
           
           //Navigate to employee detailview when click on disclosure button
           @objc func moveEmployeeDetailView(sender: UIButton){
                if (!resultSearchController.isActive) {
                    let indexPath = IndexPath(item: sender.tag, section: 0)
                    moveNext(indexPath:indexPath)
                }
              
           }
        
        //Navigate to employee detail view
        func moveNext(indexPath: IndexPath) {
            
            let detailView = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeDetailView") as! EmployeeDetailView
                   
                   if (resultSearchController.isActive) {
                      detailView.employeeModel = filteredEmployeeArray[indexPath.row]
                       resultSearchController.isActive = false
                   }else{
                       detailView.employeeModel = employeeArray[indexPath.row]
                       resultSearchController.isActive = false
                   }
                      self.navigationController?.pushViewController(detailView, animated: true)
            
        }
    }

