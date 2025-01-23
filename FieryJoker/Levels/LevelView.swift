import SwiftUI

struct LevelView: View {
    @Binding var showPlay: Bool
    @State var showAbout: Bool = false
    @State private var openLevels: Int = UserDefaults.standard.integer(forKey: "openLevels")
    
    var body: some View {
        ZStack {
            Image("IMG_1662 (2) 1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height > 667 ? 50 : 70)
                HStack {
                    Button(action: {
                        withAnimation { showPlay = false }
                    }) {
                        Image("IMG_1694 1")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .scaledToFit()
                        
                    }
                    .padding(.leading)
                    Spacer()
                    ZStack {
                        Image("table_teenpatti_normal")
                            .resizable()
                            .frame(width: 211, height: 118)
                        Text("Levels")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .padding(.bottom)
                    }
                    .padding(.trailing, 70)
                    Spacer()
                }
                
                HStack {
                    CoinView()
                        .padding(.leading)
                    Spacer()
                    LifeView()
                        .padding(.trailing)
                }
                Spacer()
                    .frame(height: 50)
                
                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 3)
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 15) {
                        ForEach(1...15, id: \.self) { level in
                            Button(action: {
                                
                            }) {
                                LevelButtonView(level: level, isOpen: level <= openLevels+1)
                            }
                        }
                    }
                    .padding(.horizontal, 5)
                    Spacer()
                        .frame(height: 50)
                }
                Button(action: {
                    withAnimation {
                        showAbout = true
                    }
                }) {
                    ZStack {
                        Image("Button Framed")
                            .resizable()
                            .frame(width: 236, height: 80)
                            .scaledToFill()
                        Text("About")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .frame(width: 236, height: 80)
                    }
                }
                .padding(.bottom, UIScreen.main.bounds.height > 667 ? 30 : 120)
            }
            if showAbout {
                AboutView(showAbout: $showAbout)
                    .zIndex(3.0)
            }
        }
    }
}

#Preview {
    LevelView(showPlay: .constant(true))
}
