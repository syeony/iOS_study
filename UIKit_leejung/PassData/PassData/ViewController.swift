//
//  ViewController.swift
//  PassData
//
//  Created by ohseungyeon on 5/7/24.
//
// passing data (데이터를 넘겨주는 방법
// 6가지
// 1. instance property
// 2. segue
// 3. instance
// 4. delegate (delegation) pattern 대리 위임 대신 느낌
// 5. closure
// 6. notification 연결점이 없는데 뭘 하고싶다 할때 사용

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationName = Notification.Name("sendSomeString")
        
        NotificationCenter.default.addObserver(self, selector: #selector(showSomeString), name: notificationName, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    @objc func keyboardWillShow(){
        print("will show")
    }
    
    @objc func keyboardDidShow(){
        print("did show")
    }
    
    @objc func showSomeString(notification: Notification){
        if let str = notification.userInfo?["str"] as? String{
            self.dataLabel.text=str
        }
        
        
    }
    
    @IBOutlet weak var dataLabel: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail"{
            if let detailVC = segue.destination as? segueDetailViewController{
                detailVC.dataString = "abcd"
            }
        }
    }

    @IBAction func moveTodetail(_ sender: Any) {
        let detailVC = DetailViewController(nibName: "DetailViewController", bundle: nil)
        
        //detailVC.someString="aaa"
        
        self.present(detailVC, animated: true, completion: nil)
        // present 뒤에 써야 에러가 안남
        detailVC.someLabel.text="bb"
    }
    
    @IBAction func moveToInstance(_ sender: Any) {
        let detailVC = InstanceDetailViewController(nibName: "InstanceDetailViewController", bundle: nil)
        
        detailVC.mainVC = self
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToDelegate(_ sender: Any) {
        let detailVC = DelegateDetailViewController(nibName: "DelegateDetailViewController", bundle: nil)
        
        detailVC.delegate=self
        self.present(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToClosure(_ sender: Any) {
        let detailVC = ClosureDetailViewController(nibName: "ClosureDetailViewController", bundle: nil)
        
        detailVC.myClosure = { str in
            self.dataLabel.text=str
        }
        
        self.present(detailVC, animated: true, completion: nil)
    }
    
    @IBAction func moveToNoti(_ sender: Any) {
        let detailVC = NotiDetailViewController(nibName: "NotiDetailViewController", bundle: nil)
        self.present(detailVC, animated: true, completion: nil)
    }
}

extension ViewController: DelegateDetailViewControllerDelegate{
    func passString(string: String) {
        self.dataLabel.text=string
    }
    
    
    
}
