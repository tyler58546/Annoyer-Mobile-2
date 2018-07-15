//
//  ExtrasViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/12/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ExtrasViewController: UITableViewController {

    var timer = Timer()
    var torchOn = false
    
    ///OUTLETS
    @IBOutlet weak var brightnessSlider: UISlider!
    @IBOutlet weak var peek: UITableViewCell!
    @IBOutlet weak var pop: UITableViewCell!
    @IBOutlet weak var nope: UITableViewCell!
    
    func toggleTorch(on: Bool, torchLevel: Float?) {
        guard let device = AVCaptureDevice.default(for: AVMediaType.video)
            else {return}
        
        if device.hasTorch {
            do {
                try device.lockForConfiguration()
                
                if on == true {
                    do {
                        try device.setTorchModeOn(level: torchLevel!)
                        torchOn = true
                    } catch {
                      print("Could not set Torch Level")
                    }
                } else {
                    device.torchMode = .off
                    torchOn = false
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    func scheduledTimerWithTimeInterval(){
        // Scheduling timer to Call the function "updateCounting" with the interval of 1 seconds
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.flicker), userInfo: nil, repeats: true)
    }
    @objc func flicker() {
        if (torchOn) {
            guard let device = AVCaptureDevice.default(for: AVMediaType.video) else {
                return
            }
            do {
                try device.lockForConfiguration()
                
                if !device.isTorchActive {
                    do {
                        try device.setTorchModeOn(level: brightnessSlider.value)
                    } catch {
                        print("Could not set Torch Level")
                    }
                } else {
                    device.torchMode = .off
                }
                
                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && indexPath.row == 1) {
            //Toggle Flashlight
            if (torchOn == false) {
                toggleTorch(on: true, torchLevel: brightnessSlider.value)
            } else {
                toggleTorch(on: false, torchLevel: nil)
            }
        }
        if (indexPath.section == 2 && indexPath.row == 0) {
            //Vibrate
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
        if (indexPath.section == 2 && indexPath.row == 1) {
            //Peek
            AudioServicesPlaySystemSound(1519)
        }
        if (indexPath.section == 2 && indexPath.row == 2) {
            //Pop
            AudioServicesPlaySystemSound(1520)
        }
        if (indexPath.section == 2 && indexPath.row == 3) {
            //Nope
            AudioServicesPlaySystemSound(1521)
        }
        
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if (section == 0) {
            return "Fakes a cracked screen. Tap near the top of the screen to dismiss."
        }
        if (section == 2 && self.traitCollection.forceTouchCapability != .available) {
            return "Haptic Feedback is not available on your device."
        }
        return nil
    }
    @IBAction func sliderValueChanged(_ sender: Any) {
        if (torchOn) {
            toggleTorch(on: true, torchLevel: brightnessSlider.value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if self.traitCollection.forceTouchCapability != .available {
            
        }
        
        //scheduledTimerWithTimeInterval()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
