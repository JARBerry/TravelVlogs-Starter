//
//  AppDelegate.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    // This allows the user to still be listening to their own music while still on the app and they have the choice to turn their music off not the application
    try? AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient, mode: AVAudioSessionModeMoviePlayback, options: [.mixWithOthers])
    window = UIWindow(frame: UIScreen.main.bounds)
    
    
    let feed = VideoFeedViewController()
    // This sets the video feed to be from a url
    feed.videos = Video.allVideos()
    // This commented code below sets the video feed to be from local videos
//    feed.videos = Video.localVideos()
    // This where the Navigation Bars title is set
    feed.title = "JARBerry Vlogs"
    
    // Here i set the Navigation Bars text size, text font and text colour
    let nav = UINavigationController(rootViewController: feed)
    nav.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.black,
                                             NSAttributedStringKey.font: UIFont(name: "Roboto-Bold", size: 21)!]
    

    window?.rootViewController = nav
    window?.makeKeyAndVisible()
    
    return true
  }
}

