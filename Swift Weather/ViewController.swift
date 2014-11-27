//
//  ViewController.swift
//  Swift Weather
//
//  Created by Daniel Rafique - Black on 23/11/2014.
//  Copyright (c) 2014 Daniel Rafique. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var cloudLoader: UIImageView!
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var weatherIcon: UIImageView!
//    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentWeather: UILabel!
    @IBOutlet weak var locationTitle: UINavigationItem!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!

    var theWeatherMan = SWForecaster(yourKey: "add your api key")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        locationsButton.layer.cornerRadius = 7
       // cloudLoader.startAnimating()
        
        //Setup the cloud loader
        
        cloudLoader.animationImages = [UIImage(named:"animatedLoadingIcon_0")!]
        for var index = 1; index < 35; index++ {
            var imageName = "animatedLoadingIcon_\(index)"
            cloudLoader.animationImages?.append(UIImage(named: imageName)!)
         
        }
        cloudLoader.animationDuration = 1
        cloudLoader.startAnimating()
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: {self.cloudLoader.alpha = 0.65}, completion: nil)
            
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateWeatherUI:", name: "weatherHasUpdated", object: nil)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage (named: "transLucentHeader"), forBarMetrics:
        UIBarMetrics.Default)
        
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Open Sans", size: 21)!,
            NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        // Create gensture recognizer for when weather loads
        
        let singleTap = UITapGestureRecognizer(target: self, action: "handleSingleTap:")
        weatherIcon.addGestureRecognizer(singleTap)
    }
    
    func handleSingleTap(recognizer: UITapGestureRecognizer){
        //Start loading the indicator
        cloudLoader.startAnimating()
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: {self.cloudLoader.alpha = 0.65}, completion: nil)

        theWeatherMan.locationManager.startUpdatingLocation()
    }
    
    func updateWeatherUI(notification: NSNotification){
        currentTemperature.text = theWeatherMan.temperatureString
        currentWeather.text = theWeatherMan.weatherString
        locationTitle.title = theWeatherMan.weatherLocation
        weatherIcon.image = UIImage(named: theWeatherMan.weatherIcon)
        cloudLoader.stopAnimating()
        UIView.animateWithDuration(0.2, delay: 0, options: .CurveEaseOut, animations: {self.cloudLoader.alpha = 0}, completion: nil)

    }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let nextViewController = segue.destinationViewController as SavedLocationsTableViewController
        nextViewController.tempLocation = locationTitle.title
    }

}

