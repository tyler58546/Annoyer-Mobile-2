//
//  SoundsTableViewController.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/13/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import UIKit
import AVFoundation

class SoundsTableViewController: UITableViewController {

    let notification = NotificationCenter.default
    var soundeffects = SoundData.generateSoundData()
    var soundPlayer:AVAudioPlayer!
    
    func playSound(file: String) -> Bool {
        let path = Bundle.main.path(forResource: file, ofType:nil)!
        let url = URL(fileURLWithPath: path)
        
        do {
            let sound = try AVAudioPlayer(contentsOf: url)
            soundPlayer = sound
            sound.play()
        } catch {
            // couldn't load file :(
            return false
        }
        return true
    }
    @IBAction func stopSounds(_ sender: Any) {
        
        stopAllSounds()
        notification.post(name: Notification.Name("StopSounds_1"), object: nil)
    }
    @objc func stopAllSounds() {
        if let soundplayer = soundPlayer {
            if soundplayer.isPlaying {
                soundplayer.stop()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        notification.addObserver(self, selector: #selector(self.stopAllSounds), name: Notification.Name("StopSounds_2"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source


    

}

extension SoundsTableViewController {
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return soundeffects.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! SoundEffectCell
        
        // Configure the cell...
        
        cell.soundeffect = soundeffects[indexPath.row]
        
        return cell
    }
    
    
    
}

extension SoundsTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // User clicked on cell...
        print("PlaySound: \(soundeffects[indexPath.row].sound)")
        if (!playSound(file: soundeffects[indexPath.row].sound)) {
            print("Failed to play sound")
        }
        
    }
}
