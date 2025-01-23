import SwiftUI

struct SlideGameView: View {
    @Binding var showPlay: Bool
    @State var isWin: Bool = false
    @State var level: Int = 0
    var body: some View {
        ZStack {
            Image("IMG_1662 (2) 1")
                .resizable()
                .ignoresSafeArea()
                .scaledToFill()
            
            VStack {
                Spacer().frame(height: UIScreen.main.bounds.height > 667 ? 50 : 70)
                HStack {
                    Spacer()
                    ZStack {
                        Image("table_teenpatti_normal")
                            .resizable()
                            .frame(width: 211, height: 118)
                        Text("Play")
                            .foregroundColor(.white)
                            .font(.custom("Grenze-BoldItalic", size: 40))
                            .padding(.bottom)
                    }
                    .padding(.trailing)
                    Button(action: {
                        withAnimation {
                            showPlay = false
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .fill(Color.red)
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.white, lineWidth: 2)
                                )
                            Image("checkMark")
                                .resizable()
                                .frame(width: 26.69, height: 26.69)
                                .scaledToFit()
                        }
                    }
                    .padding(.trailing)
                }
                
                HStack {
                    CoinView()
                        .padding(.leading)
                    Spacer()
                    LifeView()
                        .padding(.trailing)
                }
                Spacer().frame(height: 50)
                SlideGame(isWin: $isWin, currentLevel: $level)
                    .padding(.leading, UIScreen.main.bounds.height > 667 ? 20 : 10)
                    .onChange(of: isWin) { newLevel in
                        if isWin {
                            var coinsCounter =  UserDefaults.standard.integer(forKey: "coinAmount")
                            coinsCounter += 50
                            UserDefaults.standard.set(coinsCounter, forKey: "coinAmount")
                            
                            if self.level < 11 {
                                self.level += 1
                            }
                            else {
                                self.level = 0
                            }
                            isWin = false
                        }
                    }
                Spacer()
            }
        }
    }
}

#Preview {
    SlideGameView(showPlay: .constant(true))
}
