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
    
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var progress: UIProgressView!
    
    let eggTimes = [ "Soft" : 3 , "Medium": 4 , "Hard":5]
    var time : Int = 0
    var endTime : Int = 0
    var timer = Timer()
    var player: AVAudioPlayer?

    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progress.progress = 0
        time = 0
        endTime = eggTimes[sender.currentTitle!]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTime) , userInfo: nil, repeats: true)
        status.text = "Starting boiling..."
        
    }
    
    @objc func updateTime() {
        
        if endTime >= time && time != 0 {
            print(time)
            status.text = "Boiling..."
            progress.progress = Float(time) / Float(endTime)
            time += 1
        }else if time == 0{
            time += 1
        }else{
            timer.invalidate()
            status.text = "Done !"
            playSound()
        }
   }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            guard let player = player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }


    
    

}
