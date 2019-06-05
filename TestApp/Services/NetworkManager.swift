//
//  NetworkManager.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import Foundation

class NetworkManager {
    static func fetchRSSData (url:String, completion: @escaping ([RSSItem])->Void) {
        // http://feeds.feedburner.com/totalcryptosnews
        let feedParser = FeedParser()
        feedParser.parseFeed(url: url) { (rssItems) in
            OperationQueue.main.addOperation {
                completion(rssItems)
            }
            
        }
    }
}
