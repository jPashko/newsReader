//
//  WebViewViewController.swift
//  newsReaderJson
//
//  Created by Yulia Pashko on 07.12.16.
//  Copyright © 2016 Yulia Pashko. All rights reserved.
//

import UIKit

class WebViewViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!
    
    var url: String?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.loadRequest(URLRequest(url: URL(string: url!)!))

            }

   
    
}
