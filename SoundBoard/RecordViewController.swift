//
//  RecordViewController.swift
//  SoundBoard
//
//  Created by Jake Wojtas on 4/12/17.
//  Copyright © 2017 Jake Wojtas. All rights reserved.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController {
    
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var soundNameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    
    var audioRecorder : AVAudioRecorder?
    var audioPlayer : AVAudioPlayer?
    var audioURL : URL?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpRecorder()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setUpRecorder() {
        do {
            // Create an audio session
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            // Creating URL for the audio file
            let basePath : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "FIRSTAUDIO.m4a"]
            audioURL = NSURL.fileURL(withPathComponents: pathComponents)
            //Finding audioURL location
            print("###########")
            print(audioURL!)
            print("###########")
        
            
            
            
            // Creating settings for audio recorder
            
            var settings : [String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
            
            
            
            
            // Create AudioRecorder object
            audioRecorder = try AVAudioRecorder(url: audioURL!, settings: settings)
            audioRecorder!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        } catch {
            print("Error")
        }
    }

    
    @IBAction func recordButton(_ sender: UIButton) {
        
        if audioRecorder!.isRecording {
            // Stop the recording
            audioRecorder?.stop()
            
            // Change button title to Record
            recordButton.setTitle("Record", for: .normal)
        } else {
            // Start the recording
            audioRecorder?.record()
            // Change button title to Stop
            recordButton.setTitle("Stop", for: .normal)
            
        }
        
    }
    
    @IBAction func playButton(_ sender: UIButton) {
        //Setting up audioplayer
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: audioURL!)
            audioPlayer!.play()
        }
        catch {}
        
    }
    
    @IBAction func addButton(_ sender: UIButton) {
    }
    
    
    
    
    


}
