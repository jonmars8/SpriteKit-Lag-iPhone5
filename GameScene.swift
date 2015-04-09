import SpriteKit

class GameScene: SKScene {
    
    var viewController:GameViewController?
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        viewController?.presentPlayScene()
    }
}
