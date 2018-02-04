//
//  ThirdViewController.swift
//  Lab1
//
//  Created by Michael Tang on 2/2/18.
//  Copyright © 2018 Michael Tang. All rights reserved.
//

import UIKit
import AVFoundation

class ThirdViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {
    
    var recorder:AVAudioRecorder!
    var player:AVAudioPlayer!
    
    @IBAction func record(_ sender: Any) {
        recorder.record()
        print("Recording")
    }
    
    @IBAction func play(_ sender: Any) {
        do {
            try player = AVAudioPlayer(contentsOf: (recorder?.url)!)
            player!.delegate = self
            player!.prepareToPlay()
            print("Playing")
            player!.play()
        } catch let error as NSError {
            print("Error with playing recording: \(error.localizedDescription)")
        }

    }
    @IBAction func stop(_ sender: Any) {
        recorder.stop()
        print("Stopped recording")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let dirPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docDir = dirPath[0]
        let audioFileURL = docDir.appendingPathComponent("recording.m4a")
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        } catch {
            print("Error with audio session: \(error.localizedDescription)")
        }
        
        let recordSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            recorder = try AVAudioRecorder(url: audioFileURL, settings: recordSettings)
            recorder?.prepareToRecord()
            print("Recorder reader")
        } catch {
            print("Error with audio recording: \(error.localizedDescription)")
        }
        
        recorder.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
