//
//  GameOverScene.swift
//  Run Away
//
//  Created by paw on 15.02.2021.
//

import SpriteKit

class GameOverScene: SKScene {
    lazy var gameOverLabelNode = SKLabelNode(text: """
Game over 
Score: \(score)
""")
    
    var score = 0
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        gameOverLabelNode.position = view.center
        gameOverLabelNode.numberOfLines = 0
        addChild(gameOverLabelNode)
        
        
    }
    
}
