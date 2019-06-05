//
//  TableViewExtensions.swift
//

import UIKit

extension UITableView {
    func register(className: String) {
        self.register(UINib(nibName: className,
                            bundle: nil),
                      forCellReuseIdentifier: className)
    }
}
