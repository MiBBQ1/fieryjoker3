import SwiftUI

struct CoinView: View {
    @AppStorage("coinAmount") private var coinAmount: Int = 0 

    var body: some View {
        ZStack {
            Image("coin_background")
                .resizable()
                .frame(width: 110, height: 46.48)
                .scaledToFill()

            
                Text("\(coinAmount)")
                .font(.custom("Grenze-Bold", size: 24.28))
                    .foregroundColor(.white)
                    .padding(.trailing)
                    
        }
        .frame(width: 110, height: 46.48)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 2)  
    }
}

struct CoinView_Previews: PreviewProvider {
    static var previews: some View {
        CoinView()
    }
}
