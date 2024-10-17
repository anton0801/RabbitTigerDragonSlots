import SwiftUI

struct HomeView: View {
    var body: some View {
        HStack {
            Spacer()
            NavigationLink(destination: GameSlotView(slotId: "rabbit")
                .navigationBarBackButtonHidden()) {
                Image("rabbit_slot")
                    .resizable()
                    .frame(width: 150, height: 200)
            }
            Spacer()
            NavigationLink(destination: GameSlotView(slotId: "tiger")
                .navigationBarBackButtonHidden()) {
                Image("tiger_slot")
                    .resizable()
                    .frame(width: 150, height: 200)
            }
            Spacer()
            NavigationLink(destination: GameSlotView(slotId: "dragon")
                .navigationBarBackButtonHidden()) {
                Image("dragon_slot")
                    .resizable()
                    .frame(width: 150, height: 200)
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}
