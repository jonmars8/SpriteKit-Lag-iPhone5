import SpriteKit

let PlayerCategory: UInt32 = 0x1 << 0
let ObstacleCategory: UInt32 = 0x1 << 1

class PlayScene: SKScene, SKPhysicsContactDelegate {
    let world = SKNode()
    var player : SKShapeNode!
    var firsttap = true
    var viewController : GameViewController?
    
    override func didMoveToView(view: SKView) {
        
        //physicsWorld.gravity = CGVectorMake(0.0, -9.9)
        physicsWorld.contactDelegate = self
        
        self.createPlayer()
        
        let obstacle = SKSpriteNode(color: SKColor.whiteColor(), size: CGSizeMake(100.0, 38.0))
        obstacle.position = CGPointMake(frame.size.width / 2.0, CGRectGetMidY(frame) * 0.75 + 400.0)
        let body = SKPhysicsBody(rectangleOfSize: obstacle.size)
 
        body.linearDamping = 0.0
        body.angularDamping = 0.0
        body.dynamic = false
        obstacle.physicsBody = body
        
        self.addChild(world)
        self.world.addChild(obstacle)
        self.world.addChild(player)
    }
    
    func createPlayer() {
        self.player = SKShapeNode(circleOfRadius: 13.0)
        player.fillColor = SKColor.greenColor()
        player.strokeColor = SKColor.blackColor()
        player.lineWidth = 1.0
        let body = SKPhysicsBody(circleOfRadius:13.0)
        body.dynamic = false
        body.linearDamping = 0.0
        body.angularDamping = 0.0
        body.allowsRotation = false
        body.affectedByGravity = true
        body.categoryBitMask = PlayerCategory
        body.contactTestBitMask = ObstacleCategory
        body.collisionBitMask = ObstacleCategory
        body.mass = 1
        body.restitution = 0
        body.friction = 0
        player.physicsBody = body
        player.position = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame) * 0.75)
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        for touch: AnyObject in touches {
            if firsttap {
                player.physicsBody?.dynamic = true
                firsttap = false
            }
            let touchLoc = touch.locationInNode(self)
            var right = true
            if touchLoc.x > CGRectGetMidX(frame) {
                right = false
            }
            player.physicsBody?.angularVelocity = 0.0
            player.physicsBody?.velocity = right ?
                CGVectorMake(CGFloat(-65), CGFloat(650)) :
                CGVectorMake(CGFloat(65), CGFloat(650))
        }
    }
    
    override func update(currentTime: NSTimeInterval) {
     
        var pos : CGFloat = -player.position.y + CGRectGetMidY(frame)
        if pos < world.position.y {
            //println(pos-world.position.y)
            world.position.y = round(pos)
        }
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        viewController?.presentGameScene()
    }
}