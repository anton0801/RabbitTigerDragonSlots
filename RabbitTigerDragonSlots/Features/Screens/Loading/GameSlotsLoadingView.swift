import SwiftUI

struct GameSlotsLoadingView: View {
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var timeRemaining = 10
    @State private var passToGame = false
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Image("loading_icon")
                    .resizable()
                    .frame(width: 240, height: 240)
                Spacer()
                Text("Loading...")
                    .font(.custom("Shojumaru-Regular", size: 32))
                    .foregroundColor(Color.init(red: 217/255, green: 33/255, blue: 33/255))
                    .shadow(color: .white, radius: 1, x: 1)
                    .shadow(color: .white, radius: 1, x: -1)
                
                NavigationLink(destination: ContentView()
                    .navigationBarBackButtonHidden(), isActive: $passToGame) {
                        
                    }
            }
            .background(
                Image("loading_back")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
            .onReceive(timer) { _ in
                if timeRemaining > 0 {
                    timeRemaining -= 1
                } else {
                    passToGame = true
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

#Preview {
    GameSlotsLoadingView()
}
