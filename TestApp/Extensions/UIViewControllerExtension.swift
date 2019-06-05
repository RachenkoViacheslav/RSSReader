//
//  UIViewControllerExtension.swift
//  TestApp
//

import UIKit

extension UIViewController {
    static var className: String {
        return String(describing: self)
    }
}
