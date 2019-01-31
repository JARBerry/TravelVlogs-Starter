//
//  Layouts.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

extension VideoFeedViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    
    loadViews()
  }
  
  func loadViews() {
    view.backgroundColor = .white
    
    tableView.register(VideoTableViewCell.classForCoder(), forCellReuseIdentifier: VideoCellReuseIdentifier)
    tableView.delegate = self
    tableView.dataSource = self
    
    view.addSubview(tableView)
    view.addSubview(videoPreviewLooper)
  }
  override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    
    tableView.frame = view.bounds
    
    videoPreviewLooper.frame = CGRect(x: view.bounds.width - 150 - 16, y: view.bounds.height - 100 - 16, width: 150, height: 100)
    videoPreviewLooper.backgroundColor = .black
  }
}

extension VideoTableViewCell {
  func addSubviews() {
    previewImageView.contentMode = .scaleAspectFill
    previewImageView.clipsToBounds = true
    previewImageView.layer.cornerRadius = 4.0
    
    addSubview(titleLabel)
    addSubview(previewImageView)
    addSubview(subtitleLabel)
  }
  
  func updateViews() {
    titleLabel.text = video?.title
    titleLabel.font = UIFont.systemFont(ofSize: 24.0)
    
    let image = UIImage(named: (video?.thumbURL.path)!)
    previewImageView.image = image
    
    subtitleLabel.text = video?.subtitle
    subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
    subtitleLabel.numberOfLines = 0
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    let previewHeight: CGFloat = 200
    let padding: CGFloat = 16
    
    let widthWithPadding = bounds.width - (2*padding)
    
    // Size
    let titleSize = titleLabel.sizeThatFits(CGSize(width: widthWithPadding, height: .infinity))
    titleLabel.bounds = CGRect(x: 0, y: 0, width: titleSize.width, height: titleSize.height)
    
    let subtitleSize = subtitleLabel.sizeThatFits(CGSize(width: widthWithPadding, height: .infinity))
    subtitleLabel.bounds = CGRect(x: 0, y: 0, width: subtitleSize.width, height: subtitleSize.height)
    
    previewImageView.bounds = CGRect(x: 0, y: 0, width: widthWithPadding, height: previewHeight)
    
    // Center
    titleLabel.center = CGPoint(x: titleLabel.bounds.width/2.0 + padding, y: padding + titleLabel.bounds.height/2.0)
    
    let imageYCenter = titleLabel.frame.origin.y + titleSize.height + padding + previewHeight/2.0
    previewImageView.center = CGPoint(x: bounds.width/2.0, y: imageYCenter)
    
    let subtitleYCenter = previewImageView.frame.origin.y + previewImageView.bounds.height + padding
    subtitleLabel.center = CGPoint(x: subtitleLabel.bounds.width/2.0 + padding, y: subtitleYCenter)
  }
}

extension VideoLooperView {
  override func layoutSubviews() {
    super.layoutSubviews()
    
    videoPlayerView.frame = bounds
    addSubview(videoPlayerView)
  }
}
