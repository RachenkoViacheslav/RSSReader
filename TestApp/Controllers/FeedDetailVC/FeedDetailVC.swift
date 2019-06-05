//
//  FeedDetailVC.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit
import WebKit

class FeedDetailVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favBtn: UIButton!
    //MARK: Variables
    var feed:RSSItem?
    var favFeed:FavFeed?
    var anyFeed:AnyClass?
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFeedDetailByUrl()
        setTitle()
        checkFavoriteStatus ()
    }
    
    func loadFeedDetailByUrl() {
        var link:String?
        if favFeed != nil {
            link = favFeed?.link
        } else {
            link = feed?.link
        }
        guard link != nil else {return}
        guard let url = URL(string: link!) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func setTitle () {
        if let feedTitle = feed?.title {
            titleLabel.text = feedTitle
        }
        if let feedTitle = favFeed?.title {
            titleLabel.text = feedTitle
        }
    }
    
    func setFavIcon(active:Bool) {
        if active {
            favBtn.setImage(#imageLiteral(resourceName: "favYellow"), for: .normal)
        } else {
            favBtn.setImage(#imageLiteral(resourceName: "Favorite"), for: .normal)
        }
    }
    
    func checkFavoriteStatus () {
        let allFeeds = CoreDataManager().fetchFavoritesFeeds()
        
        if let favFeed = favFeed {
            let title = allFeeds.filter {$0.title!.contains(favFeed.title!)}
            if !title.isEmpty {
                self.setFavIcon(active: true)
            } else {
                self.setFavIcon(active: false)
            }
        } else {
            guard let feed = feed else {return}
            let title = allFeeds.filter {$0.title!.contains(feed.title)}
            if !title.isEmpty {
                self.setFavIcon(active: true)
            } else {
                self.setFavIcon(active: false)
            }
        }
    }
    
    // MARK: - IBAction
    @IBAction func goBack() {
        navigationController?.navigationBar.isHidden = false
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    @IBAction func setFavourite() {
        
        let allFeeds = CoreDataManager().fetchFavoritesFeeds()
        if let favFeed = favFeed, allFeeds.contains(favFeed) {
            CoreDataManager().deleteFavFeed(favFeed) { (success) in
                if success {
                    self.setFavIcon(active: false)
                }
            }
        } else {
            guard let feed = feed else {return}
            CoreDataManager().addFeedToFavorites(feed) { (success) in
                if success {
                    self.setFavIcon(active: true)
                }
            }
        }
    }
}
