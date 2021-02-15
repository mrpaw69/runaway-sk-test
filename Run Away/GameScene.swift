//
//  GameScene.swift
//  Run Away
//
//  Created by paw on 15.02.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var enemy: Optional = SKShapeNode()
    var player = SKShapeNode()
    var enemyTimer: Timer!
    var scoreTimer: Timer!
    
    
    var scoreLabel = SKLabelNode(text: "Score: 0")
    
    var score: Int = 0{
        didSet{
            DispatchQueue.main.async { [unowned self] in
                scoreLabel.text = "Score: \(score)"
            }
        }
    }
    
    
    
    var radius: CGFloat = 5
    
    
    
    func addEnemy(on location: CGPoint)  {
        enemy!.removeFromParent()
        enemy = SKShapeNode(circleOfRadius: radius)
        enemy!.physicsBody = SKPhysicsBody(circleOfRadius: radius)
        enemy!.physicsBody?.affectedByGravity = false
        enemy!.fillColor = .red
        enemy!.position = location
        enemy!.physicsBody?.categoryBitMask = CategoryMask.collisionMask.rawValue
        enemy!.physicsBody?.contactTestBitMask = CategoryMask.categoryMask.rawValue
        
        addChild(enemy!)
    }
    
    
    func restart() {
        score = 0
        player = SKShapeNode(circleOfRadius: 20)
        player.fillColor = .green
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = CategoryMask.categoryMask.rawValue
        player.physicsBody?.contactTestBitMask = CategoryMask.collisionMask.rawValue
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        addChild(player)
        addEnemy(on: CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height)))
        
    }
    
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        physicsWorld.contactDelegate = self
        
        player = SKShapeNode(circleOfRadius: 20)
        player.fillColor = .green
        player.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        player.physicsBody?.affectedByGravity = false
        player.physicsBody?.categoryBitMask = CategoryMask.categoryMask.rawValue
        player.physicsBody?.contactTestBitMask = CategoryMask.collisionMask.rawValue
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        scoreLabel.position = CGPoint(x: 20 + scoreLabel.frame.size.width/2, y: size.height - scoreLabel.frame.size.height - 20)
        addChild(scoreLabel)
        addChild(player)
        addEnemy(on: CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height)))
        
        
        
       scoreTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [unowned self] (timer) in
            if enemy != nil{
                score += 1
            }else{
                timer.invalidate()
            }
        }
        
       enemyTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) {[unowned self] (timer) in
            if let enemy = enemy{
            let pos = enemy.position
            radius += 1
            addEnemy(on: pos)
                score += 1
            }else{
                timer.invalidate()
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        if let loc = touches.first?.location(in: view){
            let touchLocation = CGPoint(x: loc.x, y: size.height-loc.y)
            player.move(to: touchLocation, speed: 120)
        }else{
            print("Cannot get touch")
        }
        
        
    }
    
    
    
    override func update(_ currentTime: TimeInterval) {
        if let enemy = enemy{
        let targetLocation = player.position
            enemy.move(to: targetLocation, speed: 60)
        }
    }
}

extension GameScene: SKPhysicsContactDelegate{
    func didBegin(_ contact: SKPhysicsContact) {
        enemy!.removeFromParent()
        enemy = nil
        player.removeFromParent()
        let explosion = SKEmitterNode(fileNamed: "explosion.sks")
        explosion?.position = contact.contactPoint
        addChild(explosion!)
        enemyTimer.invalidate()
        scoreTimer.invalidate()
//        let view = self.view
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(gameOver), userInfo: nil, repeats: false)
        
    }
}

@objc
extension GameScene{
    func gameOver() {
        let gameOverScene = GameOverScene(size: size)
        gameOverScene.score = score
        let transition = SKTransition.push(with: .up, duration: 0.5)
        view?.presentScene(gameOverScene, transition: transition)
    }
}

extension SKNode{
    func move(to destination: CGPoint, speed: CGFloat) {
        let nodeX = position.x
        let nodeY = position.y
        let x = nodeX - destination.x
        let y = nodeY - destination.y
        
        let doubleX = x*x
        let doubleY = y*y
        
        let distance = sqrt(doubleX + doubleY)
        let duration = TimeInterval(distance / speed)
        
        let moveAction = SKAction.move(to: destination, duration: duration)
        
        run(moveAction)
    }
}
