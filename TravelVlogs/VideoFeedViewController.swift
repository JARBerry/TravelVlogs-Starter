//
//  VideoFeedViewController.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit
import AVKit

class VideoFeedViewController: UIViewController {
  var videos: [Video] = []
  
  let VideoCellReuseIdentifier = "VideoCell"
  let tableView = UITableView()
  
  let videoPreviewLooper = VideoLooperView(clips: VideoClip.allClips())
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    // Play the preview clip when you go back to the feed
    videoPreviewLooper.play()
    
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    // Pause the preview clip when you click on a video clip to watch
    videoPreviewLooper.pause()
    
  }
}

extension VideoFeedViewController: UITableViewDelegate {
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: VideoCellReuseIdentifier, for: indexPath) as? VideoTableViewCell else {
      return VideoTableViewCell()
    }
    cell.video = videos[indexPath.row]
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let video = videos[indexPath.row]
    return VideoTableViewCell.height(for: video)
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
     // Grab the video model object
    let video = videos[indexPath.row]
    
    // Take the url and create an AVPlayer object
    let videoURL = video.url
    let player = AVPlayer(url: videoURL)
    
    // This where you set the playerVC to be AVPlayerVC and shows a set of basic controls. Like play button, skip, mute and buttons to go forward and backward
    let playerViewController = AVPlayerViewController()
    playerViewController.player = player
    
    present(playerViewController, animated: true) {
        // This gets the video started
        player.play()
    }
  }
}

extension VideoFeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return videos.count
  }
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
}
