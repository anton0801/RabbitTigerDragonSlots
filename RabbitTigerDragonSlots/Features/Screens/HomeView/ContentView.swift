import SwiftUI

struct ContentView: View {
    
    @State var selectedPage = 0
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        Button {
                            selectedPage = 0
                        } label: {
                            Image("home")
                                .resizable()
                                .frame(width: 140, height: 60)
                        }
                        Button {
                            selectedPage = 1
                        } label: {
                            Image("rules")
                                .resizable()
                                .frame(width: 140, height: 60)
                        }
                        Button {
                            selectedPage = 2
                        } label: {
                            Image("options")
                                .resizable()
                                .frame(width: 140, height: 60)
                        }
                    }
                    Spacer()
                    
                    if selectedPage == 0 {
                        HomeView()
                    } else if selectedPage == 1 {
                        RulesGameView()
                    } else if selectedPage == 2 {
                        GameOptionsView()
                    }
                    
                    Spacer()
                }
                .edgesIgnoringSafeArea(.leading)
            }
            .edgesIgnoringSafeArea(.leading)
            .background(
                Image("main_background")
                    .resizable()
                    .frame(minWidth: UIScreen.main.bounds.width,
                           minHeight: UIScreen.main.bounds.height + 20)
                    .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    ContentView()
}
