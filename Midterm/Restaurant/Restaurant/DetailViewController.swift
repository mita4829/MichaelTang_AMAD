//
//  DetailViewController.swift
//  Restaurant
//
//  Created by Michael Tang on 3/15/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit
import WebKit

class DetailViewController: UIViewController,  WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var webSpinner: UIActivityIndicatorView!
    
    var restaurantInstance: AnyObject? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() -> Void {
        if let detail = self.restaurantInstance {
            //loadWebPage(detail.description)
            loadWebPage(detail.description)
        }
    }
    
    func loadWebPage(_ urlString: String){

        let myurl = URL(string: urlString)
        let request = URLRequest(url: myurl!)

        //webView.load(request)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        webSpinner.startAnimating()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webSpinner.stopAnimating()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        webView.navigationDelegate = self
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
