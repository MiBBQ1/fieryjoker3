import SwiftUI

struct PlayView: View {
    @Binding var showPlay: Bool
    @State var showSlide: Bool = false
    @State var showSaper: Bool = false
    
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
                PlayVierw(imageName: "Rectangle 323",
                          title: "Play Sapper   ")
                { withAnimation { showSaper = true } }
                PlayVierw(imageName: "Frame 1244831303",
                          title: "Escape Quest")
                { withAnimation { showSlide = true } }
                Spacer()
            }
            if showSlide {
                SlideGameView(showPlay: $showSlide)
                    .zIndex(3.0)
            }
            if showSaper {
                SapperGameView(showPlay: $showSaper)
                    .zIndex(3.0)
            }
            
        }
    }
}

#Preview {
    PlayView(showPlay: .constant(true))
}
