import SwiftUI

struct GameOptionsView: View {
    
    @State var musicOptionsState = UserDefaults.standard.integer(forKey: "music_state")
    @State var soundOptionsState = UserDefaults.standard.integer(forKey: "sound_state")
    
    var body: some View {
        VStack(spacing: 52) {
            HStack {
                Image("icon_music")
                    .resizable()
                    .frame(width: 92, height: 92)
                VStack(spacing: 0) {
                    Text("MUSIC")
                        .font(.custom("Shojumaru-Regular", size: 24))
                        .foregroundColor(Color.init(red: 217/255, green: 33/255, blue: 33/255))
                        .shadow(color: .white, radius: 1, x: 1)
                        .shadow(color: .white, radius: 1, x: -1)
                    
                    Button {
                        if musicOptionsState == 0 {
                            withAnimation(.linear) {
                                musicOptionsState = 1
                            }
                        } else {
                            withAnimation(.linear) {
                                musicOptionsState = 0
                            }
                        }
                    } label: {
                        if musicOptionsState == 1 {
                            Image("volume_on")
                                .resizable()
                                .frame(width: 200, height: 30)
                        } else {
                            Image("volume_off")
                                .resizable()
                                .frame(width: 200, height: 30)
                        }
                    }
                }
                .padding(.top)
            }
            
            HStack {
                Image("icon_sound")
                    .resizable()
                    .frame(width: 92, height: 92)
                VStack(spacing: 0) {
                    Text("SOUND")
                        .font(.custom("Shojumaru-Regular", size: 24))
                        .foregroundColor(Color.init(red: 217/255, green: 33/255, blue: 33/255))
                        .shadow(color: .white, radius: 1, x: 1)
                        .shadow(color: .white, radius: 1, x: -1)
                    
                    Button {
                        if soundOptionsState == 0 {
                            withAnimation(.linear) {
                                soundOptionsState = 1
                            }
                        } else {
                            withAnimation(.linear) {
                                soundOptionsState = 0
                            }
                        }
                    } label: {
                        if soundOptionsState == 1 {
                            Image("volume_on")
                                .resizable()
                                .frame(width: 200, height: 30)
                        } else {
                            Image("volume_off")
                                .resizable()
                                .frame(width: 200, height: 30)
                        }
                    }
                }
                .padding(.top)
            }
        }
        .onChange(of: musicOptionsState) { newValue in
            UserDefaults.standard.set(musicOptionsState, forKey: "music_state")
        }
        .onChange(of: soundOptionsState) { newValue in
            UserDefaults.standard.set(soundOptionsState, forKey: "music_state")
        }
    }
}

#Preview {
    GameOptionsView()
}
