//
//  GameViewController.swift
//  NinjaCat
//
//  Created by Student on 2019-03-13.
//  Copyright © 2019 Liam Quinn. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = view as? SKView {
            let scene = GameScene(size: view.bounds.size)
            scene.scaleMode = .resizeFill
            
            view.ignoresSiblingOrder = true
            view.showsFPS = true
            view.showsNodeCount = true
            view.presentScene(scene)
        }
    }
}
