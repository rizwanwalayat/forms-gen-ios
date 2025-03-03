//
//  HomeViewController.swift
//  Swift_MVVM_Boilerplate
//
//  Created by Ravi on 09/01/20.
//  Copyright © 2020 Systango. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var forms: [Form] = []
    private var filteredForms: [Form] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        fetchForms()
    }

    private func setupUI() {
        // Using localized strings
        title = LocalizationKeys.Home.title.localized
        searchBar.placeholder = LocalizationKeys.Home.searchPlaceholder.localized
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
    }
    
    private func fetchForms() {
        DriveManager.shared.fetchForms { [weak self] (files, error) in
            guard let self = self else { return }
            
            if let error = error {
                // Handle error
                print("Error fetching forms: \(error)")
                return
            }
            
            if let files = files {
                self.forms = files.map { Form(from: $0) }
                self.filteredForms = self.forms
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredForms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as! FormCell
        let form = filteredForms[indexPath.row]
        cell.configure(with: form)
        return cell
    }
}
