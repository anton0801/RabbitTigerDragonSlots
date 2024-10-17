import SwiftUI

struct RulesGameView: View {
    
    var games = ["RABBIT SLOT", "TIGER SLOT", "DRAGON SLOT"]
    var rules: [String: [String]] = [
        "RABBIT SLOT": ["rabbit_slot_rules_1", "rabbit_slot_rules_2", "rabbit_slot_rules_3"],
        "TIGER SLOT": ["tiger_slot_rules_1", "tiger_slot_rules_2", "tiger_slot_rules_3"],
        "DRAGON SLOT": ["dragon_slot_rules_1", "dragon_slot_rules_2", "dragon_slot_rules_3"]
    ]
    @State var selectedGame: String = "RABBIT SLOT"
    @State var selectedGameIndex = 0
    @State var rulesSelectedItem = 0
    
    var body: some View {
        VStack {
            Text("RULES")
                .font(.custom("Shojumaru-Regular", size: 32))
                .foregroundColor(Color.init(red: 217/255, green: 33/255, blue: 33/255))
                .shadow(color: .white, radius: 1, x: 1)
                .shadow(color: .white, radius: 1, x: -1)
            HStack {
                Button {
                    if selectedGameIndex > 0 {
                        withAnimation(.easeInOut) {
                            selectedGameIndex -= 1
                        }
                    }
                } label: {
                    Text("<")
                        .font(.custom("Shojumaru-Regular", size: 32))
                        .foregroundColor(Color.init(red: 247/255, green: 187/255, blue: 94/255))
                        .shadow(color: .white, radius: 1, x: 1)
                        .shadow(color: .white, radius: 1, x: -1)
                }
                Text("\(selectedGame)")
                    .font(.custom("Shojumaru-Regular", size: 32))
                    .foregroundColor(Color.init(red: 247/255, green: 187/255, blue: 94/255))
                    .shadow(color: .white, radius: 1, x: 1)
                    .shadow(color: .white, radius: 1, x: -1)
                
                Button {
                    withAnimation(.easeInOut) {
                        selectedGameIndex += 1
                    }
                } label: {
                    Text(">")
                        .font(.custom("Shojumaru-Regular", size: 32))
                        .foregroundColor(Color.init(red: 247/255, green: 187/255, blue: 94/255))
                        .shadow(color: .white, radius: 1, x: 1)
                        .shadow(color: .white, radius: 1, x: -1)
                }
            }
            
            Spacer()
            
            Image(rules[selectedGame]![rulesSelectedItem])
                .resizable()
                .frame(width: 400, height: 200)
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    if rulesSelectedItem > 0 {
                        withAnimation(.easeInOut) {
                            rulesSelectedItem -= 1
                        }
                    }
                } label: {
                    Image("arrow_back")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
                
                Text("\(rulesSelectedItem + 1)/\(rules[selectedGame]!.count)")
                    .font(.custom("Shojumaru-Regular", size: 24))
                    .foregroundColor(Color.init(red: 247/255, green: 187/255, blue: 94/255))
                    .shadow(color: .white, radius: 1, x: 1)
                    .shadow(color: .white, radius: 1, x: -1)
                
                Button {
                    if rulesSelectedItem < rules[selectedGame]!.count - 1 {
                        withAnimation(.easeInOut) {
                            rulesSelectedItem += 1
                        }
                    }
                } label: {
                    Image("arrow_next")
                        .resizable()
                        .frame(width: 40, height: 40)
                }
            }
            
        }
        .onChange(of: selectedGameIndex) { newValue in
            withAnimation(.easeInOut) {
                selectedGame = games[newValue]
                print(selectedGame)
                rulesSelectedItem = 0
            }
        }
    }
}

#Preview {
    RulesGameView()
}
