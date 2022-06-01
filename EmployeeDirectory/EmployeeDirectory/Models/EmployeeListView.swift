//
//  EmployeeListView.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation

class EmployeeListViewModel {
    
    private(set) var employees: [EmployeeViewModel] = []
    var teams: Array = Array(arrayLiteral: String())
    
    func fetchAllEmployees(completion: @escaping () -> ()) {
        WebService().getAllEmployeeData { [weak self] (result) in
            switch result {
            case .success(let employeeList):
                self?.employees = employeeList.employees.map(EmployeeViewModel.init)
                self?.teams = Array(Set(employeeList.employees.map {$0.team}))
                completion()
            case .failure(let err):
                let failedEmployee = Employee(uuid: "failed",
                                              full_name: "Error: Could not load data",
                                              phone_number: " ",
                                              email_address: " ",
                                              biography: " ",
                                              photo_url_small: " ",
                                              photo_url_large: " ",
                                              team: " ",
                                              employee_type: " ")
                self?.employees = [EmployeeViewModel.init(employee: failedEmployee)]
                print("EmployeeListViewModel Data Processing Error: \(err.localizedDescription)")
            }
        }
    }
}
