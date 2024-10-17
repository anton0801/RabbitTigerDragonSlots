import SpriteKit
import SwiftUI

class SlotGameScene: SKScene {
    
    var slotId: String
    
    private var userBalance: Int = UserDefaults.standard.integer(forKey: "user_balance") {
    didSet {
            UserDefaults.standard.integer(forKey: "user_balance")
            userBalanceLabel.text = "\(userBalance)"
        }
    }
    private var userBalanceLabel: SKLabelNode = SKLabelNode(text: "")
    
    private var winForSpin: Int = 0 {
        didSet {
            winForSpinLabel.text = "\(winForSpin)"
        }
    }
    private var winForSpinLabel: SKLabelNode = SKLabelNode(text: "0")
    
    private var currentBet = 50 {
        didSet {
            currentBetLabel.text = "\(currentBet)"
        }
    }
    private var currentBetLabel: SKLabelNode = SKLabelNode(text: "50")
    
    init(slotId: String) {
        self.slotId = slotId
        super.init(size: CGSize(width: 2400, height: 2000))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var barabanItem1: BarabanItemNode!
    private var barabanItem2: BarabanItemNode!
    private var barabanItem3: BarabanItemNode!
    private var barabanItem4: BarabanItemNode!
    private var barabanItem5: BarabanItemNode!
    private var barabanItem6: BarabanItemNode!
    
    private var autoSpinBtb: SKSpriteNode!
    private var autoSpin = false
    
    override func didMove(to view: SKView) {
        size = CGSize(width: 2400, height: 2000)
        
        createBackground()
        createGameUI()
    }
    
    private func createBackground() {
        let backgroundDynamicImage = SKSpriteNode(imageNamed: "\(slotId)_slot_bg")
        backgroundDynamicImage.size = size
        backgroundDynamicImage.position = CGPoint(x: size.width / 2, y: size.height / 2)
        backgroundDynamicImage.zPosition = -1
        addChild(backgroundDynamicImage)
    }
    
    private func createGameUI() {
        let userBalanceBackground = SKSpriteNode(imageNamed: "balance_background")
        userBalanceBackground.position = CGPoint(x: 300, y: 200)
        userBalanceBackground.size = CGSize(width: 400, height: 250)
        addChild(userBalanceBackground)
        
        userBalanceLabel = .init(text: "\(userBalance)")
        userBalanceLabel.position = CGPoint(x: 300, y: 180)
        userBalanceLabel.fontSize = 62
        userBalanceLabel.fontName = "Shojumaru-Regular"
        userBalanceLabel.fontColor = UIColor.init(red: 1, green: 225/255, blue: 112/255, alpha: 1)
        addChild(userBalanceLabel)
        
        let winForSpinBackground = SKSpriteNode(imageNamed: "win_for_spin")
        winForSpinBackground.position = CGPoint(x: 725, y: 200)
        winForSpinBackground.size = CGSize(width: 350, height: 250)
        addChild(winForSpinBackground)
        
        winForSpinLabel = .init(text: "0")
        winForSpinLabel.position = CGPoint(x: 725, y: 160)
        winForSpinLabel.fontSize = 42
        winForSpinLabel.fontName = "Shojumaru-Regular"
        winForSpinLabel.fontColor = UIColor.init(red: 1, green: 225/255, blue: 112/255, alpha: 1)
        addChild(winForSpinLabel)
        
        let betBackground = SKSpriteNode(imageNamed: "bet_background")
        betBackground.position = CGPoint(x: size.width / 2, y: 200)
        betBackground.size = CGSize(width: 450, height: 250)
        addChild(betBackground)
        
        currentBetLabel = .init(text: "\(currentBet)")
        currentBetLabel.position = CGPoint(x: size.width / 2, y: 180)
        currentBetLabel.fontSize = 72
        currentBetLabel.fontName = "Shojumaru-Regular"
        currentBetLabel.fontColor = UIColor.init(red: 1, green: 225/255, blue: 112/255, alpha: 1)
        addChild(currentBetLabel)
        
        let betPlusBtn = SKSpriteNode(imageNamed: "bet_plus")
        betPlusBtn.size = CGSize(width: 90, height: 110)
        betPlusBtn.position = CGPoint(x: size.width / 2 + 150, y: 200)
        betPlusBtn.name = "bet_plus"
        addChild(betPlusBtn)
        
        let betMinusBtn = SKSpriteNode(imageNamed: "bet_minus")
        betMinusBtn.size = CGSize(width: 90, height: 110)
        betMinusBtn.position = CGPoint(x: size.width / 2 - 150, y: 200)
        betMinusBtn.name = "bet_minus"
        addChild(betMinusBtn)
        
        let maxBetBtn = SKSpriteNode(imageNamed: "max_bet")
        maxBetBtn.position = CGPoint(x: size.width / 2 + 370, y: 200)
        maxBetBtn.name = "max_bet"
        maxBetBtn.size = CGSize(width: 170, height: 250)
        addChild(maxBetBtn)
        
        autoSpinBtb = SKSpriteNode(imageNamed: "auto_spin")
        autoSpinBtb.position = CGPoint(x: size.width / 2 + 600, y: 200)
        autoSpinBtb.name = "auto_spin"
        autoSpinBtb.alpha = 1.0
        autoSpinBtb.size = CGSize(width: 170, height: 250)
        addChild(autoSpinBtb)
        
        let spinBtn = SKSpriteNode(imageNamed: "spin_buttton")
        spinBtn.position = CGPoint(x: size.width - 250, y: 200)
        spinBtn.name = "spin_btn"
        spinBtn.size = CGSize(width: 430, height: 250)
        addChild(spinBtn)
        
        let slotsBackground = SKSpriteNode(imageNamed: "slot_background")
        slotsBackground.position = CGPoint(x: size.width / 2, y: size.height / 2 + 200)
        slotsBackground.size = CGSize(width: slotsBackground.size.width, height: 1300)
        addChild(slotsBackground)
        
        let homeButton = SKSpriteNode(imageNamed: "home_buttton")
        homeButton.position = CGPoint(x: 200, y: size.height - 200)
        homeButton.size = CGSize(width: 160, height: 270)
        homeButton.name = "home_button"
        addChild(homeButton)
        
        let barabanSymbols = getBarabanSymbols()
        
        barabanItem1 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem1.position = CGPoint(x: size.width / 2 - 570, y: size.height / 2 + 200)
        barabanItem1.name = "baraban_first"
        addChild(barabanItem1)
        
        barabanItem2 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem2.position = CGPoint(x: size.width / 2 - 335, y: size.height / 2 + 200)
        barabanItem2.name = "baraban_second"
        addChild(barabanItem2)
        
        barabanItem3 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem3.position = CGPoint(x: size.width / 2 - 100, y: size.height / 2 + 200)
        barabanItem3.name = "baraban_third"
        addChild(barabanItem3)
        
        barabanItem4 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem4.position = CGPoint(x: size.width / 2 + 135, y: size.height / 2 + 200)
        barabanItem4.name = "baraban_fourt"
        addChild(barabanItem4)
        
        barabanItem5 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem5.position = CGPoint(x: size.width / 2 + 370, y: size.height / 2 + 200)
        barabanItem5.name = "baraban_fourt"
        addChild(barabanItem5)
        
        barabanItem6 = BarabanItemNode(slotId: slotId, symbols: barabanSymbols, size: CGSize(width: 250, height: 1200), endCallback: nil)
        barabanItem6.position = CGPoint(x: size.width / 2 + 600, y: size.height / 2 + 200)
        barabanItem6.name = "baraban_fourt"
        addChild(barabanItem6)
    }
    
    private func getBarabanSymbols() -> [String] {
        var result: [String] = []
        let countOfSymbols = SymbolsData.getCountOfSymbolsForSlotId(slotId: slotId)
        for i in 1...countOfSymbols {
            result.append("\(slotId)_\(i)")
        }
        return result
    }
    
    private func animatePressButton(node: SKNode) {
        node.run(SKAction.sequence([SKAction.fadeAlpha(to: 0.6, duration: 0.2), SKAction.fadeAlpha(to: 1, duration: 0.2)]))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touchedArea = touches.first {
            let objectInTouchedArea = atPoint(touchedArea.location(in: self))
            
            if objectInTouchedArea.name == "home_button" {
                animatePressButton(node: objectInTouchedArea)
                NotificationCenter.default.post(name: Notification.Name("home_back"), object: nil)
            }
            
            if objectInTouchedArea.name == "bet_minus" {
                animatePressButton(node: objectInTouchedArea)
                if currentBet > 50 {
                    currentBet -= 50
                }
            }
            
            if objectInTouchedArea.name == "bet_plus" {
                animatePressButton(node: objectInTouchedArea)
                if currentBet < 1000 {
                    currentBet += 50
                }
            }
            
            if objectInTouchedArea.name == "max_bet" {
                animatePressButton(node: objectInTouchedArea)
                currentBet = 1000
            }
            
            if objectInTouchedArea.name == "auto_spin" {
                if autoSpin {
                    autoSpin = false
                    autoSpinBtb.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
                } else {
                    autoSpin = true
                    autoSpinBtb.run(SKAction.fadeAlpha(to: 0.6, duration: 0.3))
                }
                startAutoSpin()
            }
            
            if objectInTouchedArea.name == "spin_btn" {
                animatePressButton(node: objectInTouchedArea)
                if userBalance >= currentBet {
                    spinBarabans()
                    userBalance -= currentBet
                } else {
                    NotificationCenter.default.post(name: Notification.Name("not_balance"), object: nil)
                }
            }
        }
    }
    
    private func spinBarabans() {
        barabanItem1.spinBaraban()
        doActionAfterNTime(n: 0.1) {
            self.barabanItem2.spinBaraban()
        }
        doActionAfterNTime(n: 0.2) {
            self.barabanItem3.spinBaraban()
        }
        doActionAfterNTime(n: 0.3) {
            self.barabanItem4.spinBaraban()
        }
        doActionAfterNTime(n: 0.4) {
            self.barabanItem5.spinBaraban()
        }
        doActionAfterNTime(n: 0.5) {
            self.barabanItem6.spinBaraban()
        }
    }
    
    private func startAutoSpin() {
        if autoSpin {
            if userBalance >= currentBet {
                barabanItem1.spinBaraban()
                doActionAfterNTime(n: 0.1) {
                    self.barabanItem2.spinBaraban()
                }
                doActionAfterNTime(n: 0.2) {
                    self.barabanItem3.spinBaraban()
                }
                doActionAfterNTime(n: 0.3) {
                    self.barabanItem4.spinBaraban()
                }
                doActionAfterNTime(n: 0.4) {
                    self.barabanItem5.spinBaraban()
                }
                doActionAfterNTime(n: 0.5) {
                    self.barabanItem6.spinBaraban()
                }
                userBalance -= currentBet
                doActionAfterNTime(n: 1.5) {
                    self.startAutoSpin()
                }
            } else {
                autoSpin = false
                autoSpinBtb.run(SKAction.fadeAlpha(to: 1, duration: 0.3))
                NotificationCenter.default.post(name: Notification.Name("not_balance"), object: nil)
            }
        }
    }
    
    private func doActionAfterNTime(n: Double, callback: @escaping () -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + n) {
            callback()
        }
    }
    
}

#Preview {
    VStack {
        SpriteView(scene: SlotGameScene(slotId: "tiger"))
            .ignoresSafeArea()
    }
}
