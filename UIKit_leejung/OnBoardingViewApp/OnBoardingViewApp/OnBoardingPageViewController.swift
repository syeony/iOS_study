//
//  OnBoardingPageViewController.swift
//  OnBoardingViewApp
//
//  Created by ohseungyeon on 8/11/24.
//

import UIKit

class OnBoardingPageViewController: UIPageViewController {
    
    var pages = [UIViewController]()
    var bottomButtonMargin: NSLayoutConstraint?
    var pageControl = UIPageControl()
    let startIndex = 0
    
    var currentIndex = 0{
        didSet{
            pageControl.currentPage = currentIndex
        }
    }
    
    func makePageVC(){
        let itemVC1 = OnBoardingitemViewController.init(nibName: "OnBoardingitemViewController", bundle: nil)
        itemVC1.mainText = "첫번째"
        itemVC1.topImage = UIImage(named:"onboarding1")
        itemVC1.subText = "환영합니다"
        
        let itemVC2 = OnBoardingitemViewController.init(nibName: "OnBoardingitemViewController", bundle: nil)
        itemVC2.mainText = "두번째"
        itemVC2.topImage = UIImage(named:"onboarding2")
        itemVC2.subText = "저의 온보딩화면에 온 것을!"
        
        let itemVC3 = OnBoardingitemViewController.init(nibName: "OnBoardingitemViewController", bundle: nil)
        itemVC3.mainText = "세번째"
        itemVC3.topImage = UIImage(named:"onboarding3")
        itemVC3.subText = "세번째 페이지입니다"
        
        pages.append(itemVC1)
        pages.append(itemVC2)
        pages.append(itemVC3)
        
        setViewControllers([itemVC1], direction: .forward, animated: true, completion: nil)
        
        self.dataSource = self
        self.delegate = self
    }

    // main
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.makePageVC()
        self.makeBottomButton()
        self.makePageControl()
    }
    
    // 오토레이아웃말고 다 코드로 버튼 구현
    func makeBottomButton(){
        let button = UIButton()
        button.setTitle("확인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemBlue
        button.addTarget(self, action: #selector(dismissPageVC), for: .touchUpInside)
        
        self.view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false //오토레이어 설정하려면 false로 해놔야한다
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        bottomButtonMargin = button.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        bottomButtonMargin?.isActive = true
        
        hideButton()
    }
    
    // 이 점점점도 코드로만 다 구현
    func makePageControl(){
        self.view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = startIndex
                
        pageControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -60).isActive = true
        pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pageControl.addTarget(self, action: #selector(pageControlTapped), for: .valueChanged)
    }
    
    @objc func pageControlTapped(sender: UIPageControl){
        
        if sender.currentPage > self.currentIndex{
            self.setViewControllers([pages[sender.currentPage]], direction: .forward, animated: true)
        }else{
            self.setViewControllers([pages[sender.currentPage]], direction: .reverse, animated: true)
        }
        
        self.currentIndex = sender.currentPage
        
        buttonPresentationStyle()
    }
    
    @objc func dismissPageVC(){
        self.dismiss(animated: true, completion: nil)
    }

}

extension OnBoardingPageViewController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? { //다음화면이 뭐냐?
        
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == 0 {
            return pages.last
        }else{
            return pages[currentIndex - 1]
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? { //이전화면이 뭐냐?
        guard let currentIndex = pages.firstIndex(of: viewController) else {
            return nil
        }
        
        self.currentIndex = currentIndex
        
        if currentIndex == pages.count - 1 {
            return pages.first
        }else{
            return pages[currentIndex + 1]
        }
    }
    
    
}

extension OnBoardingPageViewController: UIPageViewControllerDelegate{
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard let currentVC = pageViewController.viewControllers?.first else{
            return
        }
        
        guard let currentIndex = pages.firstIndex(of: currentVC) else{
            return
        }
        
        self.currentIndex = currentIndex
        
        buttonPresentationStyle()
        
    }
    
    func buttonPresentationStyle(){
        if currentIndex == pages.count - 1 {
            self.showButton()
        }else{
            self.hideButton()
        }
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.5, delay: 0, options: [.curveEaseInOut],animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    // 깔끔한 코딩
    // 사람이 개발을 하는 거기 때문에 '어 이게 뭐였지' 생각들게 코드를 만들면 안 된다.
    func showButton(){
        bottomButtonMargin?.constant = 0
    }
    
    func hideButton(){
        bottomButtonMargin?.constant = 100
    }
}
