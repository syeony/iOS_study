//
//  ViewController.swift
//  first
//
//  Created by ohseungyeon on 5/1/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var testButton: UIButton!
    
    
    @IBAction func dosomething(_ sender: Any) {
        testButton.backgroundColor = .orange
        
        let storyboard = UIStoryboard(name:"Main", bundle: nil)
        
        let detailVC=storyboard.instantiateViewController(identifier: "DetailVC") as DetailVC
        
        self.present(detailVC, animated: true,
        completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        testButton.backgroundColor=UIColor.red
    }


}

