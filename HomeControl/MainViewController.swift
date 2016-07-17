//
//  MainViewController.swift
//  HomeControl
//
//  Created by Felipe Mattos at Venturus4Tech Course.
//

import UIKit

class MainViewController:UIViewController{
    
    @IBOutlet weak var lampSwitch: UISwitch!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureImage: UIImageView!
    @IBOutlet weak var buttonHistory: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        lampSwitch.addTarget(self, action: Selector("switchLamp"), forControlEvents: UIControlEvents.ValueChanged)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("fetchTemperature"))
        temperatureImage.userInteractionEnabled = true
        temperatureImage.addGestureRecognizer(tapGestureRecognizer)
        
        NSTimer.scheduledTimerWithTimeInterval(
            1,
            target: self,
            selector: "fetchLampState",
            userInfo: nil,
            repeats: true
        )
    }
    
    func fetchTemperature() {
        IOTService.sharedInstance.fetchTemperature() {(
            statuscode,
            error,
            homeModel
        ) -> Void in
            print("fetched temperature: \(homeModel!.temperatureValue)")
            let temperature = String(format: "%.0f", homeModel!.temperatureValue)
            self.temperatureLabel.text = "\(temperature)ºC"
            self.temperatureList.append("\(temperature)ºC")
        }
        
    }
    
    func switchLamp() {
        let oldState = !lampSwitch.on
        print("switchLamp changed state")
        IOTService.sharedInstance.switchLamp(lampSwitch.on) {
            (statuscode, error) -> () in
            if let _ = error {
                self.lampSwitch.setOn(oldState, animated: true)
            }
        }
    
    }
    
    func fetchLampState() {
        let oldState = !lampSwitch.on
        IOTService.sharedInstance.fetchLampState() {(
            statuscode,
            error
            ) -> Void in
            if ( statuscode == 200 ) {
                self.lampSwitch.on = true
                
            } else {
                self.lampSwitch.on = false
            }
            print(statuscode)
            print(oldState)
        // print("fetched temperature: \(statuscode)")
        }
    // print("init fn => fetchLampState")
    }
    
    var temperatureList = [String]()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let TemperatureTableViewController = segue.destinationViewController as? temperatureTableViewController
        TemperatureTableViewController!.temperatureList = temperatureList
    }
    
    
}
