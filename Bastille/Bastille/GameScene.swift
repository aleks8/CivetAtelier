//
//  GameScene.swift
//  Bastille
//
//  Created by Kayhan Feroze Qaiser on 01/10/2014.
//  Copyright (c) 2014 Civet Atelier. All rights reserved.
//

import SpriteKit

enum WorldLayer: Int {
    case Tiles = 0, BelowCharacter, Character, AboveCharacter, Top
}
let kWorldLayerCount = 5
let kMapSizeX = 30
let kMapSizeY = 30

class GameScene: SKScene {
    var world = SKNode()
    var layers = [SKNode]()
    var selectedNode = SKNode()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        world.name = "world"
        for i in 0..<kWorldLayerCount {
            let layer = SKNode()
            layer.zPosition = CGFloat(i - kWorldLayerCount)
            world.addChild(layer)
            layers.append(layer)
        }
        
        loadAssets()
        
        addChild(world)
        
        addTiles()
        addTrees()
        addVillager()

    }

    func addNode(node: SKNode, atWorldLayer layer: WorldLayer) {
        let layerNode = layers[layer.toRaw()]
        
        layerNode.addChild(node)
    }
    
    func loadAssets() {
        var treeSprite = SKSpriteNode(imageNamed: "pine-half08")
        var treeSprites = [treeSprite]
        sSharedTree = Tree(sprites: treeSprites)

        var tileSprite = SKSpriteNode(imageNamed: "GrassQuick")
        var tileSprites = [tileSprite]
        sSharedTile = Tile(sprites: tileSprites)
        
        var villagerSprite = SKSpriteNode(imageNamed: "character")
        var villagerSprites = [villagerSprite]
        sSharedVillager = Villager(sprites: villagerSprites)
        
    }
    
    func addTiles () {
        let scaleFactor = 0.2
        let margin: Double = 2
        let tileWidth:Double = 110 * scaleFactor + margin
        let tileHeight:Double = 128 * scaleFactor + margin
        var tileLayer = WorldLayer.Tiles

        for x in 0...kMapSizeX {
            for y in 0...kMapSizeY {
                var tile:Tile = sSharedTile.copy() as Tile
                tile.xScale = 0.2
                tile.yScale = 0.2
                let xOffset = y % 2 == 0 ? 0 : tileWidth/2
                let location = CGPoint(x: Double(x)*tileWidth + xOffset, y: 0.75*Double(y)*tileHeight)
                tile.position = location
                addNode(tile, atWorldLayer: tileLayer)
            }
        }
    }
    
    func addTrees() {
        let scaleFactor = 0.2
        let margin: Double = 2
        let tileWidth:Double = 110 * scaleFactor + margin
        let tileHeight:Double = 128 * scaleFactor + margin
        var treeLayer = WorldLayer.Top
        
        for x in 0...kMapSizeX {
            for y in 0...kMapSizeY {
                if (arc4random_uniform(10)<2) {

                var tree:Tree = sSharedTree.copy() as Tree
                tree.xScale = 0.2
                tree.yScale = 0.2
                let xOffset = y % 2 == 0 ? 0 : tileWidth/2
                let location = CGPoint(x: Double(x)*tileWidth + xOffset, y: 0.75*Double(y)*tileHeight + tileHeight/2)
                tree.position = location
                addNode(tree, atWorldLayer: treeLayer)
                }
            }
        }
    }
    
    func addVillager() {
        let scaleFactor = 0.5
        let margin: Double = 2
        let tileWidth:Double = 110 * scaleFactor + margin
        let tileHeight:Double = 128 * scaleFactor + margin
        var tileLayer = WorldLayer.Top
        
                var tile:Villager = sSharedVillager.copy() as Villager
                tile.xScale = 0.5
                tile.yScale = 0.5
                let xOffset = 100 % 2 == 0 ? 0 : tileWidth/2
                let location = CGPoint(x: Double(100)*tileWidth + xOffset, y: 0.75*Double(100)*tileHeight)
                tile.position = location
                addNode(tile, atWorldLayer: tileLayer)

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}


var objectSelected:Bool = false

let kWorldZoom = 1

// declare shared resources here
var sSharedTree = Tree(sprites: [SKSpriteNode]())
var sSharedTile = Tile(sprites: [SKSpriteNode]())
var sSharedVillager = Villager(sprites: [SKSpriteNode]())






