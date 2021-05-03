//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let eggTimes = ["soft": 2, "medium": 420, "hard": 720]
    var timer = Timer()
    var secondsPassed = 0
    var totalTime = 0
    var alarmSound: AVAudioPlayer!
    
    @IBAction func cookTime(_ sender: UIButton) {
        timer.invalidate()

        let hardness = sender.currentTitle!
            
        totalTime = eggTimes[hardness.lowercased()]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            timer.invalidate()
            titleLabel.text = "DONE!"
            
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
                    alarmSound = try! AVAudioPlayer(contentsOf: url!)
                    alarmSound.play()
        }
    }
}
