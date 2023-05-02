import SwiftUI

enum Scenes: String, Identifiable, CaseIterable {
    case scene0, scene1;
    
    var id: String { self.rawValue }
}
