//
//  ViewController.swift
//  Music Player
//
//  Created by Mac on 18.11.2022.
//

import UIKit
import AVFoundation

var songs: [String] = []
var player = AVAudioPlayer()
var thisSong = 0
var audioStuffed = false

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    @IBOutlet var myTableView: UITableView!
    
    // количество строк
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    // имя строки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = songs[indexPath.row]
        return cell
    }
    // выбор строки
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        do
        {
            let audioPath = Bundle.main.path(forResource: songs[indexPath.row], ofType: ".mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
            player.play()
            thisSong = indexPath.row
            audioStuffed = true
           
            
            
            
          
            
        }
        catch
        {
            print("ERROR")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gettingSongName()
    }

    // получаем имя песни
    func gettingSongName() {
        let folderURL = URL(fileURLWithPath: Bundle.main.resourcePath!)
        
        // проверка
        do
        {
            let songPath = try FileManager.default.contentsOfDirectory(at: folderURL, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
            
            for song in songPath {
                var mySong = song.absoluteString
                
                if mySong.contains(".mp3") {
                    let findString = mySong.components(separatedBy: "/")
                    mySong = findString[findString.count - 1]
                    mySong = mySong.replacingOccurrences(of: "%20", with: " ")
                    mySong = mySong.replacingOccurrences(of: ".mp3", with: "")
                    // добавляем песни в массив
                    songs.append(mySong)
                }
            }
            // запускаем наш тэйбл вью
            myTableView.reloadData()
        }
        catch
        {
            
        }
    }

}

