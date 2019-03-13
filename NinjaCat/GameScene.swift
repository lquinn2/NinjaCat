//
//  GameScene.swift
//  NinjaCat
//
//  Created by Student on 2019-03-13.
//  Copyright © 2019 Liam Quinn. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var ninjaCat = SKSpriteNode()
    private var ninjaCatWalkingFrames: [SKTexture] = []
    
    override func didMove(to view: SKView) {
        buildNinjaCat() // finds the sprite for the node
        animateNinjaCat() // cycles through the sprites to make an animation
    }
    
    func buildNinjaCat() {
        let ninjaCatAnimatedAtlas = SKTextureAtlas(named: "NinjaCatImages")
        var walkFrames: [SKTexture] = []
        
        let numImages = ninjaCatAnimatedAtlas.textureNames.count
        for i in 1...numImages {
            let ninjaCatTextureName = "NinjaCat_walk_0\(i)"
            walkFrames.append(ninjaCatAnimatedAtlas.textureNamed(ninjaCatTextureName))
        }
        
        ninjaCatWalkingFrames = walkFrames
        let firstFrameTexture = ninjaCatWalkingFrames[0]
        ninjaCat = SKSpriteNode(texture: firstFrameTexture)
        ninjaCat.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(ninjaCat)
    }
    
    func animateNinjaCat() {
        ninjaCat.run(SKAction.repeatForever(
            SKAction.animate(with: ninjaCatWalkingFrames, timePerFrame: 0.1, resize: false, restore: true)),
            withKey: "walkingInPlaceNinjaCat")
    }
    
    // Pasted
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        moveNinjaCat(location: location)
    }
    
    func moveNinjaCat(location: CGPoint) {
        var multiplierForDirection: CGFloat
        let ninjaCatSpeed = frame.size.width / 3.0
        let moveDifference = CGPoint(x: location.x - ninjaCat.position.x, y: location.y - ninjaCat.position.y)
        let distanceToMove = sqrt(moveDifference.x * moveDifference.x + moveDifference.y * moveDifference.y)
        let moveDuration = distanceToMove / ninjaCatSpeed
        
        if moveDifference.x < 0 {
            multiplierForDirection = -1.0
        } else {
            multiplierForDirection = 1.0
        }
        
        ninjaCat.xScale = abs(ninjaCat.xScale) * multiplierForDirection
        
        if ninjaCat.action(forKey: "walkingInPlaceNinjaCat") == nil {
            animateNinjaCat()
        }
        
        let moveAction = SKAction.move(to: location, duration:(TimeInterval(moveDuration)))
        
        let doneAction = SKAction.run({ [weak self] in
            self?.ninjaCatMoveEnded()
        })
        
        let moveActionWithDone = SKAction.sequence([moveAction, doneAction])
        ninjaCat.run(moveActionWithDone, withKey:"ninjaCatMoving")
    }
    
    func ninjaCatMoveEnded() {
        ninjaCat.removeAllActions()
    }
}
