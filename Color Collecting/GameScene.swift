//
//  GameScene.swift
//  Color Collecting
//
//  Created by Greg Willis on 2/21/16.
//  Copyright (c) 2016 Willis Programming. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player = SKSpriteNode?()
    var darkBlock = SKSpriteNode?()
    var lightBlock = SKSpriteNode?()
    var mainLabel = SKLabelNode?()
    var scoreLabel = SKLabelNode?()
    var lightBlockSpeed = 4.0 // Speed of block across screen
    var darkBlockSpeed = 3.0
    var blockSpawnTime = 0.3 // Speed of how fast blocks spawn
    var isAlive = true
    var score = 0
    var offWhiteColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.0)
    var offBlackColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
    var grayBlueColor = UIColor(red: (60/255), green: (100/255), blue: (160/255), alpha: 1.0)
    var blockSize = CGSize(width: 20, height: 20)
    var dragTouchLocation : CGPoint?
    var isLightColor = true
    var colorChangeLogicVar = true
    var colorChangeTime: Double = 10.0
    var colorChangeTimeCounterNumber = 10
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        physicsWorld.contactDelegate = self
        backgroundColor = grayBlueColor
        spawnPlayer()
        spawnMainLabel()
        spawnScoreLabel()
        darkBlockSpawnTimer()
        lightBlockSpawnTimer()
        hideLabel()
        changeColor()
        countDownTimer()
        resetVariablesOnStart()
    }
    
    func resetVariablesOnStart() {
        isAlive = true
        score = 0
        colorChangeTime = 10
        colorChangeTimeCounterNumber = 10
        isLightColor = true
        colorChangeLogicVar = true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       /* Called when a touch begins */
        
        for touch in touches {
            dragTouchLocation = touch.locationInNode(self)
            
           
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        for touch in touches {
            dragTouchLocation = touch.locationInNode(self)
            if isAlive == true {
                player?.position.x = (dragTouchLocation?.x)!
        
            }
            if isAlive == false {
                player?.position.x = -200
            }
        }
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        if isAlive == false {
            player?.position.x = -200
        }
    }

// Spawns the player
    func spawnPlayer() {
        player = SKSpriteNode(color: offWhiteColor, size: CGSize(width: 50, height: 50))
        player?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame) * 0.2)
        player?.physicsBody = SKPhysicsBody(rectangleOfSize: player!.size)
        player?.physicsBody?.affectedByGravity = false
        player?.physicsBody?.allowsRotation = false
        player?.physicsBody?.categoryBitMask = physicsCategory.player
        player?.physicsBody?.contactTestBitMask = physicsCategory.darkBlock
        player?.physicsBody?.dynamic = false
        player?.name = "player"
        
        addChild(player!)
    }
   
// Spawns a dark block
    func spawnDarkBlock() {
        darkBlock = SKSpriteNode(color: offBlackColor, size: blockSize)
        darkBlock?.position.x = CGFloat(arc4random_uniform(700) + 250)
        darkBlock?.position.y = CGFloat(CGRectGetHeight(self.frame))
        
        darkBlock?.physicsBody = SKPhysicsBody(rectangleOfSize: darkBlock!.size)
        darkBlock?.physicsBody?.affectedByGravity = false
        darkBlock?.physicsBody?.allowsRotation = false
        darkBlock?.physicsBody?.categoryBitMask = physicsCategory.darkBlock
        darkBlock?.physicsBody?.contactTestBitMask = physicsCategory.player
        darkBlock?.physicsBody?.dynamic = true
        darkBlock?.name = "darkBlock"
        
        let moveDown = SKAction.moveToY(-100, duration: darkBlockSpeed)
        let destroy = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, destroy])
        darkBlock?.runAction(sequence)
        addChild(darkBlock!)
    }
    
// Spawns a light block
    func spawnLightBlock() {
        lightBlock = SKSpriteNode(color: offWhiteColor, size: blockSize)
        lightBlock?.position.x = CGFloat(arc4random_uniform(700) + 250)
        lightBlock?.position.y = CGFloat(CGRectGetHeight(self.frame) + 100)
        
        lightBlock?.physicsBody = SKPhysicsBody(rectangleOfSize: lightBlock!.size)
        lightBlock?.physicsBody?.affectedByGravity = false
        lightBlock?.physicsBody?.allowsRotation = false
        lightBlock?.physicsBody?.categoryBitMask = physicsCategory.lightBlock
        lightBlock?.physicsBody?.contactTestBitMask = physicsCategory.player
        lightBlock?.physicsBody?.dynamic = true
        lightBlock?.name = "lightBlock"


        let moveDown = SKAction.moveToY(-100, duration: lightBlockSpeed)
        let destroy = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveDown, destroy])
        lightBlock?.runAction(sequence)
        addChild(lightBlock!)
    }
    
// Spawns the main label
    func spawnMainLabel() {
        mainLabel = SKLabelNode(fontNamed: "Futura")
        mainLabel?.fontSize = 80
        mainLabel?.fontColor = offWhiteColor
        mainLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetHeight(self.frame) * 0.7)
        mainLabel?.text = "Start"
        addChild(mainLabel!)
    }

// Spawns the score label
    func spawnScoreLabel() {
        scoreLabel = SKLabelNode(fontNamed: "Futura")
        scoreLabel?.fontSize = 50
        scoreLabel?.fontColor = offWhiteColor
        scoreLabel?.position = CGPoint(x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame) * 0.1)
        scoreLabel?.text = "Score: \(score)"
        addChild(scoreLabel!)
    }
    
    func darkBlockSpawnTimer() {
        let blockTimer = SKAction.waitForDuration(blockSpawnTime)
        let spawn = SKAction.runBlock {
            self.spawnDarkBlock()
        }
        let sequence = SKAction.sequence([blockTimer, spawn])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
    func lightBlockSpawnTimer() {
        let blockTimer = SKAction.waitForDuration(blockSpawnTime)
        let spawn = SKAction.runBlock {
            self.spawnLightBlock()
        }
        let sequence = SKAction.sequence([blockTimer, spawn])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
// Hides the main label
    func hideLabel() {
        let wait = SKAction.waitForDuration(1.0)
        let hide = SKAction.runBlock {
        }
        
        let sequence = SKAction.sequence([wait, hide])
        runAction(SKAction.repeatAction(sequence, count: 1))
    }
    
// Changes the block color from white to black
    func changeColor() {
        let wait = SKAction.waitForDuration(colorChangeTime)
        let changeColor = SKAction.runBlock {
            if self.isLightColor == true  && self.colorChangeLogicVar == true{
                self.isLightColor = false
                self.colorChangeLogicVar = false
                self.changeToDarkColor()
            }
            if self.isLightColor == false && self.colorChangeLogicVar == true {
                self.isLightColor = true
                self.colorChangeLogicVar = true
                self.changeToLightColor()
            }
            self.colorChangeLogicVar = true
        }
        let sequence = SKAction.sequence([wait, changeColor])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
    func changeToDarkColor() {
        player?.color = offBlackColor
        scoreLabel?.fontColor = offBlackColor
        mainLabel?.fontColor = offBlackColor
    }
    
    func changeToLightColor() {
        player?.color = offWhiteColor
        scoreLabel?.fontColor = offWhiteColor
        mainLabel?.fontColor = offWhiteColor
    }
    
    func countDownTimer() {
        let wait = SKAction.waitForDuration(1.0)
        let countDown = SKAction.runBlock {
            self.colorChangeTimeCounterNumber--
            if self.colorChangeTimeCounterNumber <= 0 {
                self.colorChangeTimeCounterNumber = 10
            }
            self.mainLabel?.text = "\(self.colorChangeTimeCounterNumber)"
        }
        let sequence = SKAction.sequence([wait, countDown])
        runAction(SKAction.repeatActionForever(sequence))
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody : SKPhysicsBody = contact.bodyA
        let secondBody : SKPhysicsBody = contact.bodyB
        
        if ((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.darkBlock) || (firstBody.categoryBitMask == physicsCategory.darkBlock) && (secondBody.categoryBitMask == physicsCategory.player)) {
            
            darkBlockCollision(firstBody.node as! SKSpriteNode, darkBlockTemp: secondBody.node as! SKSpriteNode)
        }
        if ((firstBody.categoryBitMask == physicsCategory.player) && (secondBody.categoryBitMask == physicsCategory.lightBlock) || (firstBody.categoryBitMask == physicsCategory.lightBlock) && (secondBody.categoryBitMask == physicsCategory.player)) {
            
            lightBlockCollision(firstBody.node as! SKSpriteNode, lightBlockTemp: secondBody.node as! SKSpriteNode)
        }
    }
    
    func darkBlockCollision(playerTemp: SKSpriteNode, darkBlockTemp: SKSpriteNode) {
        if isLightColor == false {
            if playerTemp.name == "darkBlock" {
                playerTemp.removeFromParent()
            }
            if darkBlockTemp.name == "darkBlock" {
                darkBlockTemp.removeFromParent()
            }
            score++
        }
        if isLightColor == true {
            isAlive = false
            waitThenMoveToTitleScene()
        }
        
        updateScore()
        

    }
    
    func lightBlockCollision(playerTemp: SKSpriteNode, lightBlockTemp: SKSpriteNode) {
        if isLightColor == true {
            if playerTemp.name == "lightBlock" {
                playerTemp.removeFromParent()
            }
            if lightBlockTemp.name == "lightBlock" {
                lightBlockTemp.removeFromParent()
            }
            score++
        }
        if isLightColor == false {
            isAlive = false
            waitThenMoveToTitleScene()
        }
        
        updateScore()

    }
    
    func updateScore() {
        scoreLabel?.text = "Score: \(score)"
    }
    
    func waitThenMoveToTitleScene() {
        let wait = SKAction.waitForDuration(1.0)
        let transition = SKAction.runBlock {
            self.view?.presentScene(TitleScene(), transition: SKTransition.crossFadeWithDuration(1.0))
        }
        let sequence = SKAction.sequence([wait, transition])
        self.runAction(sequence)
    }
    
    struct physicsCategory {
        static let player : UInt32 = 1
        static let darkBlock : UInt32 = 2
        static let lightBlock : UInt32 = 3
    }
}
