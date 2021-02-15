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
        gameOverLabelNode.name = "go"
        addChild(gameOverLabelNode)
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        guard let location = touch?.location(in: self) else { return }
        let nodes = self.nodes(at: location)
        if nodes.isEmpty { return }
        if nodes[0].name == "go" {
            let transition = SKTransition.push(with: .down, duration: 0.5)
            let gameScene = GameScene(size: self.size)
            self.view?.presentScene(gameScene, transition: transition)
        }
    }
    
}
