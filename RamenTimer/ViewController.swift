//
//  ViewController.swift
//  RamenTimer
//
//  Created by Seonggwon Yoon on 2021/11/09.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var secondsLeft : Int = 180
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        timerButton.layer.cornerRadius = 10
//        self.secondsLeft = 10
//        self.updateSecondsLabel()
        self.updateTimeLeft()
    }
    func updateTimeLeft() {
            self.secondsLeft = 180 + segmentControl.selectedSegmentIndex * 60
            self.updateSecondsLabel()
        }

    func updateSecondsLabel() {
        
      var minutes = self.secondsLeft / 60
      var seconds = self.secondsLeft % 60
      
      if self.secondsLeft < 60 {
        self.timerLabel.textColor = UIColor(red: 0.94, green: 0.07, blue: 0.07, alpha: 1.00)
      } else {
        self.timerLabel.textColor = UIColor.black
      }
      
      
      UIView.transition(with: self.timerLabel, duration: 0.3, options: .transitionFlipFromBottom) {
        if self.secondsLeft > 0 {
          self.timerLabel.text = String(format: "%02d:%02d", minutes, seconds)
        } else {
          self.timerLabel.text = "시간 끝!"
        }
      } completion: { (animated) in
          
      }
    }
    
    func resetTimer(){
        timer?.invalidate()
        timer = nil
        timerButton.setTitle("타이머 시작하기", for: .normal)
    }
    
    @IBAction func segmentValueChanged(_ sender: Any) {
            self.resetTimer()
            self.updateTimeLeft()
        }
    
    @IBAction func timerButtononClicked(_ sender: Any) {
        if timer != nil{
            resetTimer()
            return
        }
        self.timerButton.setTitle("타이머 종료하기", for: .normal)
        //self.secondsLeft = 180
        self.updateSecondsLabel()
        
        //1초마다 타이머 반복 실행
            timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (t) in
                //남은 시간(초)에서 1초 빼기
                self.secondsLeft -= 1
                self.updateSecondsLabel()
                
                if self.secondsLeft==0{
                    self.resetTimer()
                }
                    
            })
    }
    

}

