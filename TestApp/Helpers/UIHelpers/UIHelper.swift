//
//  UIHelper.swift
//

import UIKit

class UIHelper {
    
    //MARK:- Methods
    class func showConfirmationAlertWith(title: String?,
                                         message: String?,
                                         action: (() -> ())? = nil,
                                         inViewController viewController: UIViewController) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: { (alertAction) in
                                        action?()
        }))
        viewController.present(alert, animated: true, completion: nil)
    }
    
    class func showAlertWithTwoButtons(title: String?,
                                       message: String?,
                                       firstButtonTitle: String?,
                                       secondButtonTitle: String?,
                                       inViewController viewController: UIViewController,
                                       completion: @escaping (Bool) -> ()) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: firstButtonTitle,
                                      style: .default,
                                      handler: { (alertAction) in
                                        completion(true)
        }))
        
        alert.addAction(UIAlertAction(title: secondButtonTitle,
                                      style: .default,
                                      handler: { (alertAction) in
                                        completion(false)
        }))
        viewController.present(alert,
                               animated: true,
                               completion: nil)
    }
    
    class func addShadowToView(view: UIView) {
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.7
        view.layer.shadowRadius = 15
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
    }
    
    class func addShadowToButton(button: UIButton) {
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowRadius = 5
        button.layer.shadowOffset = CGSize(width: CGFloat(0), height: CGFloat(14.0))
    }
}
