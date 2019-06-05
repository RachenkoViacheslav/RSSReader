//
//  FeedListCell.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit

class FeedListCell: UITableViewCell {

    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func prepareForReuse() {
        channelNameLabel.text = ""
        titleLabel.text = ""
        timeLabel.text = ""
        contentLabel.text = ""
    }
    
    func setupCellWithData (_ rssItem:RSSItem) {
        titleLabel.text = rssItem.title
        channelNameLabel.text = Utils.getHostName(channel: rssItem.link) ?? rssItem.link
        let timeAgo = Utils.convertStringToDate(rssItem.pubDate).getElapsedInterval()
        timeLabel.text = timeAgo != "Other" ? timeAgo : Utils.correctDateFormater(rssItem.pubDate)
        contentLabel.text = Utils.prepareForPrint (rssItem.description)
    }
    
    func setupCellWithData (_ rssItem:FavFeed) {
        titleLabel.text = rssItem.title
        if let channel = rssItem.link {
            channelNameLabel.text = Utils.getHostName(channel: channel) ?? rssItem.link
        }
        
        if let date = rssItem.pubDate {
            let timeAgo = Utils.convertStringToDate(date).getElapsedInterval()
            timeLabel.text = timeAgo != "Other" ? timeAgo : Utils.correctDateFormater(date)}
        if let content = rssItem.content {contentLabel.text = Utils.prepareForPrint (content)}
    }
}
