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
