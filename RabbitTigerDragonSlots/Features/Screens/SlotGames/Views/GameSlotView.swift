import SwiftUI
import SpriteKit

struct GameSlotView: View {
    
    @Environment(\.presentationMode) var presMode
    var slotId: String
    
    @State var slotgameScene: SlotGameScene!
    
    @State var goHomeAlertVisible = false
    @State var alertNotCoinsVisible = false
    
    var body: some View {
        ZStack {
            if let scene = slotgameScene {
                SpriteView(scene: scene)
                    .ignoresSafeArea()
            }
            
            if goHomeAlertVisible {
                ZStack {
                    VStack(spacing: 24) {
                        Text("DO YOU WANT TO\nLEAVE THE GAME?")
                            .font(.custom("Shojumaru-Regular", size: 24))
                            .foregroundColor(Color.init(red: 217/255, green: 33/255, blue: 33/255))
                            .multilineTextAlignment(.center)
                            .shadow(color: .white, radius: 1, x: 1)
                            .shadow(color: .white, radius: 1, x: -1)
                        
                        Button {
                            withAnimation(.easeOut) {
                                goHomeAlertVisible = false
                            }
                        } label: {
                            Image("stay")
                                .resizable()
                                .frame(width: 180, height: 60)
                        }
                        
                        Button {
                            presMode.wrappedValue.dismiss()
                        } label: {
                            Image("leave")
                                .resizable()
                                .frame(width: 180, height: 60)
                        }
                    }
                    
                    if slotId == "rabbit" || slotId == "tiger" {
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Image(slotId)
                                    .resizable()
                                    .frame(width: 200, height: 250)
                            }
                        }
                    } else {
                        VStack {
                            Spacer()
                            HStack {
                                Image(slotId)
                                    .resizable()
                                    .frame(width: 200, height: 250)
                                Spacer()
                            }
                        }
                    }
                }
                .frame(minWidth: UIScreen.main.bounds.width,
                       minHeight: UIScreen.main.bounds.height + 20)
                .ignoresSafeArea()
                .background(
                    BlurEffectView(style: .dark)
                )
            }
        }
        .onAppear {
            slotgameScene = SlotGameScene(slotId: slotId)
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("home_back"))) { _ in
            withAnimation(.easeIn) {
                goHomeAlertVisible = true
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("not_balance"))) { _ in
            alertNotCoinsVisible.toggle()
        }
        .alert(isPresented: $alertNotCoinsVisible) {
            Alert(
                title: Text("Alert"),
                message: Text("Not enought coins in your balance! Please reduce the bet!"),
                dismissButton: .default(Text("Ok"))
            )
        }
    }
}

#Preview {
    GameSlotView(slotId: "dragon")
}

struct BlurEffectView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        // Обновляем эффект если нужно
        uiView.effect = UIBlurEffect(style: style)
    }
}
