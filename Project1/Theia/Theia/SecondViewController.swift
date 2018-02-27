//
//  SecondViewController.swift
//  Theia
//
//  Created by Michael Tang on 2/9/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit
import UserNotifications

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var reminders:[String] = []
    var ReminderInstances:[Reminders] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reminder", for: indexPath)
        cell.textLabel?.text = self.reminders[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.reminders.count
    }

    func loadData() -> Void {
        self.reminders = ["MILK", "EGGS", "BREAD"]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.reminders.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func createNotification(reminder r: Reminders) -> Void {
        print("Called")
        /*Reference on how to make local notifications here: https://useyourloaf.com/blog/local-notifications-with-ios-10/ */
         let options:UNAuthorizationOptions = [.alert, .sound]
         let center = UNUserNotificationCenter.current()
         center.requestAuthorization(options: options) {
             (granted, error) in
             if !granted {
                let alert = UIAlertController(title: "Please allow notification", message: "Notifications are currently disallowed. Allow them by giving permission in settings.", preferredStyle: UIAlertControllerStyle.alert)
                let cancel=UIAlertAction(title: "Okay", style:UIAlertActionStyle.cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
             }
            return
         }
        
        if(r.timeDifference < 0){
            let alert = UIAlertController(title: "Going back in time", message: "Unless you got the flux capacitor working, and you are going at least 88mph, your notification was set in the past.", preferredStyle: UIAlertControllerStyle.alert)
            let cancel=UIAlertAction(title: "Discard Notification", style:UIAlertActionStyle.destructive, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
         let content = UNMutableNotificationContent()
         content.title = r.reminders
         content.sound = UNNotificationSound.default()
         print("Creating notification for \(r.timeDifference)")
         let trigger = UNTimeIntervalNotificationTrigger(timeInterval: r.timeDifference,
         repeats: false)
         
         let identifier = r.reminders + String(r.timeDifference)
         let request = UNNotificationRequest(identifier: identifier,
         content: content, trigger: trigger)
         center.add(request, withCompletionHandler: { (error) in
             if let error = error {
             print("Could not complete request of adding notification. \(error)")
         }
         })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .always
        loadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func unwindSegue(_ segue: UIStoryboardSegue){
        if(segue.identifier == "done"){
            let source = segue.source as! NewReminderViewController
            if(!source.recognizedText.isEmpty){
                let recognizedText:String = source.recognizedText
                let reminderInstance:Reminders = source.reminderInstance
                /*Create new notification here*/
                
                self.createNotification(reminder: reminderInstance)
                if((reminderInstance.timeDifference > 0 && reminderInstance.notifiy) || !reminderInstance.notifiy){
                    self.reminders.append(recognizedText)
                    self.tableView.reloadData()
                }
                
                /*Give the learning model confirmation on the set it just learned*/
                learn(correctString: recognizedText)
            }
        }
    }

}




