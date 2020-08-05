//
//  ViewController.swift
//  AR HIreApp
//
//  Created by Cryton Sibanda on 2020/07/31.
//  Copyright © 2020 Cryton Sibanda. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    var videoPlayer: AVQueuePlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var looper: AVPlayerLooper?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(true, animated: true)
           setupVideo()
       }
       
       override func viewWillDisappear(_ animated: Bool) {
           navigationController?.setNavigationBarHidden(false, animated: true)
       }
       
       func setupVideo() {
           let bundlePath  = Bundle.main.path(forResource: "video", ofType: "mp4")
           
           guard bundlePath != nil else {
               return
           }
           
           let url  = URL(fileURLWithPath: bundlePath!)
           
           let item = AVPlayerItem(url: url)
           
           videoPlayer = AVQueuePlayer(playerItem: item)
           
           looper = AVPlayerLooper(player: videoPlayer!, templateItem: item)
           
           videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
           
           videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1,
                                            y: 0,
                                            width: self.view.frame.size.width*3.1,
                                            height: self.view.frame.size.height)
           
           view.layer.insertSublayer(videoPlayerLayer!, at: 0)
           
           videoPlayer?.playImmediately(atRate: 1)
       }
       
       func setupButtons() {
           Utilities.styleFilledButton(loginButton)
           Utilities.styleHollowButton(registerButton)
       }

}

