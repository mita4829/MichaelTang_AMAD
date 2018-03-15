//
//  ViewController.swift
//  Restaurant
//
//  Created by Michael Tang on 3/15/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    var restaurantInstances:[Restaurant] = []
    var jsonRestaurant:[[String:String]] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = restaurantInstances[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantInstances.count
    }
    
    func createRestaurantInstances() -> Void {
        for rest in jsonRestaurant {
            let name:String = rest["name"]!
            let url:String = rest["url"]!
            let instance:Restaurant = Restaurant(name: name, url: url)
            restaurantInstances.append(instance)
        }

    }
    
    func parseJSON(data:Data) -> Void {
        do {
            /*JSON data*/
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [[String:String]]
            /*Convert JSON data into dictionary [String:Any] type*/
            jsonRestaurant = json
            createRestaurantInstances()
            self.tableView.reloadData()
        } catch {
            print("Error while parsing JSON: \(error)")
            return
        }
    }

    
    func loadJSON() -> Void {
        /*URL for weather in Boulder, CO*/
        let urlPath:String = "https://creative.colorado.edu/~apierce/samples/data/restaurants.json"
        guard let url = URL(string: urlPath)
            else {
                print("Invalid URL")
                return
        }
        let session = URLSession.shared.dataTask(with: url, completionHandler: {(data, response, error) in
            let httpResponse = response as! HTTPURLResponse
            let statusCode = httpResponse.statusCode
            guard(statusCode == 200)
                else {
                    print("Status 200. Could not download JSON file.")
                    return
            }
            /*Parse the JSON on a different thread, so it doesn't block the UI*/
            DispatchQueue.main.async {
                self.parseJSON(data: data!)
            }
        })
        session.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreDetailSegue" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let restaurant:Restaurant = restaurantInstances[indexPath.row]
                let name = restaurant.name
                let url = restaurant.url
                
                let controller = segue.destination as! DetailViewController
                
                controller.restaurantInstance = url as AnyObject?
                controller.title = name
                //controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                //controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    
    @IBAction func unwindSegue(segue: UIStoryboardSegue){
        if(segue.identifier == "done"){
//            let source:NewAvocadoDish = segue.source as! NewAvocadoDish
            let source:NewRestaurantViewController = segue.source as! NewRestaurantViewController
//            if(!source.newDish.isEmpty){
//                let nameOfNewDish:String = source.newDish
//                dishArray.append(nameOfNewDish)
//                dishes.dishes[mealChose] = dishArray
//                filteredDishes = dishArray
//                avocadoDishesTableView.reloadData()
//            }
            let r = source.newRestaurant
            restaurantInstances.append(r)
            self.tableView.reloadData()
            print("done")
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            self.restaurantInstances.remove(at: indexPath.row)
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        navigationItem.largeTitleDisplayMode = .automatic
        // Do any additional setup after loading the view, typically from a nib.
        self.loadJSON()
//        for token in restaurantInstances {
//            print(token.name)
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

