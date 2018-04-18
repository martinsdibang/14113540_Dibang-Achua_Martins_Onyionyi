//
//  GameViewController.swift
//  CarRace
//
//  Created by MARTINS DIBANG on 12/03/2018.
//  Copyright © 2018 MARTINS DIBANG. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
protocol subViewDelegate {
    
    func changeSomething()
}


class GameViewController: UIViewController, subViewDelegate {
    @IBOutlet weak var scorekeeper: UILabel!
    @IBOutlet weak var replay: UIButton!
    
    var pointNumber = 0
    var startTime = 20
    var startTimer = Timer()
    
    var CarAnimator: UIDynamicAnimator!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    
    
    let CarArray = [1,2,3,4,5,6,7,8,9,10]
    
    @objc func startGameTimer(){
        startTime = startTime - 1
        
        if startTime == 0 {
            startTimer.invalidate()
        }
        
    }
    @IBOutlet weak var RoadAI: UIImageView!
    @IBOutlet weak var carlook: DraggedImageView!
    
    func changeSomething()
    {
        collisionBehaviour.addBoundary(withIdentifier: "racecar" as NSCopying, for: UIBezierPath(rect: carlook.frame))
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (GameViewController.startGameTimer), userInfo: nil, repeats: true)
        startTime = 20
        
        
        replay.isHidden = true
        
        carlook.myDelegate = self
        
        self.view.addSubview(carlook)
        self.view.bringSubview(toFront: carlook)
        
        CarAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehaviour = UIDynamicItemBehavior(items:[])
        collisionBehaviour = UICollisionBehavior(items:[])
        
        for index in 0...9 {
            
            let delaytime = Double(self.CarArray[index])
            
            let when = DispatchTime.now() + delaytime
            
        DispatchQueue.main.asyncAfter(deadline: when) {
            
            let obstacle = arc4random_uniform(10)
            let obstacleview = UIImageView(image: nil)
            let screensize = UIScreen.main.bounds.width
            
            switch obstacle {
            case 1: obstacleview.image = UIImage(named: "car1.png")
            case 2: obstacleview.image = UIImage(named: "car2.png")
            case 3: obstacleview.image = UIImage(named: "car3.png")
            case 4: obstacleview.image = UIImage(named: "car4.png")
                
            default:
                obstacleview.image = UIImage(named: "car4.png")
            }
            
            obstacleview.frame = CGRect(x: Int(arc4random_uniform(UInt32(screensize))), y: 0, width: 40, height: 65)
            
            self.view.addSubview(obstacleview)
            self.view.bringSubview(toFront: obstacleview)
            
            self.dynamicItemBehaviour.addItem(obstacleview)
            self.dynamicItemBehaviour.addLinearVelocity(CGPoint(x: 0, y: 350), for: obstacleview)
            self.collisionBehaviour.addItem(obstacleview)
            self.scorekeeper.text =  String(self.pointNumber)
            self.pointNumber = self.pointNumber + 1
        }
    }

        
        CarAnimator.addBehavior(dynamicItemBehaviour)
        collisionBehaviour = UICollisionBehavior(items: [])
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = false
        CarAnimator.addBehavior(collisionBehaviour)
        
        let quitGame = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: quitGame) {
            
            let GameFinished = UIImageView(image: UIImage(named: "game_over.jpg"))
            GameFinished.frame = UIScreen.main.bounds
            self.view.addSubview(GameFinished)
            self.view.bringSubview(toFront: GameFinished)
            self.view.addSubview(self.replay)
            self.replay.isHidden = false
        }       
        
                var imageArray: [UIImage]
        
        imageArray = [UIImage(named:"road1.png")!,UIImage(named:"road2.png")!,UIImage(named:
            "road3.png")!,UIImage(named: "road4.png")!,UIImage(named: "road5.png")!,UIImage(named:
            "road6.png")!,UIImage(named: "road7.png")!,UIImage(named: "road8.png")!,UIImage(named:
            "road9.png")!,UIImage(named: "road10.png")!,UIImage(named: "road11.png")!,UIImage(named:
            "road12.png")!,UIImage(named: "road13.png")!,UIImage(named: "road14.png")!,UIImage(named:
            "road15.png")!,UIImage(named: "road16.png")!,UIImage(named: "road17.png")!,UIImage(named:
            "road18.png")!,UIImage(named: "road19.png")!,UIImage(named: "road20.png")!]
                
        RoadAI.image = UIImage.animatedImage(with: imageArray, duration: 0.1)
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}

