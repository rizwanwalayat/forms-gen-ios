//
//  FormViewController.swift
//  Forms Gen
//
//  Created by Techtiz PM on 02/02/2025.
//  Copyright © 2025 Systango. All rights reserved.
//

import UIKit
import WebKit

class FormViewController: UIViewController {

    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize and configure WKWebView
        webView = WKWebView(frame: self.view.frame)
        self.view.addSubview(webView)

        // Replace this with your Google Form URL
        if let googleFormURL = URL(string: "https://docs.google.com/forms/d/1Sc9hxfMrAXsFbYPVXzYBi52I9QJR76fwRxnl5169Muo/edit") {
            let request = URLRequest(url: googleFormURL)
            webView.load(request)
        }
    }

}
