//
//  ClosureDetailViewController.swift
//  PassData
//
//  Created by ohseungyeon on 8/5/24.
//

import UIKit

class ClosureDetailViewController: UIViewController {
    
    
    var myClosure: ((String) -> Void)? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    // function과 비슷한데 closure는 이름이 없는 차이
    @IBAction func closurePassData(_ sender: Any) {
        myClosure?("closure string")
        self.dismiss(animated: true, completion: nil)
    }
    


}
