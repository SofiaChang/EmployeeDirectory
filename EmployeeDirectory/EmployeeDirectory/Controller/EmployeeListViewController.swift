//
//  EmployeeListViewController.swift
//  EmployeeRoster
//
//  Created by Sofia on 2022-05-28.
//

import Foundation
import UIKit
import Kingfisher

class EmployeeListViewController: UITableViewController, UISearchResultsUpdating, UISearchBarDelegate {
    private var vm = EmployeeListViewModel()
    private let searchController = UISearchController()
    private var filteredEmployees = [EmployeeViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadEmployeeList()
        self.configureUI()
    }
    
    private func configureUI() {
        self.configureNavBar()
        self.configureSearchController()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(self.didPullForRefresh), for: .valueChanged)
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeContentTitle = "Employee Directory"
        self.title = "Employees"
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 0.176, green: 0.588, blue: 0.804, alpha: 1)
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive) {
            return filteredEmployees.count
        } else {
            return vm.employees.count
        }
    }
    
    private func configureSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.scopeButtonTitles = ["All", "Full-Time", "Part-Time", "Contractor"]
        searchBar.delegate = self
        
        searchBar.backgroundColor = UIColor(red: 0.898, green: 0.965, blue: 1, alpha: 1)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let selectedScopeButton = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
        let searchText = searchController.searchBar.text!
                
        filterBySearchTextAndSelectedScope(searchText: searchText, scopeButton: selectedScopeButton)
    }
    
    private func filterBySearchTextAndSelectedScope(searchText: String, scopeButton: String){
        filteredEmployees = vm.employees.filter({ (employee) in
            let scopeMatch = (scopeButton == "All" || employee.employeeType.lowercased().contains(scopeButton.lowercased()))
            if (searchController.searchBar.text == "") {
                return scopeMatch
            }
            let employeeTypeCheck = employee.employeeType.lowercased().contains(searchText.lowercased())
            let nameCheck = employee.fullName.lowercased().contains(searchText.lowercased())
            let teamCheck = employee.team.lowercased().contains(searchText.lowercased())
            let searchTextMatch = employeeTypeCheck || nameCheck || teamCheck
            return scopeMatch && searchTextMatch
        })
        DispatchQueue.main.async {
            [weak self] in self?.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let employeeCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var employee = vm.employees[indexPath.row]

        if (searchController.isActive) {
            employee = filteredEmployees[indexPath.row]
        }
        self.configureCellContent(employee: employee, employeeCell: employeeCell)

        return employeeCell
    }
    
    private func configureCellContent(employee: EmployeeViewModel, employeeCell: UITableViewCell) {
        var content = employeeCell.defaultContentConfiguration()
        
        content.text = employee.fullName
        if (employee.uuid != "failed") {
            content.secondaryText = "\(employee.team) - \(employee.employeeType) \n\nContact Info:\n\(employee.phoneNumber)\n\(employee.emailAddress)\n\nBiography:\n\(employee.biography)"
        }
        
        content.image = employee.smallPhoto
        content.imageProperties.maximumSize = CGSize(width: 75, height: 75)
        content.imageProperties.cornerRadius = 5

        employeeCell.contentConfiguration = content
        
    }
    
    @objc private func didPullForRefresh() {
        DispatchQueue.main.async {
            self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    private func loadEmployeeList() {
        vm.fetchAllEmployees { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.dataSource = self
                self?.tableView.reloadData()
            }
        }
    }
}
