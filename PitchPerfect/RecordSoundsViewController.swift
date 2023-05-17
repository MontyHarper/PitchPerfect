//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Monty Harper on 5/1/23.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    let segueID = "stopRecording" //suggested by reviewer; using a string each time can invite typos
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    func toggleUI (isRecording: Bool) {
        
        //* This is the function suggested in the "Clean Up" lesson, which switches the UI back and forth between recording and not recording states. *//
        
        if isRecording {
            recordingLabel.text = "Recording in Progress"
        } else {
            recordingLabel.text = "Tap to Record"
        }
        recordButton.isEnabled = !isRecording
        stopRecordingButton.isEnabled = isRecording
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleUI (isRecording: false)
    }
    
    
    @IBAction func stopRecording(_ sender: Any) {
        toggleUI (isRecording: false)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    @IBAction func RecordAudio(_ sender: Any) {
        toggleUI(isRecording: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            performSegue(withIdentifier: segueID, sender: audioRecorder.url)
        } else {
            print("recording was not successful")
            /* Will we come back here to give the app a response to an unsuccessful recording?
             Oh, it looks like that gets covered in the extension. I'll leave the print statement here for debugging purposes, I suppose? */
        }
    }
    
    override func prepare(for segue:UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == segueID {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordAudioURL
        } else {
            /* What if this isn't the right segue? I guess we only set up one segue out of this scene. If there were multiple segues would this need to be a switch statement? Is the if statement really necessary in this case? */
        }
        
    }
    
}
