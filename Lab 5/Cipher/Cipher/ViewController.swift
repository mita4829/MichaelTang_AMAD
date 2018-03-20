//
//  ViewController.swift
//  Cipher
//
//  Created by Michael Tang on 3/18/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var database: DatabaseReference!
    
    var ciphers = [Cipher]()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        database = Database.database().reference()
        self.tableView.delegate = self
        self.tableView.dataSource = self
 
        database.observe(DataEventType.value, with: {snapshot in
            self.ciphers=[]

            for c in snapshot.children.allObjects as! [DataSnapshot]{
                print(c)
                if let cipherValue = c.value as? [String: String],
                    let json = try? JSONEncoder().encode(cipherValue),
                    let newCipher = try? JSONDecoder().decode(Cipher.self, from: json)
                {
                    self.ciphers.append(newCipher)
                }
            }
            self.tableView.reloadData()
        })

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ciphers.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = ciphers[indexPath.row].message
        return cell
    }
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if segue.identifier == "savemessage" {
            let source = segue.source as! CreateMessageViewController
            if !source.userMessage.isEmpty && !source.userKey.isEmpty {
                let newcipher = Cipher(message: source.userMessage, key: source.userKey)
                ciphers.append(newcipher)
                
                let newDBInstance:[String:String] = ["message":source.userMessage, "key":source.userKey]
                let cipherRef = database.child(source.userMessage)
                cipherRef.setValue(newDBInstance)
                print(source.userMessage)
            }
        }
    }
    
}

