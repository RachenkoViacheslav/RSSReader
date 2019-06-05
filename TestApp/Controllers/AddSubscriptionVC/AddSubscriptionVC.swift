//
//  AddSubscriptionVC.swift
//  TestApp
//

import UIKit

class AddSubscriptionVC: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var urlTextField: UITextField! {
        didSet {
            urlTextField.delegate = self
        }
    }
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    //MARK: Variables
    
    //MARK: Constants
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    // MARK: - IBActions
    @IBAction func doneAction() {
        guard let link = urlTextField.text, !link.isEmpty else {return}
        guard validateUrl(link) else {errorMessageLabel.isHidden = false; return}
        errorMessageLabel.isHidden = true
        CoreDataManager().addSubscription(link) {[weak self] success in
            if success {
                guard let strongSelf = self else {return}
                strongSelf.cancelAction()
            }
        }
    }
    @IBAction func cancelAction() {
        navigationController?.popViewController(animated: true)
        navigationController?.navigationBar.isHidden = false
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Other methods
    func validateUrl (_ stringUrl:String) -> Bool {
        let urlRegEx = "^(https?://)?(www\\.)?([-a-z0-9]{1,63}\\.)*?[a-z0-9][-a-z0-9]{0,61}[a-z0-9]\\.[a-z]{2,6}(/[-\\w@\\+\\.~#\\?&/=%]*)?$"
        let urlTest = NSPredicate(format:"SELF MATCHES %@", urlRegEx)
        let result = urlTest.evaluate(with: stringUrl)
        return result
    }
}

// MARK: - UITextFieldDelegate
extension AddSubscriptionVC : UITextFieldDelegate {
    
}
