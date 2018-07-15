//
//  SoundData.swift
//  Annoyer Mobile 2
//
//  Created by Tyler Knox on 7/13/18.
//  Copyright © 2018 tyler58546. All rights reserved.
//

import Foundation

final class SoundData {
    var sounds = ["alarm-clock.mp3", "nails-chalkboard.mp3", "ebs.mp3", "car-alarm.mp3", "dog-bark.mp3", "siren.mp3", "birds.mp3", "wtf.mp3", "baby-cry.mp3", "fork-glass.mp3", "goat.mp3"]
    
    static func generateSoundData() -> [SoundEffect] {
        var items = ["Alarm Clock", "Nails on Chalkboard", "Emergency Broadcast System", "Car Alarm", "Dog Barking", "Siren", "Birds Chirping", "???", "Baby Crying", "Fork on Glass", "Goat Screaming"]
        var images = ["alarm-clock", "nails-chalkboard", "ebs", "car-alarm", "dog-bark", "siren", "birds", "wtf", "baby-cry", "fork-glass", "goat"]
        var sounds = ["alarm-clock.mp3", "nails-chalkboard.mp3", "ebs.mp3", "car-alarm.mp3", "dog-bark.mp3", "siren.mp3", "birds.mp3", "wtf.mp3", "baby-cry.mp3", "fork-glass.mp3", "goat.mp3"]
        
        
        return [
            SoundEffect(name: items[0], sound: sounds[0], image: images[0]),
            SoundEffect(name: items[1], sound: sounds[1], image: images[1]),
            SoundEffect(name: items[2], sound: sounds[2], image: images[2]),
            SoundEffect(name: items[3], sound: sounds[3], image: images[3]),
            SoundEffect(name: items[4], sound: sounds[4], image: images[4]),
            SoundEffect(name: items[5], sound: sounds[5], image: images[5]),
            SoundEffect(name: items[6], sound: sounds[6], image: images[6]),
            SoundEffect(name: items[7], sound: sounds[7], image: images[7]),
            SoundEffect(name: items[8], sound: sounds[8], image: images[8]),
            SoundEffect(name: items[9], sound: sounds[9], image: images[9]),
            SoundEffect(name: items[10], sound: sounds[10], image: images[10])
        ]
    }
}
