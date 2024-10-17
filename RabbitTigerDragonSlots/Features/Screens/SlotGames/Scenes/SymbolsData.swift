import Foundation

class SymbolsData {
    
    private static let symbolsData: [String: Int] = [
        "dragon": 9,
        "tiger": 10,
        "rabbit": 9
    ]
    
    static func getCountOfSymbolsForSlotId(slotId: String) -> Int {
        symbolsData[slotId]!
    }
    
}
