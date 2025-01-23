import SwiftUI

struct MunuView: View {
    @State var playShow: Bool = false
    @State var shopShow: Bool = false
    @State var levelShow: Bool = false
    
    @State private var purchasedCovers: [Int] = UserDefaults.standard.array(forKey: "purchasedCovers") as? [Int] ?? [0] {
        didSet { UserDefaults.standard.set(purchasedCovers, forKey: "purchasedCovers") }
    }

    @State private var selectedIndex: Int = UserDefaults.standard.integer(forKey: "selectedCover") {
        didSet { UserDefaults.standard.set(selectedIndex, forKey: "selectedCover") }
    }
    
    @State private var purchasedMasks: [Int] = UserDefaults.standard.array(forKey: "purchasedMasks") as? [Int] ?? [0] {
        didSet { UserDefaults.standard.set(purchasedCovers, forKey: "purchasedMasks") }
    }

    @State private var selectedMask: Int = UserDefaults.standard.integer(forKey: "selectedMask") {
        didSet { UserDefaults.standard.set(selectedMask, forKey: "selectedMask") }
    }
    
    var body: some View {
        ZStack {
            Image("IMG_1662 (2) 1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
               
            VStack {
                ZStack {
                    Image("table_teenpatti_normal")
                        .resizable()
                        .frame(width: 211, height: 118)
                    Text("Home")
                        .foregroundColor(.white)
                        .font(.custom("Grenze-BoldItalic", size: 40))
                        .padding(.bottom)
                }
                
                HStack {
                    CoinView()
                        .padding(.leading)
                    Spacer()
                    LifeView()
                        .padding(.trailing)
                }
                
                Image("mask\(selectedMask)")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height > 667 ? 265 : 236,
                           height: UIScreen.main.bounds.height > 667 ? 265 : 236)
                
                Button(action: {
                    withAnimation {
                        shopShow = true
                    }
                }) {
                    ZStack {
                        Image("Button Framed")
                            .resizable()
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                            .scaledToFill()
                        Text("Shop")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                    }
                }
                Button(action: {
                    withAnimation {
                        playShow = true
                    }
                }) {
                    ZStack {
                        Image("Button Framed")
                            .resizable()
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                            .scaledToFill()
                        Text("Play")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                    }
                }
                Button(action: {
                    withAnimation {
                        levelShow = true
                    }
                }) {
                    ZStack {
                        Image("Button Framed")
                            .resizable()
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                            .scaledToFill()
                        Text("Levels")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .frame(width: 236, height: UIScreen.main.bounds.height > 667 ? 80 : 65)
                    }
                }
            }
            if playShow {
                PlayView(showPlay: $playShow)
                    .zIndex(2.0)
            }
            if shopShow {
                ShopView(showPlay: $shopShow,
                         selectedTile: $selectedIndex,
                         selectedMask: $selectedMask,
                         purchasedCovers: $purchasedCovers,
                         purchasedMasks: $purchasedMasks)
                    .zIndex(2.0)
            }
            if levelShow {
                LevelView(showPlay: $levelShow)
                    .zIndex(2.0)
            }
        }
    }
}

#Preview {
    MunuView()
}
