//
//  ViewController.swift
//  DispatchQueue
//
//  Created by ohseungyeon on 8/8/24.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var finishLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true){
            timer in
            self.timerLabel.text = Date().timeIntervalSince1970.description
        }
        
        
    }
    
    @IBAction func action1(_ sender: Any) {
        simpleClosure {
            DispatchQueue.main.async{
                self.finishLabel.text = "끝"
            }
            

        }
    }
    
    func simpleClosure(completion: @escaping ()->Void){
        //긴 작업이라는 것을 가정하기 위해서 스레드를 잠깐씩 멈춰보자
        DispatchQueue.global().async {
            
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            
            completion()
            
            
        }
        
    }
    
    @IBAction func action2(_ sender: Any) {
        
        let dispatchGroup = DispatchGroup()
        
        let queue1 = DispatchQueue(label:"q1")
        let queue2 = DispatchQueue(label:"q2")
        let queue3 = DispatchQueue(label:"q3")
        
        queue1.async(group: dispatchGroup, qos: .background){
            dispatchGroup.enter() //아직 작업중이다(수동작업)
            DispatchQueue.global().async{
                for index in 0..<10 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave() //작업 끝났다(수동작업)
            }
            
        }
        queue2.async(group: dispatchGroup, qos: .userInteractive){
            dispatchGroup.enter()
            DispatchQueue.global().async{
                for index in 10..<20 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        queue3.async(group: dispatchGroup){
            dispatchGroup.enter()
            DispatchQueue.global().async{
                for index in 20..<30 {
                    Thread.sleep(forTimeInterval: 0.2)
                    print(index)
                }
                dispatchGroup.leave()
            }
        }
        
        dispatchGroup.notify(queue: DispatchQueue.main){
            print("끝")
        }
        
        
    }
    
    @IBAction func action3(_ sender: Any) {
        
//        DispatchQueue.main.sync{
//            print("main sync")
//        }
        
        let queue1 = DispatchQueue(label:"q1")
        let queue2 = DispatchQueue(label:"q2")
        
        queue1.sync{
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
            
            // deadlock(교착상태) -> 상대 작업이 끝날때까지 서로 계속 기다리는 상태
            //얘가 sync로 물고있어서 얘가 종료가 안되니까 서로 계속 기다림
//            queue1.sync{
//                for index in 10..<20 {
//                    Thread.sleep(forTimeInterval: 0.2)
//                    print(index)
//                }
//            }
        }
        
        queue1.sync{
            for index in 0..<10 {
                Thread.sleep(forTimeInterval: 0.2)
                print(index)
            }
        }
        
        print("aaa")
        
        
        
    }
}

