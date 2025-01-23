import SwiftUI

struct LevelButtonView: View {
    let level: Int
    let isOpen: Bool 
    
    var body: some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(
                        gradient: isOpen ? Gradient(colors: [Color(hex: "EBAA01"), Color(hex: "#FFDE87")]) :
                            Gradient(colors: [Color(hex: "#414141"), Color(hex: "#A7A7A7")]),
                        center: .center,
                        startRadius: 0,
                        endRadius: 50
                    )
                )
                .frame(width: 89.66, height: 89.66)

            Image(isOpen ? "key" : "lock")
                .resizable()
                .frame(width: 50.45, height: 50.45)
            ZStack {
                Rectangle()
                    .fill(Color(hex: "#9E1838"))
                    .frame(width: 87.68, height: 28.58)
                    .cornerRadius(10)
                Text("Level \(level)")
                    .font(.custom("Grenze-Bold", size: 17.05))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(width: 87.68, height: 28.58)
            }
            .padding(.top, 80)
        }
    }
}
