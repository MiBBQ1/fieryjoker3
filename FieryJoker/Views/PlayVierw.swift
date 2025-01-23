import SwiftUI

struct PlayVierw: View {
    let imageName: String
    let title: String
    let buttonAction: () -> Void

    var body: some View {
        ZStack {
            Color(hex: "#3A0000")
                .cornerRadius(10)

            HStack(spacing: 16) {
                Image(imageName)
                    .resizable()
                    .frame(width: 136, height: 113)
                    .cornerRadius(16)

                Spacer()
                VStack(alignment: .leading, spacing: 8) {
                    Text(title)
                        .font(.custom("Grenze-Bold", size: 24.28))
                        .foregroundColor(.white)

                    Button(action: buttonAction) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color(hex: "#FFD83C"))
                                .frame(width: 75, height: 40)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(hex: "#B6A187"), lineWidth: 2)
                                )

                            Image(systemName: "play.fill")
                                .foregroundColor(.white)
                        }
                    }
                }
                
            }
            .padding(.horizontal, 16)
        }
        .frame(width: 350, height: 129)
    }
}
struct PlayVierw_Previews: PreviewProvider {
    static var previews: some View {
        PlayVierw(imageName: "Rectangle 323", title: "Play Now") {
            print("Button tapped")
        }
    }
}
