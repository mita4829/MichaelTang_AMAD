//
//  ViewController.swift
//  Avocado
//
//  Created by Michael Tang on 2/18/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var mealTableView: UITableView!
    
    var avocadoMeal:AvocadoMeal = AvocadoMeal()
    let userFilename:String = "userAvocadoDishes.plist"
    let avocadoDishesFilename:String = "avocadoDishes"
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return avocadoMeal.meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "meal", for: indexPath)
        cell.textLabel?.text = avocadoMeal.meal[indexPath.row]
        return cell
    }
    
    
    func loadAvocadoData() -> Void {
        let url:URL?
        
        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        
        let usersAvocadoDataFile = docDir.appendingPathComponent(userFilename)
        
        if FileManager.default.fileExists(atPath: usersAvocadoDataFile.path){
            url = usersAvocadoDataFile
        }
        else {
            url = Bundle.main.url(forResource: avocadoDishesFilename, withExtension: "plist")
        }
        
        let plistdecoder = PropertyListDecoder()
        do {
            let data = try Data(contentsOf: url!)
            avocadoMeal.dishes = try plistdecoder.decode([String: [String]].self, from: data)
            avocadoMeal.meal = Array(avocadoMeal.dishes.keys)
        } catch {
            print(error)
        }
        
        let app = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.applicationWillResignActive(_:)), name: NSNotification.Name.UIApplicationWillResignActive, object: app)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "chooseDishSegue"){
            let avocadoDishesController:AvocadoDishesViewController = segue.destination as! AvocadoDishesViewController
            let cellClicked:UITableViewCell = sender as! UITableViewCell
            /*Set title*/
            avocadoDishesController.title = cellClicked.textLabel?.text
            avocadoDishesController.dishes = avocadoMeal
            avocadoDishesController.mealChose = (cellClicked.textLabel?.text)!
        }
    }
    
    @objc func applicationWillResignActive(_ notification: NSNotification){
        //get path for data file
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = path[0]
        print(docDir)
        
        let url = docDir.appendingPathComponent(userFilename)
        print(url)
        let plistEncoder = PropertyListEncoder()
        plistEncoder.outputFormat = .xml
        do {
            let data = try plistEncoder.encode(avocadoMeal.dishes)
            try data.write(to: url)
        } catch {
            print(error)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mealTableView.delegate = self
        self.mealTableView.dataSource = self
        self.loadAvocadoData()
        
        print(avocadoMeal.dishes)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

