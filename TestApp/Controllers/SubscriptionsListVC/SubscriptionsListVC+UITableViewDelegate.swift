//
//  SubscriptionsListVC+UITableViewDelegate.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit

extension SubscriptionsListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredSubscriptions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: SubscriptionCell.className, for: indexPath) as! SubscriptionCell
        cell.subscriptionName.text = filteredSubscriptions[indexPath.row].link
        return cell
    }
}

extension SubscriptionsListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") {[weak self] (_, _) in
            guard let strongSelf = self else {return}
            strongSelf.removeSubscription(indexPath: indexPath)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let feedListVC = UIStoryboard.controller(from: "Main", identifier: FeedListVC.className) as? FeedListVC {
            feedListVC.specialSubscription = filteredSubscriptions[indexPath.row]
            navigationController?.pushViewController(feedListVC, animated: true)
        }
        
    }
}
