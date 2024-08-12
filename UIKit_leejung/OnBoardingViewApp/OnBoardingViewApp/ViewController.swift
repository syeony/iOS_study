//
//  ViewController.swift
//  OnBoardingViewApp
//
//  Created by ohseungyeon on 8/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    var didShowOnboardingView = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // 영구적으로 저장하는 건 아니고 메모리상에서만 동작하도록 만든것임.
        if didShowOnboardingView == false{
            didShowOnboardingView = true
            
            let pageVC = OnBoardingPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: .none)
            pageVC.modalPresentationStyle = .fullScreen
            self.present(pageVC, animated: true, completion: nil)
        }
        
        
    }

}

