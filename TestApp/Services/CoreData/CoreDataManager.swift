//
//  CoreDataManager.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    let contextManager = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    // MARK: - Subscriptions
    func addSubscription(_ channelLink:String, completion: @escaping (Bool)->Void) {
        DispatchQueue.global(qos: .userInitiated).sync {
            
            let newChannel = NSEntityDescription.insertNewObject(forEntityName: "Subscription", into: contextManager) as! Subscription
            newChannel.link = channelLink
            newChannel.favourite = false
        }
        saveContext () {success in
            completion(success)
        }
    }
    
    func fetchAllSubscriptions() -> [Subscription] {
        var channels:[Subscription] = []
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Subscription")
        do {
            let fetchMessages = try(contextManager.fetch(request)) as? [Subscription]
            channels.append(contentsOf: fetchMessages!)
        } catch let err {
            print("fetchSubscriptions - error \(err)")
        }
        return channels
    }
    
    func deleteSubscription(_ object: Subscription, completion: @escaping (Bool)->Void) {
        contextManager.delete(object)
        saveContext () {success in
            completion(success)
        }
    }
    
    // MARK: - Feeds
    func addFeedToFavorites (_ feed:RSSItem, completion: @escaping (Bool)->Void) {
        DispatchQueue.global(qos: .userInitiated).sync {
            let favFeed = NSEntityDescription.insertNewObject(forEntityName: "FavFeed", into: contextManager) as! FavFeed
            favFeed.title = feed.title
            favFeed.pubDate = feed.pubDate
            favFeed.link = feed.link
            favFeed.content = feed.description
        }
        saveContext () {success in
            completion(success)
        }
    }
    
    func fetchFavoritesFeeds () ->[FavFeed] {
        var feeds:[FavFeed] = []
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavFeed")
        do {
            let feedItem = try(contextManager.fetch(request)) as? [FavFeed]
            if let feedItem = feedItem {
                feeds.append(contentsOf: feedItem)
            }
        } catch let err {
            print("fetchSubscriptions - error \(err)")
        }
        return feeds
    }
    
    func deleteFavFeed(_ object: FavFeed, completion: @escaping (Bool)->Void) {
        contextManager.delete(object)
        saveContext () {success in
            completion(success)
        }
    }
    
    func saveContext (completion: @escaping (Bool)->Void) {
        do {
            try contextManager.save()
            completion(true)
            print("save is OK")
        } catch let err {
            completion(false)
            print("addSubscription - error \(err)")
        }
    }
    
}
