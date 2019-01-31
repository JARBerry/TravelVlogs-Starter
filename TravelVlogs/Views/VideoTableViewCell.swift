//
//  VideoTableViewCell.swift
//  TravelVlogs
//
//  Created by James Berry on 31/1/2019.
//  Copyright © 2019 JARBerry. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
  let titleLabel = UILabel()
  let previewImageView = UIImageView()
  let subtitleLabel = UILabel()

  var video: Video? = nil {
    didSet {
      updateViews()
    }
  }
  
  // Sizing
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(false, animated: false)
  }
  
  // MARK - Table Cell Height
  
  class func height(for viewModel: Video) -> CGFloat {
    let previewHeight: CGFloat = 200
    let padding: CGFloat = 16

    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 24.0)
    label.text = viewModel.title
    let titleHeight = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 32, height: .infinity)).height
    
    label.text = viewModel.subtitle
    label.font = UIFont.systemFont(ofSize: 14.0)
    let subtitleHeight = label.sizeThatFits(CGSize(width: UIScreen.main.bounds.width - 32, height: .infinity)).height
    
    return padding + titleHeight + padding + previewHeight + padding + subtitleHeight + padding
  }
  
  // MARK - Obligatory Inits
  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubviews()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    backgroundColor = .blue
  }
}
