//
//  VideoPlayerView.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    // wrapping player layer in a view
    var playerLayer: AVPlayerLayer {
        return layer as! AVPlayerLayer
    }
    
    // setting and getting player layer
    var player: AVPlayer? {
        get {
            return playerLayer.player
        }
        set {
            playerLayer.player = newValue
        }
    }
    
    // use AVPlayerLayer instead of CALayer
    override class var layerClass: AnyClass {
        return AVPlayerLayer.self
        
        
    }

}


