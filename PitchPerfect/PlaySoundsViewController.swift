//
//  playSoundsViewController.swift
//  PitchPerfect
//
//  Created by Monty Harper on 5/5/23.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {

    // MARK: Outlets

    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var chipmunkButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var echoButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // MARK: Variables
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
        
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAudio()
        
        /* I found this idea in the knowledge forum. The audio should stop playing if the user switches back to the record screen using the navigation bar. This will stop the audio if the view changes, regardless of why, which will provide robust functionality in the event of any future additions or changes to the app. */
    }
    
    // MARK: Actions

    @IBAction func playSoundForButton(_ sender: UIButton) {
    
        // MARK: - Upgrade Idea
        /* I have changed the parameters below to create effects more to my liking. It might be fun to change the buttons to sliders so the UI could pass values for rate, pitch, echo & reverb (wet/dry ratio) providing a larger range of effects to play with. I imagine we'll cover sliders in the next course. If not, I'll come back to this. */
        
        switch(ButtonType(rawValue: sender.tag)!) {
            case .slow:
            playSound(rate: 0.5)
            case .fast:
            playSound(rate: 2)
            case .chipmunk:
            playSound(rate: 2.5, pitch: 2000)
            case .vader:
            playSound(rate: 0.75, pitch: -1000)
            case .echo:
            playSound(echo: true)
            case .reverb:
            playSound(reverb: true)
            }

            configureUI(.playing)
        }
    

    @IBAction func stopButtonPressed(_ sender: AnyObject) {
        stopAudio()
        configureUI(.notPlaying)
    }
    


}
