//
//  ViewController.swift
//  Cloudy Sky
//
//  Created by Michael Tang on 2/28/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var temperature: UILabel!
    @IBOutlet weak var skyView: UIImageView!

    
    @IBOutlet weak var day_one: UILabel!
    @IBOutlet weak var image_one: UIImageView!
    @IBOutlet weak var temp_one: UILabel!
    
    
    @IBOutlet weak var day_two: UILabel!
    @IBOutlet weak var image_two: UIImageView!
    @IBOutlet weak var temp_two: UILabel!
    
    @IBOutlet weak var day_three: UILabel!
    @IBOutlet weak var image_three: UIImageView!
    @IBOutlet weak var temp_three: UILabel!
    var weatherPayload:[String:Any] = [:]
    
    func rainAnimation() -> Void {
        /*Not the most prettiest way to do this...*/
        let rain = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        rain.image = UIImage(named: "rain")
        let rain_2 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        rain_2.image = UIImage(named: "rain")
        self.view.addSubview(rain)
        self.view.addSubview(rain_2)
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear, .repeat], animations: {
            rain.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        UIView.animate(withDuration: 2, delay: 1, options: [.curveLinear, .repeat], animations: {
            rain_2.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        let rain_3 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        rain.image = UIImage(named: "rain")
        let rain_4 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        rain_3.image = UIImage(named: "rain")
        self.view.addSubview(rain_3)
        self.view.addSubview(rain_4)
        UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear, .repeat], animations: {
            rain_3.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        UIView.animate(withDuration: 3, delay: 1.5, options: [.curveLinear, .repeat], animations: {
            rain_4.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
    }
    
    func snowAnimation() -> Void {
        let snow = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        snow.image = UIImage(named: "snowAnimation")
        let snow_2 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        snow_2.image = UIImage(named: "snowAnimation")
        self.view.addSubview(snow)
        self.view.addSubview(snow_2)
        
        UIView.animate(withDuration: 5, delay: 0, options: [.curveLinear, .repeat], animations: {
            snow.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        UIView.animate(withDuration: 5, delay: 2.5, options: [.curveLinear, .repeat], animations: {
            snow_2.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        let snow_3 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        snow.image = UIImage(named: "snowAnimation")
        let snow_4 = UIImageView(frame: CGRect(x: 0, y: -500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        snow_4.image = UIImage(named: "snowAnimation")
        self.view.addSubview(snow_3)
        self.view.addSubview(snow_4)
        UIView.animate(withDuration: 8, delay: 0, options: [.curveLinear, .repeat], animations: {
            snow_3.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
        UIView.animate(withDuration: 8, delay: 4, options: [.curveLinear, .repeat], animations: {
            snow_4.frame = CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        }, completion: nil)
    }
    
    func sunAnimation() -> Void {
        let sun = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        sun.image = UIImage(named: "sunglare")
        self.view.addSubview(sun)
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear, .autoreverse], animations: {
            sun.alpha = 1
            sun.alpha = 0
        }, completion: nil)
    }
    
    func starAnimation() -> Void {
        let star = UIImageView(frame: CGRect(x: 0, y: -200, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        star.image = UIImage(named: "stars")
        star.contentMode = .scaleAspectFit
        self.view.addSubview(star)
        UIView.animate(withDuration: 5, delay: 0, options: [.repeat, .curveLinear, .autoreverse], animations: {
            star.alpha = 1
            star.alpha = 0.3
        }, completion: nil)
    }
    
    func conditionsToImage(condition:Int, imageView:UIImageView) -> Void {
        if(condition >= 0 && condition <= 12){
            imageView.image = UIImage(named: "rainmini")
        }else if(condition <= 16){
            imageView.image = UIImage(named: "snow")
        }else if(condition <= 30){
            imageView.image = UIImage(named: "cloudy")
        }else if(condition == 31){
            imageView.image = UIImage(named: "clearnight")
        }else if(condition <= 36){
            imageView.image = UIImage(named: "sun")
        }else if(condition <= 47){
            imageView.image = UIImage(named: "rainmini")
        }
    }
    
    func currentAnimation(condition:Int) -> Void {
        if(condition >= 0 && condition <= 12){
            rainAnimation()
        }else if(condition <= 16){
            snowAnimation()
        }else if(condition == 31){
            starAnimation()
        }else if(condition <= 36 && condition > 31){
            sunAnimation()
        }else if(condition <= 47 && condition >= 31){
            rainAnimation()
        }
    }
    func displayResults() -> Void {
        let results:[String:Any] = weatherPayload["results"] as! [String:Any]
        let channel:[String:Any] = results["channel"] as! [String:Any]
        let location:[String:Any] = channel["location"] as! [String:Any]
        self.city.text = location["city"] as? String
        let item:[String:Any] = channel["item"] as! [String:Any]
        let cond:[String:Any] = item["condition"] as! [String:Any]
        self.condition.text = cond["text"] as? String
        self.temperature.text = (cond["temp"] as! String) + self.temperature.text!
        
        let forecast:[[String:Any]] = item["forecast"] as! [[String:Any]]
        
        self.day_one.text = forecast[0]["day"] as? String
        self.day_two.text = forecast[1]["day"] as? String
        self.day_three.text = forecast[2]["day"] as? String
        
        self.temp_one.text = (forecast[0]["high"] as? String)! + self.temp_one.text!
        self.temp_two.text = (forecast[1]["high"] as? String)! + self.temp_two.text!
        self.temp_three.text = (forecast[2]["high"] as? String)! + self.temp_three.text!
        
        let day_one_code:Int = Int((forecast[0]["code"] as? String)!)!
        let day_two_code:Int = Int((forecast[1]["code"] as? String)!)!
        let day_three_code:Int = Int((forecast[2]["code"] as? String)!)!
        conditionsToImage(condition: day_one_code, imageView: self.image_one)
        conditionsToImage(condition: day_two_code, imageView: self.image_two)
        conditionsToImage(condition: day_three_code, imageView: self.image_three)
        
        let currentCode:Int = Int((cond["code"] as? String)!)!
        currentAnimation(condition: currentCode)
    }
    
    func parseJSON(data: Data) -> Void {
        do {
            /*JSON data*/
            let json = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) as! [String:Any]
            /*Convert JSON data into dictionary [String:Any] type*/
            let results = json["query"] as! [String:Any]
            weatherPayload = results
            displayResults()
        } catch {
            print("Error while parsing JSON: \(error)")
            return
        }
    }
    
    func loadJSON() -> Void {
        /*URL for weather in Boulder, CO*/
        let urlPath:String = "https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22boulder%2C%20co%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys"
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
    
    func loadSkyView() -> Void {
        let hour = Calendar.current.component(.hour, from: Date())
        if(hour >= 6 && hour < 18){
            self.skyView.image = UIImage(named: "day")
        }else{
            self.skyView.image = UIImage(named: "night")
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJSON()
        loadSkyView()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

