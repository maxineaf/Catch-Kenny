//
//  ViewController.swift
//  CatchKenny
//
//  Created by Lisa on 5.06.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var melisa = 06
    
    @IBOutlet weak var timing: UILabel!
    @IBOutlet weak var myscore: UILabel!
    @IBOutlet weak var highscore: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    @IBOutlet weak var image5: UIImageView!
    @IBOutlet weak var image6: UIImageView!
    @IBOutlet weak var image7: UIImageView!
    @IBOutlet weak var image8: UIImageView!
    @IBOutlet weak var image9: UIImageView!
    
    var timervar = Timer()
    var timecounter = 0
    var tapcounterint = 0
    
    var kennytimer = Timer()
    var kennyArray = [UIImageView]()
    
    var intHighScore = 0
    
    var something = 22
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        print("ben bir malım")
        myscore.text = "Score: \(tapcounterint)"
        highscore.text = "Highscore: \(intHighScore)"
    
        //image interaction açıldı
        image1.isUserInteractionEnabled = true
        image2.isUserInteractionEnabled = true
        image3.isUserInteractionEnabled = true
        image4.isUserInteractionEnabled = true
        image5.isUserInteractionEnabled = true
        image6.isUserInteractionEnabled = true
        image7.isUserInteractionEnabled = true
        image8.isUserInteractionEnabled = true
        image9.isUserInteractionEnabled = true
        
        //gesture recognizerlar tanımlandı :)
        let gestureRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer3 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer4 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer5 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer6 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer7 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer8 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        let gestureRecognizer9 = UITapGestureRecognizer(target: self, action: #selector(tapcounter))
        
        //gesture recognizerlar atandı
        image1.addGestureRecognizer(gestureRecognizer1)
        image2.addGestureRecognizer(gestureRecognizer2)
        image3.addGestureRecognizer(gestureRecognizer3)
        image4.addGestureRecognizer(gestureRecognizer4)
        image5.addGestureRecognizer(gestureRecognizer5)
        image6.addGestureRecognizer(gestureRecognizer6)
        image7.addGestureRecognizer(gestureRecognizer7)
        image8.addGestureRecognizer(gestureRecognizer8)
        image9.addGestureRecognizer(gestureRecognizer9)
        
        
        
        //oyunda kaç sn kaldı timerı
        timecounter = 10
        timing.text = "\(timecounter)"
        timervar = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timeconsumer), userInfo: nil, repeats: true)
        
        //kennylerin görünme sıklığı timerı
        kennytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(kennytimingfunc), userInfo: nil, repeats: true)
        
        kennyArray = [image1, image2, image3, image4, image5, image6, image7, image8, image9]
        
        kennytimingfunc()
        
        let storedScore = UserDefaults.standard.object(forKey: "highest")
        if let newStorage = storedScore as? String {
            highscore.text = newStorage
        }
    }
    
    //kenny görülme sıklığı fonksiyonu
    @objc func kennytimingfunc(){
        for kenny in kennyArray {
            kenny.isHidden = true
        }
        let randomnum = Int(arc4random_uniform(UInt32(kennyArray.count - 1)))
        kennyArray[randomnum].isHidden = false
    }
    
    
    //oyunda kaç sn kaldı fonksiyonu
    @objc func timeconsumer(){
        timing.text = "\(timecounter)"
        timecounter -= 1

        if timecounter == 0 { //counter durdurucu
            timervar.invalidate()
            kennytimer.invalidate()
            for kenny in kennyArray {
                kenny.isHidden = true
            }
            //HIGHSCORE BURADA
            if tapcounterint > intHighScore {
                intHighScore = tapcounterint
                highscore.text = "Highscore: \(intHighScore)"
            }
            UserDefaults.standard.set(highscore.text!, forKey: "highest")
            
            //ALARMLAR BURADA!!!
            let gameOverAlert = UIAlertController(title: "Time's Up", message: "Wanna play again?", preferredStyle: UIAlertController.Style.alert)
            
            
            let replayButton = UIAlertAction(title: "Replay", style: UIAlertAction.Style.default) { (UIAlertAction) in
                self.tapcounterint = 0
                self.myscore.text = "Score: \(self.tapcounterint)"
                
                self.timecounter = 10
                self.timing.text = String(self.timecounter)
                
                self.timervar = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timeconsumer), userInfo: nil, repeats: true)
                self.kennytimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.kennytimingfunc), userInfo: nil, repeats: true)
            }
            
            
            let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            
            gameOverAlert.addAction(replayButton)
            gameOverAlert.addAction(cancelButton)
            self.present(gameOverAlert, animated: true, completion: nil)
            
            
        }
    }

    @objc func tapcounter() {
        tapcounterint += 1
        myscore.text = "Score: \(tapcounterint)"
    }
    
    
}

