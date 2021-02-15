//
//  GameScene.swift
//  Run Away
//
//  Created by paw on 15.02.2021.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var enemy = SKShapeNode()
    var player = SKShapeNode()
    
    

    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        player = SKShapeNode(circleOfRadius: 50)
        player.fillColor = .green
        player.position = CGPoint(x: size.width/2, y: size.height/2)
        
        enemy = SKShapeNode(circleOfRadius: 50)
        enemy.fillColor = .red
        enemy.position = CGPoint(x: CGFloat.random(in: 0...size.width), y: CGFloat.random(in: 0...size.height))
        
        addChild(player)
        addChild(enemy)
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
