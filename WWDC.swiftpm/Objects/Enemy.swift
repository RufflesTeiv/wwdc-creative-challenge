import SpriteKit

class Enemy {
//    var spriteNode = SKSpriteNode()
    var collisionsEnabled = true
    var shapeNode = SKShapeNode()
    var score = 5
    
    var initPoint : CGPoint
    
    init() {
        initPoint = CGPoint()
    }
    
    init(initPoint: CGPoint) {
        self.initPoint = initPoint
        
        let enemySize = CGSize(width: 8*4, height: 8*6)
        shapeNode = SKShapeNode(rectOf: enemySize)
        shapeNode.position = initPoint
        shapeNode.zPosition = 200
        shapeNode.fillColor = .blue
        shapeNode.strokeColor = .black
        shapeNode.physicsBody = SKPhysicsBody(rectangleOf: enemySize)
        shapeNode.physicsBody?.categoryBitMask = 0b0100
        shapeNode.physicsBody?.collisionBitMask = 0b0001
        shapeNode.physicsBody?.contactTestBitMask = 0b0010
        shapeNode.name = "enemy"
        
        // Moving
        let moveAction = SKAction.move(by: CGVector(dx: -90, dy: 0), duration: 1)
        let moveCycle = SKAction.repeatForever(moveAction)
        shapeNode.run(moveCycle)
    }
    
    func spawn(scene: SKScene) {
        scene.addChild(shapeNode)
    }
    
    
}
