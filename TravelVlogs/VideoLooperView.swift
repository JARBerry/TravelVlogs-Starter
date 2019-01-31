//
//  VideoLooperView.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit
import AVFoundation

class VideoLooperView: UIView {
  let clips: [VideoClip]
  let videoPlayerView = VideoPlayerView()
  
  init(clips: [VideoClip]) {
    self.clips = clips
    
    super.init(frame: .zero)
    
    initalizePlayer()
    
    addGestureRecognizers()
  }
  
  // MARK - Unnecessary but necessary Code
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
    
   @objc private let player = AVQueuePlayer()
    
    private var token: NSKeyValueObservation?
    
    private func initalizePlayer() {
        videoPlayerView.player = player
        addAllVideosToPlayer()
        // Sets volume to zero by default
        player.volume = 0.0
        // Autoplay by default
        player.play()
        
        // This loops the video queue indefinetly
        token = player.observe(\.currentItem) { [weak self] player, _ in
            if player.items().count == 1 {
                self?.addAllVideosToPlayer()
            }
        }
    }
    
    private func addAllVideosToPlayer() {
        for video in clips {
            // Create an AVURLAsset from the URL of each video clip object
            let asset = AVURLAsset(url: video.url)
            // Create an AVPLayerItem with an asset that you can use to control playback
            let item = AVPlayerItem(asset: asset)
            
            // Allows you to queue each video
            player.insert(item, after: player.items().last)
        }
    }
    // Create pause function for the queue of videos
    func pause() {
        player.pause()
    }
    
   // Create play function for the queue of videos
    func play() {
        player.play()
    }
    
    // This toggles between unmute and mute each time a single tap occurs
    @objc func wasTapped() {
        player.volume = player.volume == 1.0 ? 0.0 : 1.0
    }
    
    // This toggles between speeds of the video when a double tap occurs
    @objc func wasDoubleTapped() {
        player.rate = player.rate == 1.0 ? 2.0 : 1.0
    }
    
    func addGestureRecognizers() {
        
        // Created both gesture recognizers and tell them what methods to call
        let tap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasTapped))
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(VideoLooperView.wasDoubleTapped))
        // This sets double tap to have two taps for it to work
        doubleTap.numberOfTapsRequired = 2
        
        // This makes the single tap wait to make sure a double tap is not going to happen
        tap.require(toFail: doubleTap)
        
        // This adds gesture recognizers to the video view
        addGestureRecognizer(tap)
        addGestureRecognizer(doubleTap)
    }
    
}
