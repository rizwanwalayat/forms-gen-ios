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
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        // Using localized strings
        title = LocalizationKeys.Home.title.localized
        searchBar.placeholder = LocalizationKeys.Home.searchPlaceholder.localized
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */

}
