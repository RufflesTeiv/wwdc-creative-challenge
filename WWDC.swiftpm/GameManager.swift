import SwiftUI
import SpriteKit

class GameManager: ObservableObject {
    @Published var selectedScene = Scenes.scene0
    
    func goToScene(_ scene: Scenes) {
        selectedScene = scene
    }
    
    func getScreenSize () -> CGSize {
        return CGSize(width: 258, height: 192)
    }
}
