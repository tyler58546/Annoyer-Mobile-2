//
//  VoicesTableViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/11/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation



class VoicesTableViewController: UITableViewController {

    //var voices = AVSpeechSynthesisVoice.speechVoices()
    
    func voices() -> [AVSpeechSynthesisVoice] {
        var v:[AVSpeechSynthesisVoice] = []
        for voice in AVSpeechSynthesisVoice.speechVoices() {
            if (voice.language == "en-US" || voice.language == "en-GB" || voice.language == "en-IE" || voice.language == "en-ZA" || voice.language == "en-AU" || voice.identifier == "com.apple.ttsbundle.siri_female_en-US_compact" || voice.identifier == "com.apple.ttsbundle.siri_male_en-US_compact" || voice.identifier == "com.apple.ttsbundle.siri_female_en-US_premium" || voice.identifier == "com.apple.ttsbundle.siri_male_en-US_premium") {
                
                
                v.append(voice)
            }
        }
        return v
    }
    

    var selectedVoice: AVSpeechSynthesisVoice? {
        didSet {
            if let selectedVoice = selectedVoice,
                let index = voices().index(of: selectedVoice) {
                selectedVoiceIndex = index
            }
        }
    }
    
    var selectedVoiceIndex: Int?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "SaveSelectedVoice",
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) else {
                return
        }
        
        let index = indexPath.row
        selectedVoice = voices()[index]
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.largeTitleDisplayMode = .never
    }
    
        
    
        
        
        
    
    
    
    
    
    
    
    
    
    
    
    
}

extension AVSpeechSynthesisVoice {
    func getName() -> String {
        if (self.identifier == "com.apple.ttsbundle.siri_female_en-US_compact") {
            return "Siri (Female)"
        }
        if (self.identifier == "com.apple.ttsbundle.siri_male_en-US_compact") {
            return "Siri (Male)"
        }
        if (self.identifier == "com.apple.ttsbundle.siri_female_en-US_premium") {
            return "Siri (Female, Enhanced)"
        }
        if (self.identifier == "com.apple.ttsbundle.siri_male_en-US_premium") {
            return "Siri (Male, Enhanced)"
        }
        return self.name
    }
}

extension VoicesTableViewController {
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return voices().count
    }
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if section == 0 {
            return "Additional voices can be downloaded in settings. (General/Accessibility/Speech/Voices/English)"
        }
        return nil
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoiceCell", for: indexPath)
        cell.textLabel?.text = voices()[indexPath.row].getName()
        
        
        
        if indexPath.row == selectedVoiceIndex {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    
}
// MARK: - UITableViewDelegate
extension VoicesTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Other row is selected - need to deselect it
        if let index = selectedVoiceIndex {
            let cell = tableView.cellForRow(at: IndexPath(row: index, section: 0))
            cell?.accessoryType = .none
        }
        
        selectedVoice = voices()[indexPath.row]
        
        // update the checkmark for the current row
        let cell = tableView.cellForRow(at: indexPath)
        cell?.accessoryType = .checkmark
    }
}
