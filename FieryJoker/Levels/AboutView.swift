import SwiftUI

struct AboutView: View {
    @Binding var showAbout: Bool
    
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
                        withAnimation { showAbout = false }
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
                        Text("About")
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
                
                ScrollView {
                    Text(
                    """
                    Deep within the shadows of the digital realm, the Joker is held captive in an enigmatic labyrinth—a prison crafted by the world's greatest tricksters. To free him, a brave soul must prove their cunning and persistence by passing a gauntlet of challenges: 15 perilous games of Minesweeper. Each victory earns a key, and all 15 keys are required to unlock the Joker's chains.
                    
                    But beware—this is no easy feat. The path is fraught with limits. You have only three attempts per day to face the Minesweeper trials. Every failed attempt will deplete your lives, ticking the counter closer to 0/3. Once all lives are spent, you must wait for the clock to turn, as the counter resets to 3/3 with the dawn of a new day.
                    
                    If patience is not your strength, you can channel your energy elsewhere. The Slide game, a test of wits with no restrictions, is always available. Conquer its puzzles at your leisure to sharpen your mind and keep your spirit alive for the Joker’s liberation.
                    
                    The challenge is set, the Joker’s fate lies in your hands. Will you rise to the occasion and outsmart the labyrinth, or will the chains remain unbroken? The clock is ticking, hero. Choose your path wisely.
                    
                    """
                    )
                    .multilineTextAlignment(.center)
                    .font(.custom("Grenze-Regular", size: 27))
                    .foregroundColor(.white)
                    .padding(.horizontal)
                    
                    Spacer()
                        .frame(height: 50)
                }
            }
        }
    }
}

#Preview {
    AboutView(showAbout: .constant(true))
}
