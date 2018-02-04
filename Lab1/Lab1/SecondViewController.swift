//
//  SecondViewController.swift
//  Lab1
//
//  Created by Michael Tang on 2/2/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    @IBAction func launchWebsite(_ sender: Any) {
        if(UIApplication.shared.canOpenURL(URL(string: "googlechrome://")!)){
            UIApplication.shared.open(URL(string: "https://thedesignlove.com/understanding-the-different-shades-of-green/")!, options: [:], completionHandler: nil)
        }else {
            if(UIApplication.shared.canOpenURL(URL(string: "safari://")!)){
                UIApplication.shared.open(URL(string: "https://thedesignlove.com/understanding-the-different-shades-of-green/")!, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.open(URL(string: "https://thedesignlove.com/understanding-the-different-shades-of-green/")!, options: [:], completionHandler: nil)
            }
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

