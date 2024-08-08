//
//  DelegateDetailViewController.swift
//  PassData
//
//  Created by ohseungyeon on 8/5/24.
//

import UIKit

protocol DelegateDetailViewControllerDelegate:AnyObject{
    func passString(string: String)
}

class DelegateDetailViewController: UIViewController {

    weak var delegate: DelegateDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }

    @IBAction func passSataToMainVC(_ sender: Any) {
        delegate?.passString(string: "delegate pass Data")
        self.dismiss(animated: true, completion: nil)
    }
    

}
