//
//  NetworkClass.swift
//  Jet2Travel
//
//  Created by Vijay Masal on 05/03/20.
//  Copyright © 2020 Vijay Masal. All rights reserved.
//

import Foundation

final class NetworkClass:NSObject{
    
    static let sharedInstance = NetworkClass()
    
    private override init() {}
    
    var baseURL = "http://dummy.restapiexample.com/api/v1/employees"
    
    //parse employee data from api into employee model
    func excuteNetworkCall(completionHandler:@escaping ([Employee]?,Error?) ->Void)
    {
         var employeeArray = [Employee]()
        guard let url = URL(string: baseURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
        guard let dataResponse = data,error == nil else
        {
            completionHandler(nil,error)
           print(error?.localizedDescription ?? "Response Error")
           return
              }
            do{
                let jsonResponse = try JSONSerialization.jsonObject(with:
                                       dataResponse, options: [])
                //get json response into dict
                let jsonDict = jsonResponse as? [String : Any]
                
                //get Data from jsondict into array of Any type
                 let dataArray = jsonDict!["data"] as? [Any]
                
                
                 let jsonArray = dataArray as? [[String: Any]]
                
                //get all employee details into employee model
                for dic in jsonArray!
               {
                var employee = Employee()
                if let employee_name = dic["employee_name"] as? String  {
                        print("employee_name == \(employee_name)")
                        employee.employee_name = employee_name
                  }
                 
                  if let employee_salary = dic["employee_salary"] as? String  {
                        print("employee_salary == \(employee_salary)")
                        employee.employee_salary = employee_salary
                  }
                
                  if let employee_age = dic["employee_age"] as? String  {
                        print("employee_age == \(employee_age)")
                        employee.employee_age = employee_age
                  }
                
                  if let profile_image = dic["profile_image"] as? String  {
                        print("profile_image == \(profile_image)")
                        employee.profile_image = profile_image
                  }
                  
                  if let employee_id = dic["id"] as? String  {
                        print("employee_id == \(employee_id)")
                        employee.employeeId = employee_id
                  }
                
                    employeeArray.append(employee)
                }
                 completionHandler(employeeArray,nil)
            
             } catch let parsingError {
                print("Error", parsingError)
                completionHandler(nil,error)
           }
        }
        task.resume()
        
    }
}

