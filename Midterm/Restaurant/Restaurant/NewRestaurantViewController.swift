//
//  NewRestaurantViewController.swift
//  Restaurant
//
//  Created by Michael Tang on 3/15/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class NewRestaurantViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var url: UITextField!
    var newRestaurant:Restaurant = Restaurant(name: "", url: "")
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "done"){
            if(!(self.name.text?.isEmpty)! && !(self.url.text?.isEmpty)!){
                newRestaurant.name = self.name.text!
                newRestaurant.url = self.url.text!
            }
            print("Called from here")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
