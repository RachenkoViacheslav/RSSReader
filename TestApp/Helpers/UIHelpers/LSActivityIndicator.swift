//
//  LSActivityIndicator.swift
//  CarWash
//
//  Created by Игорь on 03/11/2018.
//  Copyright © 2018 256devs. All rights reserved.
//

import UIKit
public class LSActivityIndicator {
    
    static var indicatorView: UIView!
    static var indicatorsCount = 0
    
    public class func showIndicator(fullScreen: Bool = false) {
        if indicatorView != nil { indicatorsCount += 1; return }
        indicatorView = UIView(frame: UIScreen.main.bounds)
        let backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let centerPoint = CGPoint(x: indicatorView.frame.size.width / 2,
                                  y: indicatorView.frame.size.height / 2)
        if fullScreen {
            indicatorView.backgroundColor = backgroundColor
        } else {
            indicatorView.backgroundColor = UIColor.clear
            let indicatorSubView = UIView()
            indicatorSubView.backgroundColor = backgroundColor
            indicatorSubView.frame.size = CGSize(width: 80, height: 80)
            indicatorSubView.center = centerPoint
            indicatorSubView.layer.cornerRadius = 10
            indicatorView.addSubview(indicatorSubView)
        }
        let indicator = UIActivityIndicatorView(style: .whiteLarge)
        indicator.center = centerPoint
        indicator.startAnimating()
        indicatorView.addSubview(indicator)
        
        UIApplication.shared.keyWindow?.addSubview(indicatorView!)
        indicatorsCount += 1
    }
    
    public class func hideIndicator() {
        guard let indicatorView = indicatorView else { return }
        indicatorsCount -= 1
        if indicatorsCount == 0 {
            indicatorView.removeFromSuperview()
            self.indicatorView = nil
        }
    }
}
