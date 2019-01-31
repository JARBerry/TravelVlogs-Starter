//
//  Video.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class Video: NSObject {
  let url: URL
  let thumbURL: URL
  let title: String
  let subtitle: String

  init(url: URL, thumbURL: URL, title: String, subtitle: String) {
    self.url = url
    self.thumbURL = thumbURL
    self.title = title
    self.subtitle = subtitle
    super.init()
  }
  
  class func localVideos() -> [Video] {
    var videos: [Video] = []
    let names = ["newYorkFlip", "bulletTrain", "monkey", "shark"]
    let titles = ["New York Flip", "Bullet Train Adventure", "Monkey Village", "Robot Battles"]
    let subtitles = ["Can this guys really flip all of his bros? You'll never believe what happens!",
                     "Enjoying the soothing view of passing towns in Japan",
                     "Watch as a roving gang of monkeys terrorizes the top of this mountain!",
                     "Have you ever seen a robot shark try to eat another robot?"]
    
    for (index, name) in names.enumerated() {
      let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
      let url = URL(fileURLWithPath: urlPath)
      let thumbURLPath = Bundle.main.path(forResource: name, ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      
      let video = Video(url: url, thumbURL: thumbURL, title: titles[index], subtitle: subtitles[index])
      videos.append(video)
    }
    return videos
  }
  
  class func allVideos() -> [Video] {
    var videos = localVideos()
    // This URL represents a HTTP Live Stream(HLS)
    let videoURLString = "https://jarberry.github.io/images/pic_04.mov"

    // Add one remote video
    if let url = URL(string: videoURLString) {
      let thumbURLPath = Bundle.main.path(forResource: "img_pic_04_pf01", ofType: "png")!
      let thumbURL = URL(fileURLWithPath: thumbURLPath)
      
      let remoteVideo = Video(url: url, thumbURL: thumbURL, title: "Magic Paper", subtitle: "HLS link to an App I've created using ARKit2")
      videos.append(remoteVideo)
    }
    
    return videos
  }
}

