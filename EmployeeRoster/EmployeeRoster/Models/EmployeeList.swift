//
//  Employee.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation

struct EmployeeList: Decodable {
    let employees: [Employee]
}

struct Employee: Decodable {
    let uuid: String
    let full_name: String
    let phone_number: String
    let email_address: String
    let biography: String
    let photo_url_small: String
    let photo_url_large: String
    let team: String
    let employee_type: String
}
