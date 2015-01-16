//
//  iOSTouchEvents.swift
//  Bastille
//
//  Created by Kayhan Feroze Qaiser on 17/10/2014.
//  Copyright (c) 2014 Civet Atelier. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        /* Called when a touch begins */
        
        for touch: AnyObject in touches {
            var location = touch.locationInNode(layers[0])
            var nodes = nodesAtPoint(location)
            
            if objectSelected {

            }
            else {
                for node in nodes {
                    if node is Villager {
                        selectedNode = node as SKNode
                        
                    }
                    else if node is Tree {
                        selectedNode = node as SKNode
                        characterTouched(node as Tree)
                        println(node)
                    }   
                    else if node is Tile {
                        tileTouched(node as Tile)
                        println(node)

                    }
                }
            }

        }
    }

    func tileTouched(tile: Tile) {
        let action = SKAction.moveTo(tile.position, duration: 0.5 )

        selectedNode.runAction(action)

    }

    func characterTouched(character:Tree) {
        if character.selected {
            character.selected = false
            character.xScale /= 2
            character.yScale /= 2
        }
        else {
            character.selected = true
            character.xScale *= 2
            character.yScale *= 2
        }
    }

    func panForTranslation(translation:CGPoint) {
        let position = world.position
        world.position = CGPointMake(position.x+translation.x, position.y+translation.y)
    }
    
    override func touchesMoved(touches: NSSet!, withEvent event: UIEvent!) {
        let touch = touches.anyObject() as UITouch
        let touchPoint = touch.locationInNode(world)
        let previousTouchPoint = touch.previousLocationInNode(world)
        var translation = CGPointMake(touchPoint.x - previousTouchPoint.x, touchPoint.y - previousTouchPoint.y)
        panForTranslation(translation)
    }


}