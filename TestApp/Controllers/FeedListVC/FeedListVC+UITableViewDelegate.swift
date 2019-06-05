//
//  FeedListVC+UITableViewDelegate.swift
//  TestApp
//
//  Created by Вячеслав on 6/3/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit

extension FeedListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: FeedListCell.className, for: indexPath) as! FeedListCell
        cell.setupCellWithData(filteredFeeds[indexPath.row])
        return cell
    }
}

extension FeedListVC : UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let closeAction = UIContextualAction(style: .normal, title:  "Add to Favorite", handler: { [weak self] (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            guard let strongSelf = self else {return}
            strongSelf.setFavourites(indexPath: indexPath)
        })
        closeAction.image = #imageLiteral(resourceName: "Favorite")
        closeAction.backgroundColor = .lightGray
        return UISwipeActionsConfiguration(actions: [closeAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.isHidden = true
        let favoriteVC = FeedDetailVC()
        favoriteVC.feed = filteredFeeds[indexPath.row]
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
}
