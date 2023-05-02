import SpriteKit
import SwiftUI

class GameScene: SKScene, SKPhysicsContactDelegate {
    var gameManager : GameManager?
    
    func createPixelNode(imageNamed: String) -> SKSpriteNode {
        let spriteNode = SKSpriteNode(imageNamed: imageNamed)
        let spriteTexture = SKTexture(imageNamed: imageNamed)
        spriteTexture.filteringMode = .nearest
        addChild(spriteNode)
        return spriteNode
    }
    
    func orderNodesByName(nodeA : SKNode, nodeB : SKNode) -> Array<SKNode> {
        var nodeSet : Array<SKNode> = [nodeA, nodeB]
        nodeSet = nodeSet.sorted { ($0.name?.lowercased())! < ($1.name?.lowercased())! }
        return nodeSet;
    }
}
