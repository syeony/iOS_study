//
//  DetailViewController.swift
//  PassData
//
//  Created by ohseungyeon on 8/4/24.
//

import UIKit

class DetailViewController: UIViewController {
    var someString = ""
    
    @IBOutlet weak var someLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        someLabel.text=someString
        
    }

    
    

}
