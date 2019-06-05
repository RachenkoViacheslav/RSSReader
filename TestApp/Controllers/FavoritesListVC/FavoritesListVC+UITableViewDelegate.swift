//
//  FavoritesListVC+UITableViewDelegate.swift
//  TestApp
//
//  Created by Вячеслав on 6/4/19.
//  Copyright © 2019 Вячеслав. All rights reserved.
//

import UIKit

extension FavoritesListVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFeeds.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewOutlet.dequeueReusableCell(withIdentifier: FeedListCell.className, for: indexPath) as! FeedListCell
        cell.setupCellWithData(filteredFeeds[indexPath.row])
        return cell
    }
}

extension FavoritesListVC : UITableViewDelegate {
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
            strongSelf.deleteFromFavorite(indexPath: indexPath)
        }
        return [deleteAction]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.navigationBar.isHidden = true
        let favoriteVC = FeedDetailVC()
        favoriteVC.favFeed = filteredFeeds[indexPath.row]
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   heightForHeaderInSection section: Int) -> CGFloat {
        if feeds.isEmpty {
            return tableView.frame.height
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        if feeds.isEmpty {
            let header = Bundle.main.loadNibNamed(PlaceholderView.className,
                                                  owner: nil,
                                                  options: nil)?.first as! PlaceholderView
            return header
        }
        return nil
    }
}
