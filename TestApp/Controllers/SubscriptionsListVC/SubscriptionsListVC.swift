//
//  SubscriptionsVC.swift
//  TestApp
//

import UIKit

class SubscriptionsListVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableViewOutlet: UITableView! {
        didSet {
            tableViewOutlet.delegate = self
            tableViewOutlet.dataSource = self
            tableViewOutlet.tableFooterView = UIView()
            tableViewOutlet.register(UINib(nibName: SubscriptionCell.className,
                                           bundle: nil),
                                     forCellReuseIdentifier: SubscriptionCell.className)
        }
    }
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    //MARK: Variables
    var subscriptions: [Subscription] = []
    var filteredSubscriptions: [Subscription] = []
    
    // MARK: - LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        subscriptions = CoreDataManager().fetchAllSubscriptions()
        filteredSubscriptions = subscriptions
        tableViewOutlet.reloadData()
    }
    
    // MARK: - IBAction
    @IBAction func addSubscription() {
        navigationController?.navigationBar.isHidden = true
        navigationController?.pushViewController(AddSubscriptionVC(), animated: true)
    }
    
    // MARK: - Other method
    func removeSubscription (indexPath:IndexPath) {
        CoreDataManager().deleteSubscription(filteredSubscriptions[indexPath.row]) {
            [weak self] success in
            if success {
                guard let strongSelf = self else {return}
                strongSelf.subscriptions.remove(at: indexPath.row)
                strongSelf.tableViewOutlet.deleteRows(at: [indexPath], with: .none)
            }
        }
        
    }
}

extension SubscriptionsListVC : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (searchBar.text! as NSString).replacingCharacters(in: range,
                                                                        with: text)
        filteredSubscriptions = subscriptions.filter {
            $0.link!.uppercased().contains(newText.uppercased())
        }
        tableViewOutlet.reloadData()
        
        return true
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredSubscriptions = subscriptions
            tableViewOutlet.reloadData()
        }
    }
}
