//
//  FeedListVC.swift
//

import UIKit

class FeedListVC: UIViewController {
    //MARK: IBOutlets
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
    @IBOutlet weak var rightBarButton: UIButton!
    //MARK: Variables
    var feeds: [RSSItem] = []
    var filteredFeeds: [RSSItem] = []
    var specialSubscription:Subscription?
    // MARK: - Constants
    let defaultSubscriptions = ["https://www.ua-football.com/rss/all.xml",
                                "https://www.sports.ru/rss/rubric.xml?s=208",
                                "https://www.liga.net/tech/gadgets/rss.xml" ]
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        loadData ()
    }
    override func viewDidLoad() {
        prepareData()
        configRightBarButton ()
    }
    
    // MARK: - Preparation
    func prepareData () {
        let firstLaunch = UserDefaults.standard.value(forKey: "firstLaunch") as? Bool
        
        if firstLaunch == nil {
            UserDefaults.standard.set(true, forKey: "firstLaunch")
            for subscription in defaultSubscriptions {
                CoreDataManager().addSubscription(subscription) {[weak self] (_) in
                    guard let strongSelf = self else {return}
                    strongSelf.loadData()
                }
            }
        }
    }
    
    func configRightBarButton () {
        if specialSubscription != nil {
            rightBarButton.frame = CGRect(x: 0.0, y: 0.0, width: rightBarButton.frame.width, height: 28)
            rightBarButton.setTitle(" DELETE CHANEL ", for: .normal)
            rightBarButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0, alpha: 1)
            rightBarButton.setTitleColor(.white, for: .normal)
            rightBarButton.layer.cornerRadius = rightBarButton.frame.height / 2
            
        } else {
            rightBarButton.setTitle("+", for: .normal)
            rightBarButton.titleLabel?.font = .systemFont(ofSize: 42.0, weight: .ultraLight)
        }
    }
    
    // MARK: - Other methods
    func setFavourites (indexPath: IndexPath) {
        CoreDataManager().addFeedToFavorites(filteredFeeds[indexPath.row]) {_ in }
    }
    
    func loadData () {
        if let specialSubscriptionURL = specialSubscription?.link {
            NetworkManager.fetchRSSData(url: specialSubscriptionURL) {[weak self] (response) in
                guard let strongSelf = self else {return}
                strongSelf.filteredFeeds = response
                strongSelf.feeds = response
                strongSelf.tableViewOutlet.reloadData()
            }
        } else {
            loadNews ()
        }
    }
    
    func loadNews () {
        let subscriptions = CoreDataManager().fetchAllSubscriptions()
        feeds.removeAll()
        for i in 0..<subscriptions.count {
            if let rssURL = subscriptions[i].link {
                NetworkManager.fetchRSSData(url: rssURL) { (response) in
                    
                    self.feeds += response
                    self.prepareForPrint ()
                }
                
            }
            
        }
    }
    func prepareForPrint () {
        
        let sortedNews = feeds.sorted(by: {Utils.convertStringToDate($0.pubDate) > Utils.convertStringToDate($1.pubDate)})
        self.filteredFeeds = sortedNews
        self.feeds = sortedNews
        self.tableViewOutlet.reloadData()
        
    }
    // MARK: - IBAction
    @IBAction func rightBarButtonAction() {
        if specialSubscription != nil {
           CoreDataManager().deleteSubscription(specialSubscription!) {
                [weak self] success in
                if success {
                    guard let strongSelf = self else {return}
                    strongSelf.navigationController?.popViewController(animated: true)
                }
            }
        } else {
            navigationController?.navigationBar.isHidden = true
            navigationController?.pushViewController(AddSubscriptionVC(), animated: true)
        }
    }
}

extension FeedListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (searchBar.text! as NSString).replacingCharacters(in: range,
                                                                        with: text)
        filteredFeeds = feeds.filter {
            $0.title.uppercased().contains(newText.uppercased())
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
