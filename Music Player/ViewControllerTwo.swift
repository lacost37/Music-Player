//
//  ViewControllerTwo.swift
//  Music Player
//
//  Created by Mac on 19.11.2022.
//

import UIKit
import AVFoundation


class ViewControllerTwo: UIViewController {

    var timer: Timer?
    var timeSong: Double = Double()
    let arrayImage = ["gayazov", "miyagi-cover", "slawa", "katrin", "tima-cover"]
    
    // MARK: - Outlets
    
    @IBOutlet var myImageViewCover: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    
    @IBOutlet var sliderDuration: UISlider!
    
    @IBOutlet var labelTimeStart: UILabel!
    @IBOutlet var labelTimeFinish: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = songs[thisSong]
        
     //   myImageViewCover.image = UIImage(named: "\(arrayImage[0])")
        
        // slider
        sliderDuration.setThumbImage(UIImage(systemName: "circle.fill"), for: .normal)
        sliderDuration.tintColor = .systemGreen
        sliderDuration.minimumValue = 0.0
        sliderDuration.maximumValue = Float((player.duration))
        
        // создаем таймер с интервалом в 1 секунду
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
       
        // label start / finish time
        labelTimeStart.text = ""
        labelTimeStart.textColor = .lightGray
        labelTimeStart.font = .systemFont(ofSize: 16)
        labelTimeFinish.text = ""
        labelTimeFinish.textColor = .lightGray
        labelTimeFinish.font = .systemFont(ofSize: 16)
        
    }
    
   
        
        
    
    
    
    
    // MARK: = Action

    @IBAction func playSong(_ sender: Any) {
        if audioStuffed == true && player.isPlaying == false {
            player.play()
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
            
        } else {
            if audioStuffed == true && player.isPlaying {
                player.pause()
                playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
            
        }
    }
    
    
    @IBAction func prevSong(_ sender: Any) {
        if thisSong != 0 && audioStuffed == true{
            playThis(thisOne: songs[thisSong - 1])
            thisSong -= 1
            nameLabel.text = songs[thisSong]
            
        }
    }
    
    @IBAction func nextSong(_ sender: Any) {
        if thisSong < songs.count - 1 && audioStuffed == true{
            playThis(thisOne: songs[thisSong + 1])
            thisSong += 1
            nameLabel.text = songs[thisSong]
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        if audioStuffed == true {
            player.currentTime = TimeInterval(sender.value)
        }
    }
    
    // MARK: - Function
    
    func playThis(thisOne: String) {
        do
        {
            let audioPath = Bundle.main.path(forResource: thisOne, ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            
            player.play()
        }
        catch
        {
            print("ERROR")
        }
    }
    
    @objc func updateTime() {
        // время со старта
        
        let timePlayed = player.currentTime
            let minutes = Int(timePlayed / 60)
            let seconds = Int(timePlayed.truncatingRemainder(dividingBy: 60))
            labelTimeStart.text = NSString(format: "%02d:%02d", minutes, seconds) as String
        
        // время с конца
        timeSong = player.duration
        let difftime = player.currentTime - timeSong
            let minutes1 = Int(difftime / 60)
            let seconds1 = Int(-difftime.truncatingRemainder(dividingBy: 60))
            labelTimeFinish.text = NSString(format: "%02d:%02d", minutes1, seconds1) as String
        
        sliderDuration.setValue(Float(player.currentTime), animated: true)
        
    }
    
    
    
}
