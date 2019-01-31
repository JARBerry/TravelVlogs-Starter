/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

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
