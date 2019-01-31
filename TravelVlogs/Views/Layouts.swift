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
