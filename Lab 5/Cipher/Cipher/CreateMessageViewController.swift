//
//  CreateMessageViewController.swift
//  Cipher
//
//  Created by Michael Tang on 3/19/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class CreateMessageViewController: UIViewController {

    @IBOutlet weak var message: UITextField!
    @IBOutlet weak var symmetricKey: UITextField!
    
    var userMessage:String = String()
    var userKey:String = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func encryptMessage(message: String, key:Int) -> String {
        var encrypted:String = ""
        for char in message.utf8 {
            let ec:String = String(UnicodeScalar(UInt8((Int16(char)+Int16(key)) % Int16(UInt8.max))))
            encrypted += ec
        }
        return encrypted
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "savemessage" {
            if(!(message.text?.isEmpty)! && !(symmetricKey.text?.isEmpty)!){
                let key:Int = Int((symmetricKey.text)!)!
                let msg:String = message.text!
                let encrypt:String = encryptMessage(message: msg, key: key)
                userMessage = encrypt
                userKey = symmetricKey.text!
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {

        return 1
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
