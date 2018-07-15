//
//  ViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/10/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UITableViewController {

    var tonePlayer: AVAudioPlayer!
    var synthesizer = AVSpeechSynthesizer()
    var crazySynth:AVSpeechSynthesizer!
    let notification = NotificationCenter.default
    
    @IBOutlet weak var ttsField: UITextField!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var crazySwitch: UISwitch!
    
    @IBOutlet weak var armSwitch: UISwitch!
    @IBOutlet weak var freqSelector: UISegmentedControl!
    
    var voice: AVSpeechSynthesisVoice = AVSpeechSynthesisVoice(language: "en-US")! {
        didSet {
            detailLabel.text = voice.getName()
        }
    }
    
    func textToSpeech(text: String?, voice: AVSpeechSynthesisVoice) -> Bool {
        
        if let text = text {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = voice
            
            synthesizer.speak(utterance)
            return true
        }
        return false
    }
    func playSound(file: String) -> Bool {
        let path = Bundle.main.path(forResource: file, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            tonePlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
            return false
        }
        return true
    }
    func readSettings() {
        let defaults = UserDefaults.standard
        
        if let defaultText = defaults.string(forKey: "ttsDefaultText") {
            ttsField.text = defaultText
        }
        if let def = defaults.object(forKey: "ttsDefaultVoice") as? Data {
            if let defaultVoice = NSKeyedUnarchiver.unarchiveObject(with: def) as? AVSpeechSynthesisVoice {
                voice = defaultVoice
            }
        }
        if let autoArm = defaults.object(forKey: "toneGeneratorAutoArm") as? Bool {
            if autoArm {
                armSwitch.isOn = true
            } else {
                armSwitch.isOn = false
            }
        }
    }
    
    @IBAction func ttsField_EditingDidEnd(_ sender: Any) {
        ttsField.resignFirstResponder()
    }
    @IBAction func stopSounds(_ sender: Any) {
        stopAllSounds()
        notification.post(name: Notification.Name("StopSounds_2"), object: nil)
    }
    @objc func stopAllSounds() {
        if let soundplayer = tonePlayer {
            if soundplayer.isPlaying {
                soundplayer.stop()
            }
        }
        
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        readSettings()
        print(AVSpeechSynthesisVoice.speechVoices())
        navigationController?.navigationBar.prefersLargeTitles = true
        notification.addObserver(self, selector: #selector(self.stopAllSounds), name: Notification.Name("StopSounds_1"), object: nil)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == 1 && indexPath.row == 0) {
            if let textToSay = ttsField.text {
                if synthesizer.isSpeaking {
                    synthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
                }
                DispatchQueue.main.async {
                    if self.crazySwitch.isOn {
                        if self.synthesizer.isSpeaking {
                            self.synthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
                        }
                        let voicesShuffled = AVSpeechSynthesisVoice.speechVoices().shuffled()
                        for voice in voicesShuffled {
                            if (voice.language == "en-US" || voice.language == "en-GB" || voice.language == "en-IE" || voice.language == "en-ZA" || voice.language == "en-AU" || voice.identifier == "com.apple.ttsbundle.siri_female_en-US_compact" || voice.identifier == "com.apple.ttsbundle.siri_male_en-US_compact" || voice.identifier == "com.apple.ttsbundle.siri_female_en-US_premium" || voice.identifier == "com.apple.ttsbundle.siri_male_en-US_premium") {
                                if (!self.textToSpeech(text: textToSay, voice: voice)) {
                                    //Failed
                                    print("Text to Speech Failed: \(textToSay)")
                                }
                            }
                            
                        }
                    } else {
                        if (!self.textToSpeech(text: textToSay, voice: self.voice)) {
                            //Failed
                            print("Text to Speech Failed: \(textToSay)")
                        }
                    }
                    
                }
                
            }
        }
        
        if (indexPath.section == 3 && indexPath.row == 0) {
            if (armSwitch.isOn) {
                switch freqSelector.selectedSegmentIndex {
                case 0:
                    if (!playSound(file: "1000hz.wav")) {
                        print("Error playing sound.")
                    }
                case 1:
                    if (!playSound(file: "5000hz.wav")) {
                        print("Error playing sound.")
                    }
                case 2:
                    if (!playSound(file: "10000hz.wav")) {
                        print("Error playing sound.")
                    }
                case 3:
                    if (!playSound(file: "15000hz.wav")) {
                        print("Error playing sound.")
                    }
                default:
                    print("error")
                }
            } else {
                //Not armed
                if synthesizer.isSpeaking {
                    synthesizer.stopSpeaking(at: AVSpeechBoundary(rawValue: 0)!)
                }
                if (!textToSpeech(text: "Error: Tone Generator is not armed.", voice: AVSpeechSynthesisVoice(language: "en-GB")!)) {
                    //error
                }
            }
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)  {
        
        
        
        if segue.identifier == "PickVoice",
            let VoicesTableViewController = segue.destination as? VoicesTableViewController {
            VoicesTableViewController.selectedVoice = voice
        }
    }
}

extension ViewController {
    @IBAction func unwindWithSelectedVoice(segue: UIStoryboardSegue) {
        if let VoicesTableViewController = segue.source as? VoicesTableViewController,
            let selectedVoice = VoicesTableViewController.selectedVoice {
            voice = selectedVoice
        }
    }
}

extension MutableCollection {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled, unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            // Change `Int` in the next line to `IndexDistance` in < Swift 4.1
            let d: Int = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            let i = index(firstUnshuffled, offsetBy: d)
            swapAt(firstUnshuffled, i)
        }
    }
}
extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
