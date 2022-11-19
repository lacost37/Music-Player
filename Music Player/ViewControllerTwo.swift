//
//  ViewControllerTwo.swift
//  Music Player
//
//  Created by Mac on 19.11.2022.
//

import UIKit
import AVFoundation

class ViewControllerTwo: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet var myImageViewCover: UIImageView!
    
    @IBOutlet var nameLabel: UILabel!
    
    @IBOutlet var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = songs[thisSong]
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
        } else {
           
        }
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        if audioStuffed == true {
            player.volume = sender.value
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
}
