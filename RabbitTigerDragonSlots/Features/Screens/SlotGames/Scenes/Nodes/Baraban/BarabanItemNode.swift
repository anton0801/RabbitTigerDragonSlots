import SpriteKit

class BarabanItemNode: SKSpriteNode {
    
    var chinaStylesSymbols: [String]
    var slotId: String
    private let nodeCrop: SKCropNode
    var spinBarabanEndCallback: (() -> Void)?
    private let nodeParentOfBaraban: SKNode
    var reversedSpinBaraban = false
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(slotId: String, symbols: [String], size: CGSize, endCallback: (() -> Void)?) {
        self.chinaStylesSymbols = symbols
        self.slotId = slotId
        self.nodeCrop = SKCropNode()
        self.spinBarabanEndCallback = endCallback
        self.nodeParentOfBaraban = SKNode()
        super.init(texture: nil, color: .clear, size: size)
        setUpAllSymbolsAndBaraban()
    }
    
    func spinBaraban() {
        if reversedSpinBaraban {
            let spinAction = SKAction.moveBy(x: 0, y: -(410.5 * CGFloat(Int.random(in: 4...6))), duration: 0.5)
            reversedSpinBaraban = false
            nodeParentOfBaraban.run(spinAction) {
                self.spinBarabanEndCallback?()
            }
        } else {
            let spinAction = SKAction.moveBy(x: 0, y: 410.5 * CGFloat(Int.random(in: 4...6)), duration: 0.5)
            reversedSpinBaraban = true
            nodeParentOfBaraban.run(spinAction) {
                self.spinBarabanEndCallback?()
            }
        }
    }
    
    private func setUpAllSymbolsAndBaraban() {
        nodeCrop.position = CGPoint(x: 0, y: 0)
        let nodeMask = SKSpriteNode(color: .black, size: size)
        nodeMask.position = CGPoint(x: 0, y: 0)
        nodeCrop.maskNode = nodeMask
        addChild(nodeCrop)
        
        nodeCrop.addChild(nodeParentOfBaraban)
        
        let conditionToAddScatterToBaraban = Bool.random() && Bool.random()
        if conditionToAddScatterToBaraban {
            self.chinaStylesSymbols.append("\(slotId)_scatter")
        }
        
        let symbolsShuffled = chinaStylesSymbols.shuffled()
        for i in 0..<chinaStylesSymbols.count * 8 {
            let nameSymbol = symbolsShuffled[i % chinaStylesSymbols.count]
            let slotSymbol = SKSpriteNode(imageNamed: nameSymbol)
            slotSymbol.size = CGSize(width: 170, height: 310)
            slotSymbol.name = nameSymbol
            slotSymbol.zPosition = 1
            slotSymbol.position = CGPoint(x: 0, y: size.height - CGFloat(i) * 410.5)
            nodeParentOfBaraban.addChild(slotSymbol)
        }
        
        nodeParentOfBaraban.run(SKAction.moveBy(x: 0, y: 410.5 * CGFloat(chinaStylesSymbols.count * 3), duration: 0.0))
    }

    
}


