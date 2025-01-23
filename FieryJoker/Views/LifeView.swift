import SwiftUI

struct LifeView: View {
    @AppStorage("lives") private var lives: Int = 3
    @AppStorage("lastPlayedDate") private var lastPlayedDate: String = ""
    
    var body: some View {
        ZStack {
            Image("life_background")
                .resizable()
                .frame(width: 110, height: 46.48)
                .scaledToFill()
            
            Text("\(lives)/3")
                .font(.custom("Grenze-Bold", size: 24.28))
                .foregroundColor(.white)
                .padding(.trailing)
        }
        .frame(width: 110, height: 46.48)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)
        .onAppear {
            checkLives()
        }
    }
    
    private func checkLives() {
        let currentDate = getCurrentDate()
        if lastPlayedDate != currentDate { 
            lives = 3
            lastPlayedDate = currentDate
        } else if lives <= 0 {
            
        }
    }
    
    private func getCurrentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }
}

struct LifeView_Previews: PreviewProvider {
    static var previews: some View {
        LifeView()
    }
}
