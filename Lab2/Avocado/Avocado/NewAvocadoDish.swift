//
//  NewAvocadoDish.swift
//  Avocado
//
//  Created by Michael Tang on 2/18/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class NewAvocadoDish: UIViewController {

    @IBOutlet weak var textField: UITextField!
    var newDish:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "doneSegue"){
            if(!(self.textField.text?.isEmpty)!){
                newDish = self.textField.text!
            }
        }
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
