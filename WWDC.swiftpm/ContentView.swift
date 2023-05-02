import SwiftUI
import SpriteKit

struct ContentView: View {
    @StateObject var gameManager = GameManager()
    
    var scene: SKScene {
//        let screenSize : CGSize = UIScreen.main.bounds.size;
        
        let s = getGameScene(id: 0, size: gameManager.getScreenSize())
//        s.scaleMode = .aspectFit
        s.scaleMode = .fill
        return s
    }
    
    var body: some View {
        SpriteView(scene: scene)
            .ignoresSafeArea()
    }
    
    func getGameScene(id : Int, size : CGSize) -> SKScene {
        let gameScene : GameScene
        switch id {
            default: gameScene = GameScene0(size: size)
        }
        gameScene.gameManager = self.gameManager
        return gameScene
    }
}
