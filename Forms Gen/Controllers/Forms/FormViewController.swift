//
//  FormViewController.swift
//  Forms Gen
//
//  Created by Techtiz PM on 02/02/2025.
//  Copyright © 2025 Systango. All rights reserved.
//

import UIKit
import WebKit
import SafariServices

class FormViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
//    var webView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let url = "https://docs.google.com/forms/d/1Sc9hxfMrAXsFbYPVXzYBi52I9QJR76fwRxnl5169Muo/edit"
//        let url = "https://google.com"
        // Replace this with your Google Form URL
        if let googleFormURL = URL(string: url) {
            let request = URLRequest(url: googleFormURL)
//            request.addValue("Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/537.36", forHTTPHeaderField: "User-Agent")

            webView.load(request)
            webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 14_0 like Mac OS X) AppleWebKit/537.36 (KHTML, like Gecko) Version/14.0 Mobile/15E148 Safari/537.36"

        }
    }

}
