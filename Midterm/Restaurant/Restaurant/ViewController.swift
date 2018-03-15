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

