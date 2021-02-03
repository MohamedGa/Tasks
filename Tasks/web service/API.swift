//
//  API.swift
//  Budgets
//
//  Created by Mohammed Gamal on 5/22/18.
//  Copyright © 2018 codelabs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API: NSObject {
    
    
    class func facebookLogin(email: String,password: String, completion: @escaping (_ error : Error?, _ success: Bool)->Void) {
        let url = "http://ragaaey.com/tasks/api/loginUser"
        let parameters = ["email" :  email ,
                          "password": password ]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    completion (error, false)
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    
                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                    def.synchronize()
                    completion (nil, true)
                }
        }
    }
    
    class func login ( email: String, password : String, completion: @escaping (_ error : Error?, _ success: Bool)->Void) {
        let url = "http://ragaaey.com/tasks/api/loginUser"
        let parameters = ["email" :  email,
                          "password": password]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    completion (error, false)
                    
                    print(error)
                    
                case.success(let value):
                   
                    print(value)

                    let def = UserDefaults.standard
                    def.setValue(email, forKey: "email")
                  //  def.setValue(password, forKey: "password")
                    def.synchronize()
                    
                        completion (nil, true)
                    }
                
        }
        }
    
    
    
    
    class   func register (  name : String, email: String, password : String, completion: @escaping (_ error : Error?, _ success: Bool,_ state :Bool)->Void) {
                    let url = "http://ragaaey.com/tasks/api/registerUser"
                let parameters = ["name" : name,
                                  "email" : email,
                                  "password" : password]
                
                Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                        .validate(statusCode: 200..<300)
                        .responseJSON { responce in
                            switch responce.result
                            {
                            case .failure(let error):
                                completion (error, false, false)
                                
                                print(error)
                                
                            case.success(let value):
                                guard let userData = value as? [String : [Any]] else {
                                    completion(nil, false, false)
                                    return
                                }
                                guard let array  = userData["userData"] else {
                                    completion(nil, false, false)
                                    return
                                }
                                
                                let exist = array.count == 0
                                if exist {
                                  
                                    let def = UserDefaults.standard
                                    def.setValue(email, forKey: "email")
                                    def.synchronize()
                                    completion(nil, true, true)
                                  
                                    return
                                } else {
                                    let def = UserDefaults.standard
                                    def.setValue(email, forKey: "email")
                                    def.synchronize()
                                    completion (nil, true,false)
                                    return
                                }
                            }
                            }
                }

            class   func forgetPassword (   email: String, completion: @escaping (_ error : Error?, _ success: Bool)->Void) {
                                    let url = "http://ragaaey.com/tasks/api/MessageResetPasswordSent"
                                    let parameters = [
                                                      "email" : email
                                                      ]
                                    
                                    Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                                        .validate(statusCode: 200..<300)
                                        .responseJSON { responce in
                                            switch responce.result
                                            {
                                            case .failure(let error):
                                                completion (error, false)
                                                print(error)
                                                
                                            case.success(let value):
                                                completion (nil, true)
}
                }
    
    
}


    class func getTasks (completion: @escaping (_ error : Error?, _ tasks: [Task])->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }
        let api_token = "111"
        let url = "http://ragaaey.com/tasks/api/all_tasks"
        let parameters = ["email" :  email,
                          "api_token":api_token]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json[""].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var tasks = [Task]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let task = Task()
                        task.t_id = data["t_id"]?.int ?? 0
                        task.t_title = data["t_title"]?.string ?? ""
                        task.t_text = data["t_text"]?.string ?? ""
                        task.t_date = data["t_date"]?.string ?? ""
                        task.user_id = data["user_id"]?.int ?? 0
                        task.created_at = data["created_at"]?.string ?? ""
                        task.api_token = data["api_token"]?.string ?? ""
                        task.updated_at = data["updated_at"]?.string ?? ""
                        task.id = data["id"]?.int ?? 0
                        task.name = data["name"]?.string ?? ""
                        task.email = data["email"]?.string ?? ""
                        task.u_id = data["u_id"]?.int ?? 0
                        task.remember_token = data["remember_token"]?.string ?? ""
                        
                        tasks.append(task)
                        
                    }
                    completion(nil, tasks)
                    
                }
        }
    }
    
    
  
    class func addBudget(budgetNameTxt : String , budgetAmountTxt : String , completion: @escaping (_ error : Error?, _ addBudget: Budget?)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/add_budget"
        let parameters = [ "email" :  email,
                          "b_name": budgetNameTxt,
                          "b_amount":budgetAmountTxt ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .validate(statusCode: 200..<900)
           
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                      completion (error,nil )
                      print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let budgetData = json["budget"].dictionary  else  {return}
                    let budget = Budget()
                    budget.b_amount = json["b_amount"].int ?? 0
                    budget.b_name = json["b_name"].string ?? ""
                    budget.created_at = json["created_at"].string ?? ""
                    
                
                   
                   completion (nil, budget)
                    
                }
            }
        
        
        
        }
    
    
    class func deleteBudget(b_name : String,
                            completion: @escaping (_ error : Error?, _ success: Bool)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/delete_budget"
        let parameters = [ "email" :  email,
                           "b_name": b_name,
                           ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let status = json["status"].toInt, status == 1 else {
                        completion(nil , false)
                        return
                    }
                    
                    
                    
                    completion (nil, true)
                    
                }
        }
        }
    
    class func deleteIncreaseCell(b_name : String,i_b_name : String,
                            completion: @escaping (_ error : Error?, _ success: Bool)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/delete_increase_budget"
        let parameters = [ "email" :  email,
                           "b_name": b_name,
                           "i_b_name": i_b_name
                           ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let status = json["status"].toInt, status == 1 else {
                        completion(nil , false)
                        return
                    }
                    
                    
                    
                    completion (nil, true)
                    
                }
        }
        
        
        
    }
    
    class func deleteExpenceCell(b_name : String, e_name : String,
                                  completion: @escaping (_ error : Error?, _ success: Bool)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , false )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/delete_expense"
        let parameters = [ "email" :  email,
                           "b_name": b_name,
                           "e_name": e_name
            ] as [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    if response.response?.statusCode == 200 {
                        completion(nil, true)
                    } else {
                        completion (error,false )
                        print(error)
                    }
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let status = json["status"].toInt, status == 1 else {
                        completion(nil , false)
                        return
                    }
                    
                    
        
                    completion (nil, true)
                    
                }
        }
        
        
        
    }
    
    class func getBudgetData (budgetNameText : String ,completion: @escaping (_ error : Error?, _ budgets_data: [all_budget_data])->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }
        
        
        let url = "http://bare3.com.sa/budgets/api/all_budget_data"
        let parameters = ["email" :  email,
                          "b_name": budgetNameText ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["all_budget_data"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var budgets_data = [all_budget_data]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let budget_data = all_budget_data()
                        budget_data.e_name = data["e_name"]?.string ?? ""
                        budget_data.i_b_name = data["i_b_name"]?.string ?? ""
                        budget_data.created_at = data["created_at"]?.string ?? ""
                        budget_data.flag = data["flag"]?.bool ?? false
                        budget_data.amount = data["amount"]?.double ?? 0
                       
                        budgets_data.append(budget_data)
                        
                    }
                    completion(nil, budgets_data)
                    
                }
        }
    }
    class func searchBudgets (budgetNameText : String ,completion: @escaping (_ error : Error?, _ budgets_data: [Budget])->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/search_in_budgets"
        let parameters = ["email" :  email,
                          "b_name": budgetNameText ]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["Budget_List"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var budgets_data = [Budget]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let budget_data = Budget()
                        budget_data.b_name = data["b_name"]?.string ?? ""
                        budget_data.created_at = data["created_at"]?.string ?? ""
                        budget_data.b_amount = data["b_amount"]?.int ?? 0
                        
                        print(budget_data.b_amount)
                        budgets_data.append(budget_data)
                        
                    }
                    completion(nil, budgets_data)
                    
                }
        }
    }
    class func calculateData (budgetNameText : String ,completion: @escaping (_ error : Error?, _ calcs: calculate?) -> Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/calc"
        let parameters = ["email" :  email,
                          "b_name" : budgetNameText]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    print(value)
                    let json = JSON(value)
                    guard let data = json.dictionary else {
                        completion (nil, nil)
                        return
                    }
                    
                    let calc = calculate()
                    calc.remainingBalance = data["remainingBalance"]?.double ?? 0
                    calc.totalBudget = data["totalBudget"]?.double ?? 0
                    calc.totalExpenses = data["totalExpenses"]?.double ?? 0
                    completion(nil, calc)
                  
                }
        }
        
    }
    
    class func activateExpense(budgetNameText : String,
                               expenseName: String,
                               flag: Bool,
                               completion: @escaping (_ error : Error?, _ calcs: calculate?) -> Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/expense_flag_reverse"
        let parameters = ["email" :  email,
                          "b_name" : budgetNameText,
                          "e_name" : expenseName,
                          "e_flag" : flag] as! [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let data = json.dictionary else {
                        completion (nil, nil)
                        return
                    }
                    
                    let calc = calculate()
                    calc.remainingBalance = data["remainingBalance"]?.double ?? 0
                    calc.totalBudget = data["totalBudget"]?.double ?? 0
                    calc.totalExpenses = data["totalExpenses"]?.double ?? 0
                    completion(nil, calc)
                    
                }
        }
        
    }
    class func addExpense(expenseNameTxt : String ,
                          expenseAmountTxt : String ,
                          budgetName : String,
                          completion: @escaping (_ error : Error?, _ addExpense: all_budget_data?)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/add_expense"
        let parameters = [ "email" :  email,
                           "e_name": expenseNameTxt,
                           "b_name" : budgetName,
                           "e_amount":expenseAmountTxt,
        "e_flag" : false] as! [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .validate(statusCode: 200..<900)
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion (error,nil )
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let expenseJSONArray = json["all_budget_data"].array else {
                        return
                    }
                    let expenseJSON = expenseJSONArray.first!
                    let expense = all_budget_data()
                    expense.e_name = expenseJSON["e_name"].string ?? ""
                    expense.amount = expenseJSON["amount"].double ?? 0
                    expense.flag = expenseJSON["flag"].bool ?? false
                    completion (nil, expense)
                    
                }
        }
        
        
        
    }
    class func addIncrease(increaseNameTxt : String ,
                          increaseAmountTxt : String ,
                          budgetName : String,
                          completion: @escaping (_ error : Error?, _ addIncrease: all_budget_data?)->Void){
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/add_increase_budget"
        let parameters = [ "email" :  email,
                           "i_b_name": increaseNameTxt,
                           "b_name" : budgetName,
                           "i_b_amount":increaseAmountTxt,
                           "i_b_flag" : false] as! [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            
            .validate(statusCode: 200..<900)
            
            .responseJSON { response in
                
                switch response.result
                {
                case .failure(let error):
                    completion (error,nil )
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    
                    guard let increaseJSONArray = json["all_budget_data"].array else {
                        return
                    }
                    let increaseJSON = increaseJSONArray.first!
                    let increase = all_budget_data()
                    increase.i_b_name = increaseJSON["i_b_name"].string ?? ""
                    increase.amount = increaseJSON["amount"].double ?? 0
                   increase.flag = increaseJSON["flag"].bool ?? false
                    completion (nil, increase)
                    
                }
        }
        
        
        
    }
    class func activateIncrease(budgetNameText : String,
                               increaseName: String,
                               flag: Bool,
                               completion: @escaping (_ error : Error?, _ calcs: calculate?) -> Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , nil )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/increase_budget_flag_reverse"
        let parameters = ["email" :  email,
                          "b_name" : budgetNameText,
                          "i_b_name" : increaseName,
                          "i_b_flag" : flag] as! [String : Any]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let data = json.dictionary else {
                        completion (nil, nil)
                        return
                    }
                    
                    let calc = calculate()
                    calc.remainingBalance = data["remainingBalance"]?.double ?? 0
                    calc.totalBudget = data["totalBudget"]?.double ?? 0
                    calc.totalExpenses = data["totalExpenses"]?.double ?? 0
                    completion(nil, calc)
                    
                }
        }
        
    }
    class func getUserData (completion: @escaping (_ error : Error?, _ users: [userData])->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , [] )
            return
        }

        let url = "http://ragaaey.com/tasks/api/getUserData"
        let parameters = ["email" :  email]
        Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    
                    print(value)
                    let json = JSON(value)
                    guard let dataArr = json["userData"].array else
                    {
                        
                        completion (nil, [] )
                        return
                    }
                    
                    var users = [userData]()
                    for data in dataArr {
                        guard let data = data.dictionary else {return}
                        
                        let user = userData()
                        user.email = data["email"]?.string ?? ""
                        user.name = data["name"]?.string ?? ""
                        user.password = data["password"]?.string ?? ""
                       
                        print(user)
                
                        users.append(user)
                        
                    }
                    
                    completion(nil, users)
                    
                }
        }
    }
        class func updateUserData (newEmailTxt : String,newNameTxt: String, newPasswordTxt: String, completion: @escaping (_ error : Error?, _ users: [userData])->Void) {
            guard let email = helper.getEmail() else {
                completion ( nil , [] )
                return
            }
            
            let url = "http://ragaaey.com/tasks/api/upateUserData"
            let parameters = ["email" :  email,
                              "newEmail": newEmailTxt,
                              "newName": newNameTxt,
                              "newPassword":newPasswordTxt
            ]
            Alamofire.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: nil)
                .validate(statusCode: 200..<900)
                .responseJSON { responce in
                    switch responce.result
                    {
                    case .failure(let error):
                        
                        print(error)
                        
                    case.success(let value):
                        
                        print(value)
                        let json = JSON(value)
                        guard let dataArr = json["userData"].array else
                        {
                            
                            completion (nil, [] )
                            return
                        }
                        
                        var users = [userData]()
                        for data in dataArr {
                            guard let data = data.dictionary else {return}
                            
                            let user = userData()
                            user.email = data["email"]?.string ?? ""
                            user.name = data["name"]?.string ?? ""
                            user.password = data["password"]?.string ?? ""
                            
                            
                            print(user)
                            
                            users.append(user)
                            
                        }
                        completion(nil, users)
                        
                    }
            }
    }
    
    class func getBudgetCount (completion: @escaping (_ error : Error?, _ count: Int )->Void) {
        guard let email = helper.getEmail() else {
            completion ( nil , 0 )
            return
        }
        
        let url = "http://bare3.com.sa/budgets/api/budgets_count"
        let parameters = ["email" :  email]
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil)
            .validate(statusCode: 200..<900)
            .responseJSON { responce in
                switch responce.result
                {
                case .failure(let error):
                    
                    print(error)
                    
                case.success(let value):
                    let json = JSON(value)
                   
                    print(json)
                    
                    let count = json["count"].int
                    
                    completion(nil, count!)
                    
                }
        }
    }
}





