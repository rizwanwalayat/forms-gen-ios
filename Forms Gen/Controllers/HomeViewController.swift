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
    
    private var driveItems: [DriveItem] = []
    private var folders: [DriveItem] = []
    private var files: [DriveItem] = []
    
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
        DriveManager.shared.fetchForms { [weak self] (items, error) in
            guard let self = self else { return }
            
            if let error = error {
                // Handle error
                print("Error fetching forms: \(error)")
                return
            }
            
            if let items = items {
                self.driveItems = items
                
                // Separate folders and files
                self.folders = self.driveItems.filter { $0.type == .folder }
                self.files = self.driveItems.filter { $0.type == .file }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }
    }

}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // One for folders, one for files
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            // Count folders
            return folders.count
        } else {
            // Count files
            return files.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FormCell", for: indexPath) as! FormCell
        
        let item: DriveItem
        if indexPath.section == 0 {
            // Get folder
            item = folders[indexPath.row]
        } else {
            // Get file
            item = files[indexPath.row]
        }
        
        cell.titleLabel.text = item.name
        cell.dateLabel.text = item.formattedModifiedDate
        
        if item.type == .folder {
            cell.fileIcon.image = UIImage(named: "Folder")
        } else {
            // Load the thumbnail image
            if let thumbnailURL = item.thumbnailLink, let url = URL(string: thumbnailURL) {
                URLSession.shared.dataTask(with: url) { [weak cell] data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell?.fileIcon.image = image
                        }
                    }
                }.resume()
            } else {
                cell.fileIcon.image = UIImage(systemName: "doc.fill")
            }
        }
        
        return cell
    }
    
}
