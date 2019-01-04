//
//  ViewController.swift
//  BullsEye
//
//  Created by watermelondududu on 2018/12/27.
//  Copyright © 2018 watermelondududu. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var targetLabel : UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var scoreLabel : UILabel!
    @IBOutlet weak var roundLabel : UILabel!
    var currentValue : Int = 0
    var targetValue : Int = 0
    var score = 0
    var roundnum = 0
    
    var audioPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let thumbImageNormal = UIImage(named: "SliderThumb-Normal")!
        slider.setThumbImage(thumbImageNormal, for: .normal)
        let thumbImageHighlighted = UIImage(named: "SliderThumb-Highlighted")!
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14) //?
        let trackLeftImage = UIImage(named: "SliderTrackLeft")!
        let trackLeftResizable = trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)//设置滑动条左边图像？
        let trackRightImage = UIImage(named: "SliderTrackRight")!
        let trackRightResizable = trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal) //设置滑动条右边图像？
        
        playMusic()
        
        newGame()
    }
    
    @IBAction func showAlert(){
        let difference : Int = abs(targetValue - currentValue)
        let currentScore : Int = 100 - difference
        
        let title:String
        if(currentScore == 100){
            title = "哇！年度最佳猪手！"
            score += 200
        }
        else if (95 <= currentScore && currentScore < 100){
            title = "只差一点点了！"
            score += 50
        }
        else if (90 <= currentScore && currentScore < 95){
            title = "还不错哦！继续加油～"
            score += 10
        }
        else{
            title = "差太远啦！"
        }
        
        
        let message = "猪的战绩：\(currentValue)\n本回合猪手准确度\(currentScore)%"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "嗷呜～", style: .default, handler: {_ in self.startNewRound()})
        
        
        alert.addAction(action)
        present (alert, animated: true, completion: nil)
        
        //?怎么才能让玩家按了提示窗中的确定后再开始新一轮呢
        //startNewRound()
    }
    
    @IBAction func sliderMoved (_ slider: UISlider ) {
//        print("猪的战绩：\(slider.value)")
        currentValue = lroundf(slider.value) //lroundfd：对浮点数四舍五入取整
        
    }
    
    @IBAction func startOver(){
        newGame()
    }
    
    func newGame(){
        score = 0
        roundnum = 0
        startNewRound()
        
        //重新开始时添加转场效果
        let transition = CATransition()
        transition.type = CATransitionType.fade
        transition.duration = 1
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeOut)
        view.layer.add(transition, forKey: nil)//?
    }
    
    func startNewRound(){
        targetValue = Int.random(in: 1...100)
        currentValue = 50
        slider.value = Float(currentValue)
        roundnum += 1
        updateLabels()
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
        scoreLabel.text = String(score)
        roundLabel.text = String(roundnum)
    }
    
    func playMusic(){
        let musicPath = Bundle.main.path(forResource: "bgmusic", ofType: "mp3")
        let url = URL.init(fileURLWithPath: musicPath!)
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
        }catch _ {
            audioPlayer = nil
        }
        audioPlayer.numberOfLoops = -1
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }

}

