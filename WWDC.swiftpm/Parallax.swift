import SpriteKit

class Parallax {
    var scene : SKScene
    var screenSize : CGSize
    
    init(scene: SKScene, screenSize: CGSize) {
        self.scene = scene
        self.screenSize = screenSize
    }
    
    func setup() {
        let background = SKShapeNode(rectOf: screenSize)
        background.position = CGPoint(x: screenSize.width/2, y: screenSize.height/2)
        background.fillColor = .white
        background.strokeColor = .clear
        scene.addChild(background)
    }
}
