//
//  FavoritesListVC.swift
//  TestApp
//
//  Created by Вячеслав on 6/4/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit

class FavoritesListVC: UIViewController {
    @IBOutlet weak var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.dataSource = self
            tableViewOutlet.delegate = self
            tableViewOutlet.tableFooterView = UIView()
            tableViewOutlet.register(UINib(nibName: FeedListCell.className,
                                           bundle: nil),
                                     forCellReuseIdentifier: FeedListCell.className)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //MARK: Variables
    var feeds: [FavFeed] = []
    var filteredFeeds: [FavFeed] = []
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        fetchFavoritesFeeds ()
    }
    
    // MARK: - Other methods
    func fetchFavoritesFeeds () {
        feeds = CoreDataManager().fetchFavoritesFeeds()
        let sortedNews = feeds.sorted(by: {Utils.convertStringToDate($0.pubDate!) > Utils.convertStringToDate($1.pubDate!)})
        feeds = sortedNews
        filteredFeeds = sortedNews
        tableViewOutlet.reloadData()
    }
    
    func deleteFromFavorite (indexPath:IndexPath) {
        CoreDataManager().deleteFavFeed(filteredFeeds[indexPath.row]) {
            [weak self] success in
            if success {
                guard let strongSelf = self else {return}
                strongSelf.filteredFeeds.remove(at: indexPath.row)
                strongSelf.tableViewOutlet.deleteRows(at: [indexPath], with: .none)
            }
        }
    }
}

extension FavoritesListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (searchBar.text! as NSString).replacingCharacters(in: range,
                                                                    with: text)
        filteredFeeds = feeds.filter {
            $0.title!.uppercased().contains(newText.uppercased())
        }
        tableViewOutlet.reloadData()
        
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredFeeds = feeds
            tableViewOutlet.reloadData()
        }
    }
}
