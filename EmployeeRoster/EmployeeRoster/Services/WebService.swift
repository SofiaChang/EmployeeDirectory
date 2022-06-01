//
//  WebService.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation

enum WebServiceError: Error {
    case failedServerResponse
    case noDataError
}

class WebService {
    func getAllEmployeeData(completion: @escaping (Result<EmployeeList, Error>) -> Void) {
        guard let url = URL(string: ApiUrl.allEmployeeData) else { return }
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                print("WebService Error: \(err.localizedDescription)")
                completion(.failure(err))
                return
            }
            guard let httpsResponse = response as? HTTPURLResponse, httpsResponse.statusCode == 200 else {
                print("WebService Error: Empty Response")
                return
            }
            print("WebService Response: status code is \(httpsResponse.statusCode)")
            guard let resultData = data else {
                print("WebService Error: Empty Data")
                return
            }
            
            do {
                let employeesJsonData = try JSONDecoder().decode([String:[Employee]].self, from: resultData)
                let employeeData = employeesJsonData.values.reduce([], +)
                let employeeList = EmployeeList.init(employees: employeeData)
                DispatchQueue.main.async {
                    completion(.success(employeeList))
                }
            } catch let error {
                completion(.failure(error))
            }
        }
        
        dataTask.resume()
    }
}
