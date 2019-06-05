//
//  UIStoryboardExtension.swift
//  TestApp

import UIKit

extension UIStoryboard {
    
    static func controller(from storyboardName: String, identifier: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardName, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: identifier)
    }
}
