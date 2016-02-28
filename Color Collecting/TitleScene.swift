//
//  TitleScene.swift
//  Color Collecting
//
//  Created by Greg Willis on 2/21/16.
//  Copyright © 2016 Willis Programming. All rights reserved.
//

import Foundation
import SpriteKit

class TitleScene: SKScene {
    var playButton: UIButton!
    var gameTitle: UILabel!
    var grayBlueColor = UIColor(red: (60/255), green: (100/255), blue: (160/255), alpha: 1.0)
    var offWhiteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    var offBlackColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    
    override func didMoveToView(view: SKView) {
        self.backgroundColor = grayBlueColor
        setUpText()
    }
    
    func setUpText() {
        playButton = UIButton(frame: CGRect(x: 100, y: 100, width: 1100, height: 150))
        playButton.center = CGPoint(x: view!.frame.width / 2, y: view!.frame.height * 0.8)
        playButton.titleLabel?.font = UIFont(name: "Futura", size: 80)
        playButton.setTitle("Play", forState: UIControlState.Normal)
        playButton.setTitleColor(offBlackColor, forState: UIControlState.Normal)
        playButton.backgroundColor = offWhiteColor
        playButton.addTarget(self, action: Selector("playTheGame"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view?.addSubview(playButton)
        
        gameTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view!.frame.width, height: view!.frame.height * 0.2))
        gameTitle?.textColor = offWhiteColor
        gameTitle?.font = UIFont(name: "Futura", size: view!.frame.width * 0.1)
        gameTitle?.textAlignment = .Center
        gameTitle?.text = "COLOR CATCH HD"
        gameTitle?.backgroundColor = offBlackColor
        view?.addSubview(gameTitle!)
    }
    
    func playTheGame() {
        playButton.removeFromSuperview()
        gameTitle.removeFromSuperview()
        
        if let scene = GameScene(fileNamed: "GameScene") {
            let skView = self.view! as SKView
            skView.ignoresSiblingOrder = true
            scene.scaleMode = .ResizeFill
            skView.presentScene(scene)
        }
    }
}

