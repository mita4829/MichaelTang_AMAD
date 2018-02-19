//
//  AvocadoDishesViewController.swift
//  Avocado
//
//  Created by Michael Tang on 2/18/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class AvocadoDishesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var avocadoDishesTableView: UITableView!
    var dishes:AvocadoMeal = AvocadoMeal()
    var mealChose:String = String()
    var dishArray:[String] = []
    var filteredDishes:[String] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        dishArray = dishes.dishes[mealChose]!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (filteredDishes.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dish", for: indexPath)
        cell.textLabel?.text = filteredDishes[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            //Delete the country from the array
            dishArray.remove(at: indexPath.row)
            dishes.dishes[mealChose] = dishArray
            filteredDishes = dishArray
            // Delete the row from the table
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.filteredDishes = dishes.dishes[mealChose]!
        self.avocadoDishesTableView.delegate = self
        self.avocadoDishesTableView.dataSource = self
        self.searchBar.delegate = self
        /*Set done to trigger the sort closure*/
        self.searchBar.returnKeyType = UIReturnKeyType.done
        navigationItem.largeTitleDisplayMode = .never

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if(segue.identifier == "doneSegue"){
            let source:NewAvocadoDish = segue.source as! NewAvocadoDish
            if(!source.newDish.isEmpty){
                let nameOfNewDish:String = source.newDish
                dishArray.append(nameOfNewDish)
                dishes.dishes[mealChose] = dishArray
                filteredDishes = dishArray
                avocadoDishesTableView.reloadData()
            }
        }
    }
    
    func searchBar(_: UISearchBar, textDidChange: String){
        /*If the searching string is not empty, filter the array using contains and set it */
        if(!textDidChange.isEmpty){
            filteredDishes = (dishes.dishes[mealChose]?.filter({ (dishName:String) -> Bool in
                return dishName.lowercased().contains(textDidChange.lowercased())
            }))!
        }else{
            /*If the filtering string is empty, reset it to the model's array*/
            filteredDishes = dishes.dishes[mealChose]!
        }
        self.avocadoDishesTableView.reloadData()
    }
}
