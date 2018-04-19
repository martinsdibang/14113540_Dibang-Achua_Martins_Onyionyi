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
protocol subviewDelegate {
    
    func changeSomething()
}


class GameViewController: UIViewController, subviewDelegate {

    @IBOutlet weak var replay: UIButton!
    @IBOutlet weak var ScoreKeeper: UILabel!
    
    var CarAnimator: UIDynamicAnimator!
    var dynamicItemBehaviour: UIDynamicItemBehavior!
    var gravityBehaviour: UIGravityBehavior!
    var collisionBehaviour: UICollisionBehavior!
    
    var Score = 0;
    var scoreArray: [UIImageView] = []
    var carGame: [UIImageView] = []
    let GameOver = UIImageView(image: nil)
    
    
    let CarArray = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15]
    
    @IBOutlet weak var RoadAI: UIImageView!
    @IBOutlet weak var carlook: DraggedImageView!
    
    @IBAction func restart(_ sender: Any) {
        viewDidLoad()
        
        ScoreKeeper.text = ""
        Score = 0;
        GameOver.isHidden = true
        replay.isHidden = true
        
        for i in carGame {
            i.removeFromSuperview()
        }
        viewDidLoad()
    }
    
    func changeSomething()
    {
        collisionBehaviour.removeAllBoundaries()
        collisionBehaviour.addBoundary(withIdentifier: "racecar" as NSCopying, for: UIBezierPath(rect: carlook.frame))
        
        for usercar in scoreArray {
            if(carlook.frame.intersects(usercar.frame)) {
            Score = Score - 2
            self.ScoreKeeper.text = String(self.Score)
            
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var imageArray: [UIImage]
        
        imageArray = [UIImage(named:"road1.png")!,UIImage(named:"road2.png")!,UIImage(named:
            "road3.png")!,UIImage(named: "road4.png")!,UIImage(named: "road5.png")!,UIImage(named:
                "road6.png")!,UIImage(named: "road7.png")!,UIImage(named: "road8.png")!,UIImage(named:
                    "road9.png")!,UIImage(named: "road10.png")!,UIImage(named: "road11.png")!,UIImage(named:
                        "road12.png")!,UIImage(named: "road13.png")!,UIImage(named: "road14.png")!,UIImage(named:
                            "road15.png")!,UIImage(named: "road16.png")!,UIImage(named: "road17.png")!,UIImage(named:
                                "road18.png")!,UIImage(named: "road19.png")!,UIImage(named: "road20.png")!]
        
         RoadAI.image = UIImage.animatedImage(with: imageArray, duration: 0.1)
        
        carlook.myDelegate = self
        
        self.view.addSubview(carlook)
        self.view.bringSubview(toFront: carlook)
        
        CarAnimator = UIDynamicAnimator(referenceView: self.view)
        dynamicItemBehaviour = UIDynamicItemBehavior(items:[])
        collisionBehaviour = UICollisionBehavior(items:[])
        
        for index in 0...14 {
            
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
            
            self.scoreArray.append(obstacleview)
            self.Score += 2
            self.ScoreKeeper.text = String(self.Score)
        }
    }

        CarAnimator.addBehavior(dynamicItemBehaviour)
        collisionBehaviour = UICollisionBehavior(items: [])
        collisionBehaviour.translatesReferenceBoundsIntoBoundary = false
        CarAnimator.addBehavior(collisionBehaviour)
        
        let quitGame = DispatchTime.now() + 20
        DispatchQueue.main.asyncAfter(deadline: quitGame) {
            
            self.GameOver.isHidden = false
            self.replay.isHidden = false
            self.GameOver.image = UIImage(named: "game_over.jpg")
            self.GameOver.frame = UIScreen.main.bounds
            self.view.addSubview(self.GameOver)
            self.view.bringSubview(toFront: self.GameOver)
            self.view.bringSubview(toFront: self.replay)
        }
       
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

}

