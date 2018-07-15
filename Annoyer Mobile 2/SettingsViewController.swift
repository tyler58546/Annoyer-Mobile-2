//
//  SettingsViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/12/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UITableViewController {

    var voice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: "en-US")! {
        didSet {
            detailLabel.text = voice.getName()
            saveSettings()
        }
    }
    
    
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var ttsDefaultField: UITextField!
    @IBOutlet weak var autoArmSwitch: UISwitch!
    @IBAction func tsDefaultField_return(_ sender: Any) {
        ttsDefaultField.resignFirstResponder()
        saveSettings()
    }
    @IBAction func autoArmSwitch_click(_ sender: Any) {
        saveSettings()
    }
    
    func archiveVoice(voice: AVSpeechSynthesisVoice) -> Data {
        let archivedObject = NSKeyedArchiver.archivedData(withRootObject: voice)
        return archivedObject
    }
    
    func saveSettings() {
        let defaults = UserDefaults.standard
        
        if let ttsDefault = ttsDefaultField.text {
            defaults.set(ttsDefault, forKey: "ttsDefaultText")
        }
        
        defaults.set(archiveVoice(voice: voice), forKey: "ttsDefaultVoice")
        
        if (autoArmSwitch.isOn) {
            UserDefaults.standard.set(true, forKey: "toneGeneratorAutoArm")
        } else {
            UserDefaults.standard.set(false, forKey: "toneGeneratorAutoArm")
        }
    }
    func readSettings() {
        let defaults = UserDefaults.standard
        
        if let defaultText = defaults.string(forKey: "ttsDefaultText") {
            ttsDefaultField.text = defaultText
        }
        if let def = defaults.object(forKey: "ttsDefaultVoice") as? Data {
            if let defaultVoice = NSKeyedUnarchiver.unarchiveObject(with: def) as? AVSpeechSynthesisVoice {
                voice = defaultVoice
            }
        }
        if let autoArm = defaults.object(forKey: "toneGeneratorAutoArm") as? Bool {
            if autoArm {
                autoArmSwitch.isOn = true
            } else {
                autoArmSwitch.isOn = false
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        readSettings()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        
        
        
        if segue.identifier == "SettingsPickVoice",
            let VoicesTableViewController = segue.destination as? VoicesTableViewController {
            VoicesTableViewController.selectedVoice = voice
        }
    }
}
extension SettingsViewController {
    @IBAction func unwindWithSelectedVoice(segue: UIStoryboardSegue) {
        if let VoicesTableViewController = segue.source as? VoicesTableViewController,
            let selectedVoice = VoicesTableViewController.selectedVoice {
            voice = selectedVoice
        }
    }
}
