import SpriteKit

class Player {
//    var spriteNode = SKSpriteNode()
    var playerCanAttack  = true
    var shapeNode = SKShapeNode()
    
    var initPoint : CGPoint
    
    init() {
        initPoint = CGPoint()
    }
    
    init(initPoint: CGPoint) {
        self.initPoint = initPoint
        
        let playerSize = CGSize(width: 8*4, height: 8*6)
        shapeNode = SKShapeNode(rectOf: playerSize)
        shapeNode.position = initPoint
        shapeNode.zPosition = 300
        shapeNode.fillColor = .green
        shapeNode.strokeColor = .black
        shapeNode.physicsBody = SKPhysicsBody(rectangleOf: playerSize)
        shapeNode.physicsBody?.categoryBitMask = 0b0010
        shapeNode.physicsBody?.collisionBitMask = 0b0001
        shapeNode.physicsBody?.contactTestBitMask = 0b0100
        shapeNode.name = "player"
    }
    
    //-------------------------------------------------------------------------------
    
    func attack(scene: SKScene) {
        if (playerCanAttack) {
            let attackSize = CGSize(width: 8*4, height: 8*6)
            let attack = SKShapeNode(rectOf: attackSize)
            attack.position = CGPoint(x: shapeNode.position.x+8*4, y: shapeNode.position.y)
            attack.zPosition = 200
            attack.strokeColor = .black
            scene.addChild(attack)
            attack.physicsBody = SKPhysicsBody(rectangleOf: attackSize)
            attack.physicsBody?.isDynamic = false
            attack.physicsBody?.categoryBitMask = 0b1000
            attack.physicsBody?.collisionBitMask = 0b0000
            attack.physicsBody?.contactTestBitMask = 0b0100
            attack.name = "attack"
            
            let waitAction = SKAction.wait(forDuration: 0.15)
            let destroyAction = SKAction.removeFromParent()
            let attackSequence = SKAction.sequence([waitAction, destroyAction])
            attack.run(attackSequence)
            
            let noAttackAction = SKAction.run {
                self.playerCanAttack = false
            }
            let waitAttackAction = SKAction.wait(forDuration: 0.25)
            let attackRestoreAction = SKAction.run {
                self.playerCanAttack = true
            }
            let attackCooldownSequence = SKAction.sequence([noAttackAction, waitAttackAction, attackRestoreAction])
            shapeNode.run(attackCooldownSequence)
        }
    }
    
    func spawn(scene: SKScene) {
        scene.addChild(shapeNode)
    }
    
    
}
