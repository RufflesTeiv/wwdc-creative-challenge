import SpriteKit
import SwiftUI

class GameScene0: GameScene{
    var enemyArray : Array<Enemy> = []
    var parallax : Parallax?
//    var player = SKShapeNode()
    var player = Player()
    var screensize = CGSize()
    
    var currentTime = 0.0
    var playerCanAttack = true
    var score = 100
    var touchBeginTime = 0.0
    var touchBeginPosition = CGPoint(x: 0, y: 0)
    
    override func didMove(to view: SKView) {
        
        screensize = (gameManager?.getScreenSize())!
        
        
        
//        let testSprite = createPixelNode(imageNamed: "sonique")
//        testSprite.position = CGPoint(x: screensize!.width/2, y: screensize!.height/2)
        
        // Configuracao de fisica
        physicsWorld.contactDelegate = self;
        
        parallax = Parallax(scene: self, screenSize: screensize)
        parallax!.setup()
        
        let groundHeight = screensize.height/4
        let groundSize = CGSize(width: screensize.width*2, height: groundHeight)
        let ground = SKShapeNode(rectOf: groundSize)
        ground.position = CGPoint(x: screensize.width/2, y: groundHeight/2)
        ground.zPosition = 100
        ground.fillColor = .gray
        ground.strokeColor = .clear
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: groundSize.width, height: groundSize.height*(3/5)))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = 0b0001
        addChild(ground)
        
        player = Player(initPoint: CGPoint(x: screensize.width*(1/5), y: screensize.height/2))
        player.spawn(scene: self)
        
        setupEnemySpawns()
    }
    override func update(_ currentTime: TimeInterval) {
        self.currentTime = currentTime
        for enemy in enemyArray {
            let enemyShapeNode = enemy.shapeNode
            if (!intersects(enemyShapeNode) && (enemyShapeNode.position.x < 0 || enemyShapeNode.position.y < 0)) {
                enemyArray.remove(at: enemyArray.firstIndex(where: {$0 === enemy})!)
                enemyShapeNode.removeFromParent()
            }
        }
    }
    
    // Physics functions
     func didBegin(_ contact: SKPhysicsContact) {
         let orderedNodes : Array<SKNode> = orderNodesByName(nodeA: contact.bodyA.node!, nodeB: contact.bodyB.node!)
         if (orderedNodes[0].name! == "attack" && orderedNodes[1].name! == "enemy") {
             enemyHit(enemyNode: orderedNodes[1])
         }
         else if (orderedNodes[0].name! == "enemy" && orderedNodes[1].name! == "player") {
             playerHurt(enemyNode: orderedNodes[0])
         }
    }
    
    // Input functions
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchBeginTime = currentTime
        for touch in touches {
            touchBeginPosition = touch.location(in: self)
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        print(currentTime-touchBeginTime)
        if (currentTime-touchBeginTime < 0.12) {
            player.attack(scene: self)
        }
    }
    
    //----------------------------------------------------------------------------------------
    
    func enemyHit(enemyNode : SKNode) {
        let enemy = enemyArray.first(where: {$0.shapeNode as SKNode ===  enemyNode})!
        if (enemy.collisionsEnabled) {
        //        print("Player has hit enemy!")
                enemyNode.removeAllActions()
        //        print(enemyNode.physicsBody?.mass, enemyNode.physicsBody?.isDynamic)
                score += enemy.score
                enemy.collisionsEnabled = false
                print(score)
                
                let kickStrength = 400.0
                enemyNode.physicsBody?.velocity = CGVector(dx: kickStrength, dy: kickStrength*1.5)
                enemyNode.physicsBody?.applyAngularImpulse(-0.0045)
        }
    }
    
    func playerHurt(enemyNode : SKNode) {
        let enemy = enemyArray.first(where: {$0.shapeNode as SKNode === enemyNode})!
        if (enemy.collisionsEnabled) {
            score -= 5
            if score < 0 {
                score = 0
            }
            print(score)
            
            enemy.collisionsEnabled = false
        }
    }
    
    func setupEnemySpawns() {
        let spawnAction = SKAction.run({
            let enemy = Enemy(initPoint: CGPoint(x: self.screensize.width*(1+1/5), y: self.screensize.height/2))
            enemy.spawn(scene: self)
            self.enemyArray.append(enemy)
        })
        let waitAction = SKAction.wait(forDuration: 1.8)
        let sequence = SKAction.sequence([waitAction, spawnAction])
        let cycle = SKAction.repeatForever(sequence)
        self.run(cycle)
    }
}
